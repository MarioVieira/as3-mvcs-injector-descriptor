package org.as3.mvcsc.model
{
	import org.as3.mvcsc.descriptors.DescriptorSignalCommand;

	public class Commands
	{
		public function Commands()
		{	
			descriptorCollection = new Vector.<DescriptorSignalCommand>();
		}
		
		[Serialize] public var descriptorCollection:Vector.<DescriptorSignalCommand>;
	}
}