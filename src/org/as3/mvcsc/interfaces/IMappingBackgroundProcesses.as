package org.as3.mvcsc.interfaces
{
	import org.as3.mvcsc.descriptors.DescriptorExternalAppFrameWork;
	
	import org.robotlegs.core.IInjector;

	public interface IMappingBackgroundProcesses
	{
		function initialize(injector:IInjector, appFrameWorkDescriptor:DescriptorExternalAppFrameWork):void;
	}
}