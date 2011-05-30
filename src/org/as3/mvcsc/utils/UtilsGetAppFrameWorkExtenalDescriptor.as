package org.as3.mvcsc.utils
{
	import org.as3.mvcsc.descriptors.DescriptorExternalAppFrameWork;
	import org.as3.serializer.Serializer;
	import org.as3.serializer.utils.ObjectDescriptor;
	
	/**
	 * 
	 * 
	 * Generates the external XML MVCS Commands descriptors
	 * 
	 * @author Mario Vieira
	 */
	public class UtilsGetAppFrameWorkExtenalDescriptor
	{
		
		/**
		 * 
		 * @param object
		 * @param uniqueId
		 * @return 
		 * 
		 */
		public static function getFileName(object:*, uniqueId:int):String
		{
			return "descriptors/"+ObjectDescriptor.getClassConstructor(object) + "_" +uniqueId+".xml";
		}
		
		/**
		 * 
		 * @param folderName
		 * @param uniqueId
		 * 
		 */
		public static function createExternalDescriptorXMLsInDesktop(applicationDescriptor:DescriptorExternalAppFrameWork, uniqueId:int = 0):void
		{
			WriteFile.saveUTF8FileToDesktop( getFileName(applicationDescriptor.modelRules, uniqueId), Serializer.serialize( applicationDescriptor.modelRules ), "");
			WriteFile.saveUTF8FileToDesktop( getFileName(applicationDescriptor.viewRules, uniqueId), Serializer.serialize( applicationDescriptor.viewRules ), "");
			WriteFile.saveUTF8FileToDesktop( getFileName(applicationDescriptor.controlRules, uniqueId), Serializer.serialize( applicationDescriptor.controlRules ), "");
			WriteFile.saveUTF8FileToDesktop( getFileName(applicationDescriptor.serviceRules, uniqueId), Serializer.serialize( applicationDescriptor.serviceRules ), "");
			WriteFile.saveUTF8FileToDesktop( getFileName(applicationDescriptor.signalCommandRules, uniqueId), Serializer.serialize( applicationDescriptor.signalCommandRules ), "");
			WriteFile.saveUTF8FileToDesktop( getFileName(applicationDescriptor.cairngormEventsRules, uniqueId), Serializer.serialize( applicationDescriptor.cairngormEventsRules ), "");
			//WriteFile.saveUTF8FileToDesktop( getFileName(backgroundProcessesRules), Serializer.serializeValueObjectIntoXML( backgroundProcessesRules ), folderName );
		}
	}
}