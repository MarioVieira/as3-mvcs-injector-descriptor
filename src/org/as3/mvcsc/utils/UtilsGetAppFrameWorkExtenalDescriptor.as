package org.as3.mvcsc.utils
{
	import org.as3.mvcsc.descriptors.DescriptorAppFrameWork;
	import org.as3.mvcsc.descriptors.DescriptorExternalAppFrameWork;
	import org.as3.mvcsc.vo.BackgroundProcesses;
	import org.as3.mvcsc.vo.CairngormBridge;
	import org.as3.mvcsc.vo.Commands;
	import org.as3.mvcsc.vo.Controls;
	import org.as3.mvcsc.vo.Models;
	import org.as3.mvcsc.vo.Services;
	import org.as3.mvcsc.vo.Views;
	import org.as3.serializer.helpers.ObjectDescriptor;
	import org.as3.serializer.utils.Serializer;
	
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
			WriteFile.saveUTF8FileToDesktop( getFileName(applicationDescriptor.modelRules, uniqueId), Serializer.serializeValueObjectIntoXML( applicationDescriptor.modelRules ), "");
			WriteFile.saveUTF8FileToDesktop( getFileName(applicationDescriptor.viewRules, uniqueId), Serializer.serializeValueObjectIntoXML( applicationDescriptor.viewRules ), "");
			WriteFile.saveUTF8FileToDesktop( getFileName(applicationDescriptor.controlRules, uniqueId), Serializer.serializeValueObjectIntoXML( applicationDescriptor.controlRules ), "");
			WriteFile.saveUTF8FileToDesktop( getFileName(applicationDescriptor.serviceRules, uniqueId), Serializer.serializeValueObjectIntoXML( applicationDescriptor.serviceRules ), "");
			WriteFile.saveUTF8FileToDesktop( getFileName(applicationDescriptor.signalCommandRules, uniqueId), Serializer.serializeValueObjectIntoXML( applicationDescriptor.signalCommandRules ), "");
			WriteFile.saveUTF8FileToDesktop( getFileName(applicationDescriptor.cairngormEventsRules, uniqueId), Serializer.serializeValueObjectIntoXML( applicationDescriptor.cairngormEventsRules ), "");
			//WriteFile.saveUTF8FileToDesktop( getFileName(backgroundProcessesRules), Serializer.serializeValueObjectIntoXML( backgroundProcessesRules ), folderName );
		}
	}
}