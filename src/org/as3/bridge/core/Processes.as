package org.as3.bridge.core
{
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import org.as3.interfaces.IBackgroundProcess;
	import org.as3.mvcsc.descriptors.DescriptorBackgroundProcess;
	import org.as3.mvcsc.descriptors.DescriptorExternalAppFrameWork;
	import org.as3.mvcsc.interfaces.IMappingBackgroundProcesses;
	import org.as3.mvcsc.utils.Tracer;
	import org.as3.mvcsc.vo.BackgroundProcesses;
	import org.robotlegs.core.IInjector;

	/**
	 * @author Mario Vieira
	 * 	
	 * 	This class is responsible to all is a background process, and in anything that will happen independent of displaying a graphic user interface
	 */
	 
	public class Processes implements IMappingBackgroundProcesses
	{
		/** 
		 * 
		 * Hold on to the processes. The injection dictionaries are weak references.
		 * 
		 * @private
		 * 
		 ***/
		protected var _processes : Dictionary;
		
		
		public function Processes():void
		{
			_processes = new Dictionary();
		}
		
		public function initializeProcesses(injector:IInjector, processes:BackgroundProcesses):void
		{
			for each(var bgProcess:DescriptorBackgroundProcess in processes.descriptorCollection)
			{
				mapProcesses(injector, bgProcess);
				initializeProcess(injector, bgProcess);
			}	
		}

		/**
		 *
		 * First map the injection rule in the injector's dictionary
		 *  
		 * @param injector
		 * @param bgProcess
		 * 
		 */		
		protected function mapProcesses(injector:IInjector, bgProcess:DescriptorBackgroundProcess):void
		{
			injector.mapSingleton( getDefinitionByName(bgProcess.processQNameIBackgroundProcess) as Class );
		}
		
		
		/**
		 * 
		 * Initialize the processes
		 * 
		 * @param injector
		 * @param bgProcess
		 * 
		 */		
		protected function initializeProcess(injector:IInjector, bgProcess:DescriptorBackgroundProcess):void
		{
			Tracer.log(this, "initializeProcess - processQNameIBackgroundProcess: "+bgProcess.processQNameIBackgroundProcess);
			_processes[bgProcess] = injector.getInstance( getDefinitionByName(bgProcess.processQNameIBackgroundProcess) as Class  );
			IBackgroundProcess(_processes[bgProcess]).data = bgProcess.data;
		}

		public function initializeBackgroundProcesses(injector:IInjector):void
		{
			// TODO Auto-generated method stub
		}

		public function initializeExternalBackgroundProcesses(injector:IInjector, appFrameWorkDescriptor:DescriptorExternalAppFrameWork):void
		{
			// TODO Auto-generated method stub
		}
		
		
		/*protected var _cairngormRouter					:CairngormCommandToSignal;
		
		
		protected var _bridge							:Bridge;
		
		
		protected var _cairngormDataExchange			:MappingCairngormDataExchange;
		
		
		protected var _routedCairngormFronController	:RouteCairngormCommands;*/
		
		//protected var _cairngormBridgeProcess			:BGProcessCairngormBridge;
		
		/** @private **/
		//protected var _downloadControl				:ControlDownload;
		
		
		/** @private **/
		//protected var _socialNetworkProcess			:IBackgroundProcess;
		
		
		
		
		
			
		/*private function initializeCairngormBridge(injector : IInjector, appExternalFrameWorkDescriptor : DescriptorExternalAppFrameWork):void
		{
			if(appExternalFrameWorkDescriptor && appExternalFrameWorkDescriptor.cairngormEventsRules)
			{
				injector.mapSingleton(BGProcessCairngormBridge)
				_cairngormBridgeProcess = injector.getInstance(BGProcessCairngormBridge);
				_cairngormBridgeProcess.data = appExternalFrameWorkDescriptor.cairngormEventsRules;
			}
		}*/
		
		/*
		protected function backgroundProcessesRules(injector : IInjector) : void
		{
			//Tracer.log(this, "backgroundProcessesRules");
			injector.mapSingleton(ControlDownload);
		}
	
		
		protected function backgroundProcessesInstances(injector : IInjector) : void
		{
			//Tracer.log(this, "backgroundProcessesInstances");	
			_downloadControl = injector.getInstance(ControlDownload);
		}*/
		
		/*protected function backgroundProcessesCairngormBridge(injector : IInjector, appFrameWorkDescriptor : DescriptorExternalAppFrameWork):void
		{
			_cairngormBridgeProcess
			
			/*	
				injector.mapSingleton(RouteCairngormCommands);
				injector.mapSingleton(MappingCairngormDataExchange);
				injector.mapSingleton(CairngormCommandToSignal);
				
				_bridge							 = Bridge.getInstance();
				_bridge.cairgormBridgeDescriptor = appFrameWorkDescriptor.cairngormEventsRules;
			
				_routedCairngormFronController   = injector.getInstance(RouteCairngormCommands);
				_cairngormDataExchange			 = injector.getInstance(MappingCairngormDataExchange);
				_cairngormRouter 			 	 = injector.getInstance(CairngormCommandToSignal);
				
				_routedCairngormFronController.addCairngormCommands(injector, appFrameWorkDescriptor.cairngormEventsRules);
			
		}*/
		
		
		/*public function initializeBackgroundProcesses(injector:IInjector):void
		{
			injector.mapSingleton(BGProcessSocialNetwork);
			_socialNetworkProcess = injector.getInstance(BGProcessSocialNetwork);
		}*/
	}
}
