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
		 * @param folderName
		 * @return 
		 * 
		 */
		public static function getFileName(object:*, folderName:String):String
		{
			return folderName + "/"+ ObjectDescriptor.getClassConstructor(object) + ".xml";
		}
		
		/**
		 * 
		 * @param folderName
		 * @param folderName
		 * 
		 */
		public static function createExternalDescriptorXMLsInDesktop(applicationDescriptor:DescriptorExternalAppFrameWork, folderName:String):void
		{
			WriteFile.saveUTF8FileToDesktop( getFileName(applicationDescriptor.modelRules, folderName), Serializer.serialize( applicationDescriptor.modelRules ), "");
			WriteFile.saveUTF8FileToDesktop( getFileName(applicationDescriptor.viewRules, folderName), Serializer.serialize( applicationDescriptor.viewRules ), "");
			WriteFile.saveUTF8FileToDesktop( getFileName(applicationDescriptor.controlRules, folderName), Serializer.serialize( applicationDescriptor.controlRules ), "");
			WriteFile.saveUTF8FileToDesktop( getFileName(applicationDescriptor.serviceRules, folderName), Serializer.serialize( applicationDescriptor.serviceRules ), "");
			WriteFile.saveUTF8FileToDesktop( getFileName(applicationDescriptor.signalCommandRules, folderName), Serializer.serialize( applicationDescriptor.signalCommandRules ), "");
			WriteFile.saveUTF8FileToDesktop( getFileName(applicationDescriptor.cairngormEventsRules, folderName), Serializer.serialize( applicationDescriptor.cairngormEventsRules ), "");
			//WriteFile.saveUTF8FileToDesktop( getFileName(backgroundProcessesRules), Serializer.serializeValueObjectIntoXML( backgroundProcessesRules ), folderName );
		}
	}
}