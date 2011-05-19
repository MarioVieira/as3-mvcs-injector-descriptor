package org.as3.mvcsc.interfaces
{
	import org.as3.mvcsc.descriptors.DescriptorInjector;
	
	import org.robotlegs.core.IInjector;

	public interface IMappingInjector
	{
		function mapRules(injector:IInjector):void;
	}
}