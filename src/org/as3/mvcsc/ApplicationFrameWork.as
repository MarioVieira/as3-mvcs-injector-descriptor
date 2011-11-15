package org.as3.mvcsc
{
	import org.as3.mvcsc.descriptors.DescriptorAppFrameWork;
	import org.as3.mvcsc.descriptors.DescriptorCore;
	import org.as3.mvcsc.descriptors.DescriptorExternalAppFrameWork;
	import org.as3.mvcsc.interfaces.IMappingBackgroundProcesses;
	import org.as3.mvcsc.interfaces.IMappingInjector;
	import org.as3.mvcsc.interfaces.IMappingMediator;
	import org.as3.mvcsc.interfaces.IMappingSignalCommand;
	import org.as3.mvcsc.interfaces.ITask;
	import org.as3.mvcsc.task.Task;
	import org.as3.mvcsc.utils.UtilsMapping;
	import org.as3.mvcsc.vo.Commands;
	import org.as3.mvcsc.vo.Controls;
	import org.as3.mvcsc.vo.Models;
	import org.as3.mvcsc.vo.Services;
	import org.as3.mvcsc.vo.TasksSet;
	import org.as3.mvcsc.vo.Views;
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
		/**
		 * 
		 * @param coreDescriptor
		 * @param appFrameWorkDescriptor
		 * @param externalAppFrameWorkDescriptor
		 *  
		 */		
		public function ApplicationFrameWork(coreDescriptor:DescriptorCore, appFrameWorkDescriptor:DescriptorAppFrameWork, externalAppFrameWorkDescriptor:DescriptorExternalAppFrameWork) 
		{
			createMappings(coreDescriptor, appFrameWorkDescriptor, externalAppFrameWorkDescriptor);
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
				//1st - command can only get triggered once all mapping is done
				mapSignalCommands(appFrameWorkDescriptor.commandsMapping, coreDescriptor.signalCommandMap);
				//2nd - don't rely on any injection rules
				mapModels(appFrameWorkDescriptor.modelsMapping, coreDescriptor.injector);
				//3rd - don't rely on any injection rules
				mapServices(appFrameWorkDescriptor.servicesMapping, coreDescriptor.injector);
				//4th - relies on 1st, 2nd, and 3rd
				mapControls(appFrameWorkDescriptor.controlsMapping, appFrameWorkDescriptor.backgroundProcessesMapping, coreDescriptor.injector);
				//5th - relies on 1st, 2nd, and 3rd
				initializeBackgroundProcesses(appFrameWorkDescriptor.backgroundProcessesMapping, coreDescriptor.injector);
				//5th - relies on 1st, 2nd, and 3rd
				mapViews(appFrameWorkDescriptor.viewsMapping, coreDescriptor.mediatorMap);
				
				trace('\n');
				trace("------------------------ INTERNAL APPLICATION FRAME WORK MAPPED ----------------");
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
				initializeExternalBackgroundProcesses(appFrameWorkDescriptor.backgroundProcessesMapping, coreDescriptor.injector, externalAppFrameWorkDescriptor, appFrameWorkDescriptor.startupSequence);
				
				trace("------------------------ EXTERNAL APPLICATION FRAME WORK MAPPED ---------------- \n\n");
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
			UtilsMapping.mapInjectorDescriptorRule(injector, externalControls.descriptorCollection);
		}

		/**
		 * 
		 * @param controlsMapping
		 * @param injector
		 * 
		 */		
		protected function mapControls(controlsMapping:IMappingInjector, backgrounProcessesMapping:IMappingBackgroundProcesses, injector:IInjector):void
		{
			controlsMapping.mapRules(injector);
		}
		
		
		/**
		 * 
		 * @param backgroundProcessesMapping
		 * @param injector
		 * 
		 */
		protected function initializeBackgroundProcesses(backgroundProcessesMapping:IMappingBackgroundProcesses, injector:IInjector):void
		{
			backgroundProcessesMapping.initializeBackgroundProcesses(injector);
		}
		
		/**
		 * 
		 * @param backgrounProcessesMapping
		 * @param injector
		 * @param appFrameWorkDescriptor
		 * 
		 */		
		protected function initializeExternalBackgroundProcesses(backgrounProcessesMapping:IMappingBackgroundProcesses, injector:IInjector, appFrameWorkDescriptor:DescriptorExternalAppFrameWork, startupSequence:TasksSet):void
		{
			backgrounProcessesMapping.initializeExternalBackgroundProcesses(injector, appFrameWorkDescriptor);
			backgrounProcessesMapping.initializeStartupSequence(injector, startupSequence);
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
		