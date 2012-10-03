package org.as3.mvcsc
{
	
	import org.as3.bridge.interfaces.IBridgeProcess;
	import org.as3.mvcsc.descriptors.DescriptorAppFrameWork;
	import org.as3.mvcsc.descriptors.DescriptorBackgroundProcess;
	import org.as3.mvcsc.descriptors.DescriptorCore;
	import org.as3.mvcsc.descriptors.DescriptorExternalAppFrameWork;
	import org.as3.mvcsc.interfaces.IMappingInjector;
	import org.as3.mvcsc.interfaces.IMappingMediator;
	import org.as3.mvcsc.interfaces.IMappingSignalCommand;
	import org.as3.mvcsc.processes.ProcessStartupSequence;
	import org.as3.mvcsc.task.TasksSet;
	import org.as3.mvcsc.utils.UtilsMapping;
	import org.as3.mvcsc.utils.UtilsProcesses;
	import org.as3.mvcsc.vo.BackgroundProcesses;
	import org.as3.mvcsc.vo.Commands;
	import org.as3.mvcsc.vo.Controls;
	import org.as3.mvcsc.vo.Models;
	import org.as3.mvcsc.vo.Services;
	import org.as3.mvcsc.vo.Views;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IMediatorMap;
	import org.robotlegs.core.ISignalCommandMap;

	
	/** 
	 * 
	 * Based on SwiftSuspenders, Signals, and Robotlegs thi class executes the mapping for Model, View, Controls, Services, Commands, and Background Processes
	 * It does so based on compiled time descriptors, and XML descriptors serialized into typed objects
	 * 
	 * @author Mario Vieira
	 * 
	 */
	public class ApplicationFrameWork
	{
		protected var _startSequence					:ProcessStartupSequence;
		protected var _coreDescriptor					:DescriptorCore;
		protected var _appFrameWorkDescriptor			:DescriptorAppFrameWork;
		protected var _signalComplete					:ISignal;
		
		/**
		 * 
		 * 
		 */				
		public function ApplicationFrameWork() 
		{
			_signalComplete			= new Signal();
			_startSequence  		= new ProcessStartupSequence();
		}
		
		/**
		 * 
		 * @param coreDescriptor
		 * @param appFrameWorkDescriptor
		 * @param externalAppFrameWorkDescriptor
		 *  
		 */
		public function initializeFrameWork(coreDescriptor:DescriptorCore, appFrameWorkDescriptor:DescriptorAppFrameWork, externalAppFrameWorkDescriptor:DescriptorExternalAppFrameWork):void
		{
			_coreDescriptor 		= coreDescriptor;
			_appFrameWorkDescriptor = appFrameWorkDescriptor;
			
			createMappings(coreDescriptor, appFrameWorkDescriptor, externalAppFrameWorkDescriptor);	
		}
		
		public function get signalComplete():ISignal
		{
			return _signalComplete;
		}
		
		/**
		 * 
		 * @param coreDescriptor
		 * @param appFrameWorkDescriptor
		 * @param externalAppFrameWorkDescriptor
		 * 
		 */		
		protected function createMappings(coreDescriptor:DescriptorCore, appFrameWorkDescriptor:DescriptorAppFrameWork, externalAppFrameWorkDescriptor:DescriptorExternalAppFrameWork) : void 
		{
			if(appFrameWorkDescriptor)
			{
				//command can only get triggered once all mapping is done
				mapSignalCommands(appFrameWorkDescriptor.commandsMapping, coreDescriptor.signalCommandMap);
				//don't rely on any injection rules
				mapModels(appFrameWorkDescriptor.modelsMapping, coreDescriptor.injector);
				//don't rely on any injection rules
				mapServices(appFrameWorkDescriptor.servicesMapping, coreDescriptor.injector);
				//relies on the others
				mapControls(appFrameWorkDescriptor.controlsMapping, coreDescriptor.injector);
				//relies on the others
				initializeBridge(appFrameWorkDescriptor.bridgeProcess, coreDescriptor.injector);
				//relies on the others
				mapViews(appFrameWorkDescriptor.viewsMapping, coreDescriptor.mediatorMap);
				
				trace('\n');
				trace("------------------------ 1st - INTERNAL APPLICATION FRAME WORK MAPPED ----------------");
			}
			
			if(externalAppFrameWorkDescriptor)
			{
				//1st - command can only get triggered once all mapping is done
				mapExternalSignalCommands(coreDescriptor.signalCommandMap, appFrameWorkDescriptor.commandsMapping, externalAppFrameWorkDescriptor.signalCommandRules);
				//2nd - don't rely on any injection rules
				mapExternalModels(coreDescriptor.injector, appFrameWorkDescriptor.modelsMapping, externalAppFrameWorkDescriptor.modelRules);
				//3rd - don't rely on any injection rules
				mapExternalServices(coreDescriptor.injector, appFrameWorkDescriptor.servicesMapping, externalAppFrameWorkDescriptor.serviceRules);
				//5th - relies on 1st, 2nd, and 3rd
				mapExternalControls(coreDescriptor.injector, appFrameWorkDescriptor.controlsMapping, externalAppFrameWorkDescriptor.controlRules);
				//6th - relies on all
				mapExternalViews(coreDescriptor.mediatorMap, appFrameWorkDescriptor.viewsMapping, externalAppFrameWorkDescriptor.viewRules);
				//4th - relies on 1st, 2nd, and 3rd
				mapBridgeCaringormCommands(appFrameWorkDescriptor.bridgeProcess, coreDescriptor.injector, externalAppFrameWorkDescriptor);
			}
			
			//fires complete after mapping, Tasks and BGProcess are not complete, those are running over and after completion
			if(appFrameWorkDescriptor && !externalAppFrameWorkDescriptor || appFrameWorkDescriptor && externalAppFrameWorkDescriptor)
				complete();
			
			trace("------------------------ 2nd - EXTERNAL APPLICATION FRAME WORK MAPPED ----------------");
			
			if(appFrameWorkDescriptor && appFrameWorkDescriptor.startupSequence)
			{
				initializeStartupSequence(coreDescriptor.injector, appFrameWorkDescriptor.startupSequence);
			}
			else if(externalAppFrameWorkDescriptor)
			{
				initializeBackgrounProcesses(coreDescriptor.injector, appFrameWorkDescriptor.backgroundProcesses);
			}
		}
		
		private function complete():void
		{
			_signalComplete.dispatch();
		}
		
		private function initializeStartupSequence(injector:IInjector, startupSequence:TasksSet):void
		{
			_startSequence 		= new ProcessStartupSequence();
			_startSequence.notifier.addOnce(onStartupSequenceComplete)
			_startSequence.init(injector);
			_startSequence.data = startupSequence;
			
			if(!startupSequence.executeViaSignal)
				_startSequence.requestStartupSequence();
		}
		
		private function onStartupSequenceComplete(success:Boolean):void
		{
			trace("\n----------------------------- 3rd - STARTUP SEQUENCE COMPLETE ------------------------ \n");
			initializeBackgrounProcesses(_coreDescriptor.injector, _appFrameWorkDescriptor.backgroundProcesses);
			complete();
		}
		
		private function initializeBackgrounProcesses(injector:IInjector, backgroundProcesses:BackgroundProcesses):void
		{
			if(backgroundProcesses && backgroundProcesses.descriptorCollection)
			{
			trace("\n------------------------ 4th (end) - INITIALIZE BACKGROUND PROCESSES -------------------- \n");
				for(var i:int; i < backgroundProcesses.descriptorCollection.length; i++)
				{
					UtilsProcesses.initializeBackgroundProcess(injector, backgroundProcesses.descriptorCollection[i]);
				}
			}
		}
		
		/**
		 * 
		 * @param injector
		 * @param modelsMapping
		 * @param externalModels
		 * 
		 */		
		protected function mapExternalModels(injector:IInjector, modelsMapping:IMappingInjector, externalModels:Models) : void
		{
			if(externalModels)
				UtilsMapping.mapInjectorDescriptorRule(injector, externalModels.descriptorCollection);
		}

		/**
		 * 
		 * @param modelsMapping
		 * @param injector
		 * 
		 */		
		private function mapModels(modelsMapping:IMappingInjector, injector:IInjector):void
		{
			modelsMapping.mapRules(injector);
		}

		/**
		 * 
		 * @param mediatorMap
		 * @param viewsMapping
		 * @param externalDescriptors
		 * 
		 */		
		protected function mapExternalViews(mediatorMap : IMediatorMap, viewsMapping:IMappingMediator, externalDescriptors:Views) : void
		{
			if(externalDescriptors)
				UtilsMapping.mapMediatorDescriptorRules(mediatorMap, externalDescriptors.descriptorCollection);
		}

		/**
		 * 
		 * @param viewsMapping
		 * @param mediatorMap
		 * 
		 */		
		protected function mapViews(viewsMapping:IMappingMediator, mediatorMap:IMediatorMap):void
		{
			viewsMapping.mapMediators(mediatorMap); 
		}
	
		/**
		 * 
		 * @param injector
		 * @param controlsMapping
		 * @param externalControls
		 * 
		 */		
		protected function mapExternalControls(injector:IInjector, controlsMapping:IMappingInjector, externalControls:Controls):void
		{
			if(externalControls)
				UtilsMapping.mapInjectorDescriptorRule(injector, externalControls.descriptorCollection);
		}

		/**
		 * 
		 * @param controlsMapping
		 * @param injector
		 * 
		 */		
		protected function mapControls(controlsMapping:IMappingInjector, injector:IInjector):void
		{
			controlsMapping.mapRules(injector);
		}
		
		
		/**
		 * 
		 * @param backgroundProcessesMapping
		 * @param injector
		 * 
		 */
		protected function initializeBridge(bridgeProcess:IBridgeProcess, injector:IInjector):void
		{
			bridgeProcess.initializeBridge(injector);
		}
		
		/**
		 * 
		 * @param backgrounProcessesMapping
		 * @param injector
		 * @param appFrameWorkDescriptor
		 * 
		 */		
		protected function mapBridgeCaringormCommands(bridgeProcess:IBridgeProcess, injector:IInjector, appFrameWorkDescriptor:DescriptorExternalAppFrameWork):void
		{
			if(appFrameWorkDescriptor.cairngormEventsRules)
				bridgeProcess.mapCairngormCommands(appFrameWorkDescriptor.cairngormEventsRules);
		}

		/**
		 * 
		 * @param injector
		 * @param servicesMapping
		 * @param servicesDescriptors
		 * 
		 */		
		protected function mapExternalServices(injector:IInjector, servicesMapping:IMappingInjector, servicesDescriptors:Services):void
		{
			if(servicesDescriptors)
				UtilsMapping.mapInjectorDescriptorRule(injector, servicesDescriptors.descriptorCollection);	
		}

		/**
		 * 
		 * @param servicesMapping
		 * @param injector
		 * 
		 */		
		protected function mapServices(servicesMapping:IMappingInjector, injector:IInjector):void
		{
			servicesMapping.mapRules(injector);
		}

		/**
		 * 
		 * @param signalCommandMap
		 * @param commandsMapping
		 * @param externalCommands
		 * 
		 */		
		protected function mapExternalSignalCommands(signalCommandMap : ISignalCommandMap, commandsMapping:IMappingSignalCommand, externalCommands:Commands) : void
		{
			if(externalCommands)
				UtilsMapping.mapSignalCommandDescriptorRules(signalCommandMap, externalCommands.descriptorCollection);
		}

		/**
		 * 
		 * @param commandsMapping
		 * @param signalCommandMap
		 * 
		 */		
		protected function mapSignalCommands(commandsMapping:IMappingSignalCommand, signalCommandMap:ISignalCommandMap):void
		{
			commandsMapping.mapSignalCommands(signalCommandMap);
		}
	}
}
		