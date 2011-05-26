package org.as3.mvcsc.interfaces
{
	import org.as3.mvcsc.descriptors.DescriptorMediator;
	
	import org.robotlegs.core.IMediatorMap;

	/**
	 * 
	 * @author Mario Vieira
	 * 
	 */
	public interface IMappingMediator
	{
		/**
		 * 
		 * @param mediatorMap
		 * 
		 */
		function mapMediators(mediatorMap:IMediatorMap):void;
	}
}