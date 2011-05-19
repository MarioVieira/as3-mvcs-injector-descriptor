package org.as3.mvcsc.descriptors
{
	public class DescriptorBackgroundProcess
	{
		[Serialize] public var backgroundServiceInterfaceQName	:String;
		[Serialize] public var executeInjection					:Boolean = true;
		[Serialize] public var executeSignalCommandMapping		:Boolean = true;
	}
}