package org.as3.mvcsc.utils
{
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
		public static function createExternalDescriptorXMLsInDesktop(folderName:String = null, uniqueId:int = 0):void
		{
			var modelRules					:Models 			  = UtilsGetDefaultDescriptor.getDefaultModelRules();
			var viewRules					:Views 			  	  = UtilsGetDefaultDescriptor.getDefaultViewRules();
			var controlRules				:Controls 			  = UtilsGetDefaultDescriptor.getDefaultControlRules();
			var serviceRules				:Services 			  = UtilsGetDefaultDescriptor.getDefaultServiceRules();
			var signalCommandRules			:Commands 	 		  = UtilsGetDefaultDescriptor.getDefaultSignalCommandRules();
			var backgroundProcessesRules	:BackgroundProcesses  = UtilsGetDefaultDescriptor.getDefaultBackgroundProcesses();
			var cairngormEventsRules		:CairngormBridge	  = UtilsGetDefaultDescriptor.getDefaultCairngormEventRules();
			
			WriteFile.saveUTF8FileToDesktop( getFileName(modelRules, uniqueId), Serializer.serializeValueObjectIntoXML( modelRules ), folderName, "");
			WriteFile.saveUTF8FileToDesktop( getFileName(viewRules, uniqueId), Serializer.serializeValueObjectIntoXML( viewRules ), folderName , "");
			WriteFile.saveUTF8FileToDesktop( getFileName(controlRules, uniqueId), Serializer.serializeValueObjectIntoXML( controlRules ), folderName , "");
			WriteFile.saveUTF8FileToDesktop( getFileName(serviceRules, uniqueId), Serializer.serializeValueObjectIntoXML( serviceRules ), folderName , "");
			WriteFile.saveUTF8FileToDesktop( getFileName(signalCommandRules, uniqueId), Serializer.serializeValueObjectIntoXML( signalCommandRules ), folderName , "");
			WriteFile.saveUTF8FileToDesktop( getFileName(cairngormEventsRules, uniqueId), Serializer.serializeValueObjectIntoXML( cairngormEventsRules ), folderName , "");
			//WriteFile.saveUTF8FileToDesktop( getFileName(backgroundProcessesRules), Serializer.serializeValueObjectIntoXML( backgroundProcessesRules ), folderName );
		}
	}
}