package org.as3.mvcsc.interfaces
{
	import org.as3.bridge.interfaces.IBridgeProcess;
	import org.as3.mvcsc.descriptors.DescriptorExternalAppFrameWork;
	import org.as3.mvcsc.task.TaskInit;
	import org.robotlegs.core.IInjector;

	/**
	 * 
	 * @author Mario Vieira 
	 * 
	 */
	public interface IMappingBackgroundProcesses extends IBridgeProcess
	{
		/**
		 * 
		 * @param injector
		 * @param appFrameWorkDescriptor
		 * 
		 */
		function initializeExternalBackgroundProcesses(injector:IInjector, appFrameWorkDescriptor:DescriptorExternalAppFrameWork):void;
		
		/**
		 * 
		 * @param injector
		 * @param appFrameWorkDescriptor
		 * 
		 */
		function initializeStartupSequence(injector:IInjector, sequence:Vector.<TaskInit>):void;
	}
}