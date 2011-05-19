package org.as3.mvcsc.utils
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.getQualifiedClassName;
	
	import org.as3.mvcsc.descriptors.DescriptorExternalAppFrameWork;
	import org.as3.mvcsc.interfaces.IDispose;
	import org.as3.mvcsc.model.BackgroundProcesses;
	import org.as3.mvcsc.model.CairngormBridge;
	import org.as3.mvcsc.model.Commands;
	import org.as3.mvcsc.model.Controls;
	import org.as3.mvcsc.model.Models;
	import org.as3.mvcsc.model.Services;
	import org.as3.mvcsc.model.Views;
	import org.as3.mvcsc.vo.PropertiesCollection;
	import org.as3.mvcsc.vo.PropertyInfo;
	import org.as3.serializer.utils.Serializer;
	import org.osflash.signals.Signal;

	public class UtilsDescriptorLoader extends Signal implements IDispose
	{
		protected var _descriptorsXMLClasses			:Array = [Models, Views, Controls, Services, Commands, BackgroundProcesses, CairngormBridge];
		protected var _currentXMLIndex					:int;
		protected var _appFrameWorkExternalDescriptor	:DescriptorExternalAppFrameWork;
		protected var _xmlLoader						:URLLoader;
		protected var _appFrameWorkVariables			:PropertiesCollection;
		protected var _uniqueAppId:int;
		
		public function UtilsDescriptorLoader(uniqueAppId:int)
		{
			super(DescriptorExternalAppFrameWork);
			_uniqueAppId = uniqueAppId;
			init();
		}
		
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

		public function loadExternalAppFrameWorkDescriptor(descriptorsXMLArray:Array = null):void
		{
			if(descriptorsXMLArray) _descriptorsXMLClasses = descriptorsXMLArray;
			reset();
			loadNextXML();
		}
		
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
		
		protected function loadXML(url:String):void
		{
			_xmlLoader.load(new URLRequest(url));
		}
		
		protected function onNextXML(e:Event):void
		{
			setDescriptorRules( XML(URLLoader(e.target).data) );
			loadNextXML();
		}
	
		protected function setDescriptorRules(description:XML):void
		{
			//leaving to check cause if nothing is loaded, it should be null
			
			
			var serializedObject:* = Serializer.deserializeXMLIntoValueObject( description );
			_appFrameWorkExternalDescriptor[getXMLRespectivePropertyInFrameWorkDescriptor(serializedObject)] = serializedObject;
		}
		
		protected function getCurrentXMLUrl():String
		{
			return getFileName(_descriptorsXMLClasses[_currentXMLIndex], _uniqueAppId);
		}
		
		protected function isQueueConcluded():Boolean
		{
			return (_currentXMLIndex == _descriptorsXMLClasses.length);
		}
		
		protected function send():void
		{
			//Tracer.log(this, "send");
			dispatch(_appFrameWorkExternalDescriptor);
		}
		
		protected function reset():void
		{
			_currentXMLIndex = 0;
		}
		
		protected function getXMLRespectivePropertyInFrameWorkDescriptor(deserializedObject:*):String
		{
			for each(var propInfo:PropertyInfo in _appFrameWorkVariables.propertyInfoArray)
			{
				if(propInfo.type == getQualifiedClassName(deserializedObject)) return propInfo.name;
			}
			
			return null;
		}
		
		protected function getFileName(clazz:Class, uniqueId:int):String
		{
			return UtilsGetAppFrameWorkExtenalDescriptor.getFileName(clazz, uniqueId);
		}
		
		protected function onXMLError(event:Event):void
		{
			Tracer.log(this, " ¡ ERROR LOADING EXTERNAL APPLICATION DESCRIPTOR ! (app://"+ getFileName(_descriptorsXMLClasses[_currentXMLIndex -1], _uniqueAppId) + ")");
			loadNextXML();
		}
		
		public function dispose():void
		{
			_xmlLoader.removeEventListener(Event.COMPLETE, onNextXML);
			_appFrameWorkExternalDescriptor = null;
			_xmlLoader = null;
		}
	}
}