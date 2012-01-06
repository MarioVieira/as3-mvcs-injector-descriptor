package org.as3.bridge.core
{
	
	import org.as3.bridge.control.BridgeProcess;
	import org.as3.interfaces.IBackgroundProcess;
	import org.as3.mvcsc.descriptors.DescriptorBackgroundProcess;
	import org.as3.mvcsc.descriptors.DescriptorExternalAppFrameWork;
	import org.as3.mvcsc.task.TaskInit;
	import org.robotlegs.core.IInjector;
	
	
	/**
	 * @author Mario Vieira
	 * 	
	 * 	This class is responsible to all is a background process, and in anything that will happen independent of displaying a graphic user interface
	 */
	
	public class Processes
	{
		
		/** @private **/
		protected var _bridgeApi						:IBackgroundProcess;
		
		/** @private **/
		protected var _downloadsBackgroundProcess		:IBackgroundProcess;
		
		/** @private **/
		protected var _socialNetworkProcess				:IBackgroundProcess;
		
		/**
		 * 
		 * @param injector
		 * @param signalCommandMap
		 * 
		 */
		public function initializeBridge(injector : IInjector):void
		{
			injector.mapSingleton(BridgeProcess);
			_bridgeApi = injector.getInstance(BridgeProcess);
			_bridgeApi.init(injector);
		}
		
		public function initializeExternalBackgroundProcesses(injector:IInjector, appFrameWorkDescriptor:DescriptorExternalAppFrameWork):void
		{
			for each(var process:DescriptorBackgroundProcess in appFrameWorkDescriptor.backgroundProcesses.descriptorCollection)
			{
				//injector.mapSingleton(process	
			}
		}
		
		public function initializeStartupSequence(injector:IInjector, sequence:Vector.<TaskInit>):void
		{
			
		}
	}
}