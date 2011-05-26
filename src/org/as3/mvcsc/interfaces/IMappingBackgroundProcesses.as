package org.as3.mvcsc.interfaces
{
	import org.as3.mvcsc.descriptors.DescriptorExternalAppFrameWork;
	
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
		function initialize(injector:IInjector, appFrameWorkDescriptor:DescriptorExternalAppFrameWork):void;
	}
}