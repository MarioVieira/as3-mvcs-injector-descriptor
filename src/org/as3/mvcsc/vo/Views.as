package org.as3.mvcsc.vo
{
	import org.as3.mvcsc.descriptors.DescriptorMediator;

	/**
	 * 
	 * 
	 * Value object for the XML based Views mapping
	 * 
	 * @author Mario Vieira
	 */
	public class Views
	{
		/** @private **/
		public function Views()
		{
			descriptorCollection = new Vector.<DescriptorMediator>();
		}
		
		/**
		 * 
		 */
		[Serialize] public var descriptorCollection:Vector.<DescriptorMediator>;
	}
}