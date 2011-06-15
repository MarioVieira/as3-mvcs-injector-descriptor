package org.as3.mvcsc.utils
{
	import flash.utils.getQualifiedClassName;
	
	import org.as3.mvcsc.descriptors.DescriptorBackgroundProcess;
	
	public class UtilsProcesses
	{
		public static function getProcessDescriptor(processClass:Class, data:Object):DescriptorBackgroundProcess
		{
			var vo:DescriptorBackgroundProcess 	= new DescriptorBackgroundProcess();
			vo.processQNameIBackgroundProcess 	= getQualifiedClassName(processClass);
			vo.data 							= data;
			
			return vo;
		}
	}
}