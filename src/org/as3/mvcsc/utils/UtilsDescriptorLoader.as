package org.as3.mvcsc.utils
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.getQualifiedClassName;
	
	import org.as3.mvcsc.descriptors.DescriptorExternalAppFrameWork;
	import org.as3.interfaces.IDispose;
	import org.as3.mvcsc.vo.BackgroundProcesses;
	import org.as3.mvcsc.vo.CairngormBridge;
	import org.as3.mvcsc.vo.Commands;
	import org.as3.mvcsc.vo.Controls;
	import org.as3.mvcsc.vo.Models;
	import org.as3.mvcsc.vo.PropertiesCollection;
	import org.as3.mvcsc.vo.PropertyInfo;
	import org.as3.mvcsc.vo.Services;
	import org.as3.mvcsc.vo.Views;
	import org.as3.serializer.Serializer;
	import org.osflash.signals.Signal;

	/**
	 * 
	 * 
	 * Loads the XML external application frame-work descriptor, serializes it into its respective object types, and broadcasts them
	 * 
	 * @author Mario Vieira
	 */
	public class UtilsDescriptorLoader extends Signal implements IDispose
	{
		/** private ***/
		protected var _descriptorsXMLClasses			:Array = [Models, Views, Controls, Services, Commands, BackgroundProcesses, CairngormBridge];
		
		/** private ***/
		protected var _currentXMLIndex					:int;
		
		/** private ***/ 
		protected var _appFrameWorkExternalDescriptor	:DescriptorExternalAppFrameWork;
		
		/** private ***/
		protected var _xmlLoader						:URLLoader;
		
		/** private ***/
		protected var _appFrameWorkVariables			:PropertiesCollection;
		
		/** private ***/
		protected var _filesFolderName:String;
		
		/**
		 * 
		 * @param uniqueAppId
		 * 
		 */
		public function UtilsDescriptorLoader(folderName:String)
		{
			super(DescriptorExternalAppFrameWork);
			_filesFolderName = folderName;
			init();
		}
		
		/** private ***/
		protected function init():void
		{
			//NOT HANDLING ERRORS - WE NEED THE ERRORRS TO KNOW IF XMLS ARE NOT LOADED
			_xmlLoader = new URLLoader;
			_appFrameWorkExternalDescriptor = new DescriptorExternalAppFrameWork();
			_xmlLoader.addEventListener(Event.COMPLETE, onNextXML);
			_xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, onXMLError);
			_xmlLoader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, onXMLError);
			_appFrameWorkVariables	= DescribeObject.getObjectVariables( _appFrameWorkExternalDescriptor );
		}

		/**
		 * 
		 * @param descriptorsXMLArray
		 * 
		 */
		public function loadExternalAppFrameWorkDescriptor(descriptorsXMLArray:Array = null):void
		{
			if(descriptorsXMLArray) _descriptorsXMLClasses = descriptorsXMLArray;
			reset();
			loadNextXML();
		}
		
		/** private ***/
		protected function loadNextXML():void
		{
			if(!isQueueConcluded()) 
			{
				loadXML( getCurrentXMLUrl() );
				_currentXMLIndex ++;
			}
			else
			{
				send();
			}
		}
		
		/** private ***/
		protected function loadXML(url:String):void
		{
			_xmlLoader.load(new URLRequest(url));
		}
		
		/** private ***/
		protected function onNextXML(e:Event):void
		{
			setDescriptorRules( XML(URLLoader(e.target).data) );
			loadNextXML();
		}
	
		/**
		 * 
		 * @param description
		 * 
		 */
		protected function setDescriptorRules(description:XML):void
		{
			//leaving to check cause if nothing is loaded, it should be null
			
			
			var serializedObject:* = Serializer.deserialize( description );
			_appFrameWorkExternalDescriptor[getXMLRespectivePropertyInFrameWorkDescriptor(serializedObject)] = serializedObject;
		}
		
		/** private ***/
		protected function getCurrentXMLUrl():String
		{
			return getFileName(_descriptorsXMLClasses[_currentXMLIndex], _filesFolderName);
		}
		
		/** private ***/
		protected function isQueueConcluded():Boolean
		{
			return (_currentXMLIndex == _descriptorsXMLClasses.length);
		}
		
		/**
		 * 
		 * Send the XMLs loaded as serialzed objects
		 * 
		 */
		protected function send():void
		{
			//Tracer.log(this, "send");
			dispatch(_appFrameWorkExternalDescriptor);
		}
		
		/** private ***/
		protected function reset():void
		{
			_currentXMLIndex = 0;
		}
		
		/** private ***/
		protected function getXMLRespectivePropertyInFrameWorkDescriptor(deserializedObject:*):String
		{
			for each(var propInfo:PropertyInfo in _appFrameWorkVariables.propertyInfoArray)
			{
				if(propInfo.type == getQualifiedClassName(deserializedObject)) return propInfo.name;
			}
			
			return null;
		}
		
		/** private ***/
		protected function getFileName(clazz:Class, folderName:String):String
		{
			return UtilsGetAppFrameWorkExtenalDescriptor.getFileName(clazz, folderName);
		}
		
		/** private ***/
		protected function onXMLError(event:Event):void
		{
			Tracer.log(this, " ¡ ERROR LOADING EXTERNAL APPLICATION DESCRIPTOR ! (app://"+ getFileName(_descriptorsXMLClasses[_currentXMLIndex -1], _filesFolderName) + ")");
			loadNextXML();
		}
		
		/**
		 * 
		 * 
		 */
		public function dispose(recursive:Boolean=true):void
		{
			_xmlLoader.removeEventListener(Event.COMPLETE, onNextXML);
			_appFrameWorkExternalDescriptor = null;
			_xmlLoader = null;
		}
	}
}