package org.as3.mvcsc.descriptors
{
	/**
	 * 
	 * 
	 *  Mediator mapping description
	 * 
	 * @author Mario Vieira
	 */
	public class DescriptorMediator
	{
		/**
		 * 
		 */
		[Serialize] public var mapViewQName		:String;
		/**
		 * 
		 */
		[Serialize] public var mediatorQName		:String;
		/**
		 * 
		 */
		[Serialize] public var injectViewAsQName	:String;
		/**
		 * 
		 */
		[Serialize] public var autoCreate		:Boolean = true;
		/**
		 * 
		 */
		[Serialize] public var autoRemove		:Boolean = true;
	}
}