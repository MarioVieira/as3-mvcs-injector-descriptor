package org.as3.bridge.utils
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.utils.getDefinitionByName;
	
	import org.as3.mvcsc.descriptors.DescriptorCairngormEventMap;
	import org.as3.mvcsc.utils.Tracer;
	import org.as3.mvcsc.utils.UtilsMapping;
	import org.as3.mvcsc.vo.PropertiesCollection;
	import org.as3.mvcsc.vo.PropertyInfo;
	import org.as3.serializer.utils.GetTypedObject;
	import org.osflash.signals.ISignalOwner;
	import org.robotlegs.core.IInjector;

	
	/**
	 * 
	 * Assists in routing Cairngorm events to value object to be broadcastied via Signals
	 * 
	 * @author Mario Vieira
	 * 
	 */
	public class UtilsCairngormEventToSignal
	{
		/**
		 * 
		 * @param cairngormEvent
		 * @param cairngormEventRules
		 * @return 
		 * 
		 */
		public static function getVoClassToReceiveCairngormEventProperties(cairngormEvent:*, cairngormEventRules:Vector.<DescriptorCairngormEventMap>):Class
		{
			for each(var descriptor:DescriptorCairngormEventMap in cairngormEventRules)
			{
				if(cairngormEvent is UtilsMapping.getClassFromQName(descriptor.cairngormEventQName)) 
				{
					return UtilsMapping.getClassFromQName(descriptor.valueObjectQNameToReceiveEventProperties);	
				}
			}
			
			return null;
		}
		
		/**
		 * 
		 * @param event
		 * @param cairngormEventRules
		 * @return 
		 * 
		 */
		public static function getSignalQNameOfCairngormEvent(event:*, cairngormEventRules:Vector.<DescriptorCairngormEventMap>):String
		{
			for each(var descriptor:DescriptorCairngormEventMap in cairngormEventRules)
			{
				if(event is UtilsMapping.getClassFromQName(descriptor.valueObjectQNameToReceiveEventProperties)) 
				{
					return descriptor.signalClassQName;	
				}
			}
			
			return null;
		}
		
		/**
		 * 
		 * @param event
		 * @param cairngormEventRules
		 * @return 
		 * 
		 */
		public static function getCairngormEventDescriptor(event:CairngormEvent, cairngormEventRules:Vector.<DescriptorCairngormEventMap>):DescriptorCairngormEventMap
		{
			for each(var descriptor:DescriptorCairngormEventMap in cairngormEventRules)
			{
				if(event is UtilsMapping.getClassFromQName(descriptor.cairngormEventQName) ) return descriptor;	
			}
			
			return null;
		}
		
		/**
		 * 
		 * @param injector
		 * @param eventDescriptor
		 * @return 
		 * 
		 */
		public static function getInjectedSignalFromCairngormEventDescriptor(injector:IInjector, eventDescriptor:DescriptorCairngormEventMap):ISignalOwner
		{
			return injector.getInstance( getDefinitionByName( eventDescriptor.signalClassQName ) as Class );
		}
		
		/**
		 * 
		 * @param collection
		 * @param valueObjectClassQName
		 * @return 
		 * 
		 */
		public static function getValueObjectWithPropertyCollectionValues(collection : PropertiesCollection, valueObjectClassQName:String) : *
		{
			if(valueObjectClassQName)
			{
				var valueObject:* = GetTypedObject.getDataTypedObject(valueObjectClassQName);
				for each(var info:PropertyInfo in collection.propertyInfoVector)
				{
					try{ valueObject[info.name] = info.value; }
					catch(er:Error)
					{ 
						//Tracer.log(DynamicSignalFactory, er); 
					}
				}
			}
			else
			{
				Tracer.log(UtilsCairngormEventToSignal, "See CairngormBridge_ID.xml: No value object class provided to receive CairngormEvent properties");
			}
			
			return valueObject;
		}
	}
}