package org.as3.mvcsc.descriptors
{
	
	public class DescriptorViewMap
	{
		public var viewClass	:Class;
		public var viewMediator	:Class;
		
		public function DescriptorViewMap(viewClass:Class, viewMediator:Class) 
		{
			this.viewClass 		= viewClass;
			this.viewMediator	= viewMediator;
		}
	}
}