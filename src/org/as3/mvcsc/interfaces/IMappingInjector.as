package org.as3.mvcsc.interfaces
{
	import org.as3.mvcsc.descriptors.DescriptorInjector;
	
	import org.robotlegs.core.IInjector;

	/**
	 * 
	 * @author Mario Vieira
	 * 
	 */
	public interface IMappingInjector
	{
		/**
		 * 
		 * @param injector
		 * 
		 */
		function mapRules(injector:IInjector):void;
	}
}