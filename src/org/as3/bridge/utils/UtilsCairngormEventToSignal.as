package org.as3.bridge.utils
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.utils.getDefinitionByName;
	
	import org.as3.mvcsc.descriptors.DescriptorCairngormEventMap;
	import org.as3.mvcsc.utils.Tracer;
	import org.as3.mvcsc.utils.UtilsMapping;
	import org.as3.mvcsc.vo.PropertiesCollection;
	import org.as3.mvcsc.vo.PropertyInfo;
	import org.as3.serializer.factories.ObjectFactory;
	import org.osflash.signals.ISignalOwner;
	import org.robotlegs.core.IInjector;

	/**
	 * @private
	 */
	public class UtilsCairngormEventToSignal
	{
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
		
		public static function getCairngormEventDescriptor(event:CairngormEvent, cairngormEventRules:Vector.<DescriptorCairngormEventMap>):DescriptorCairngormEventMap
		{
			for each(var descriptor:DescriptorCairngormEventMap in cairngormEventRules)
			{
				if(event is UtilsMapping.getClassFromQName(descriptor.cairngormEventQName) ) return descriptor;	
			}
			
			return null;
		}
		
		public static function getInjectedSignalFromCairngormEventDescriptor(injector:IInjector, eventDescriptor:DescriptorCairngormEventMap):ISignalOwner
		{
			return injector.getInstance( getDefinitionByName( eventDescriptor.signalClassQName ) as Class );
		}
		
		public static function getValueObjectWithPropertyCollectionValues(collection : PropertiesCollection, valueObjectClassQName:String) : *
		{
			if(valueObjectClassQName)
			{
				var valueObject:* = ObjectFactory.getDataTypedObject(valueObjectClassQName);
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
				Tracer.log(UtilsCairngormEventToSignal, "See CairngormBridge.xml: No value object class provided to produce a it via a PropertiesCollection (CairngormEvent to Signal)");
			}
			
			return valueObject;
		}
	}
}