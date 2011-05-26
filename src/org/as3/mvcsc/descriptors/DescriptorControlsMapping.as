package org.as3.mvcsc.descriptors
{
	/**
	 * 
	 * 
	 * Controls for injection mapping 
	 * 
	 * @author Mario Vieira
	 */
	
	public class DescriptorControlsMapping
	{
		
		/**
		 * 
		 */
		[Serialize] public var descriptorCollection:Vector.<DescriptorInjector>;
		
		/**
		 * 
		 * 
		 */
		public function DescriptorControlsMapping()
		{
			descriptorCollection = new Vector.<DescriptorInjector>();
		}
	}
}