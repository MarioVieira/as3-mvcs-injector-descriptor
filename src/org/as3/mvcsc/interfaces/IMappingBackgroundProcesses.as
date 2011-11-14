package org.as3.mvcsc.interfaces
{
	import org.as3.mvcsc.descriptors.DescriptorExternalAppFrameWork;
	import org.as3.mvcsc.vo.BackgroundProcesses;
	import org.as3.mvcsc.vo.StartupSequence;
	import org.robotlegs.core.IInjector;

	/**
	 * 
	 * @author Mario Vieira 
	 * 
	 */
	public interface IMappingBackgroundProcesses
	{
		/**
		 * 
		 * @param injector
		 * @param appFrameWorkDescriptor
		 * 
		 */
		function initializeBackgroundProcesses(injector:IInjector):void;
		
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
		function initializeStartupSequence(injector:IInjector, startupSequence:StartupSequence):void;
	}
}