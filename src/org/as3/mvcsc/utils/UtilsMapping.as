package org.as3.mvcsc.utils
{
	import org.as3.mvcsc.descriptors.DescriptorCairngormEventMap;
	import org.as3.mvcsc.descriptors.DescriptorInjector;
	import org.as3.mvcsc.descriptors.DescriptorMediator;
	import org.as3.mvcsc.descriptors.DescriptorSignalCommand;
	
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IMediatorMap;
	import org.robotlegs.core.ISignalCommandMap;

	/**
	 * 
	 * 
	 * Assists in mapping injection, mediator, and signal commands rules
	 * 
	 * @author Mario Vieira
	 */
	public class UtilsMapping
	{
		/**
		 * 
		 * @param whenAskedFor
		 * @param useClass
		 * @return 
		 * 
		 */
		public static function getInjectorRule(whenAskedFor:Class, useClass:Class = null):DescriptorInjector
		{
			var injectorRule:DescriptorInjector = new DescriptorInjector();
			
			if(useClass) 
			{
				injectorRule.whenAskedForQName = getQualifiedClassName(whenAskedFor);
				injectorRule.useSingletonOfQName = getQualifiedClassName(useClass);
			}
			else
			{
				injectorRule.mapSingletonQName = getQualifiedClassName(whenAskedFor);
			}
			
			return injectorRule;
		}
		
		/**
		 * 
		 * @param injector
		 * @param externalInjectorDescriptors
		 * 
		 */
		public static function mapInjectorDescriptorRule(injector:IInjector, externalInjectorDescriptors:Vector.<DescriptorInjector>):void
		{
			for each(var descriptor:DescriptorInjector in externalInjectorDescriptors)
			{
				mapInjectorRule(injector, descriptor);
			}
		}
		
		/**
		 * 
		 * @param injector
		 * @param descriptor
		 * 
		 */
		public static function mapInjectorRule(injector:IInjector, descriptor:DescriptorInjector):void
		{
			if(descriptor.whenAskedForQName && descriptor.useSingletonOfQName) 
			{ 
				injector.mapSingletonOf( getClassFromQName(descriptor.whenAskedForQName), getClassFromQName(descriptor.useSingletonOfQName) );
			}
			else if(descriptor.mapSingletonQName)
			{
				injector.mapSingleton( getClassFromQName(descriptor.mapSingletonQName) );
			}
			
		}
		
		/**
		 * 
		 * @param signalCommandMap
		 * @param externalInjectorDescriptors
		 * 
		 */
		public static function mapSignalCommandDescriptorRules(signalCommandMap:ISignalCommandMap, externalInjectorDescriptors:Vector.<DescriptorSignalCommand>):void
		{
			for each(var descriptor:DescriptorSignalCommand in externalInjectorDescriptors)
			{
				signalCommandMap.mapSignalClass( getClassFromQName(descriptor.signalClassQName), getClassFromQName(descriptor.signalCommandQName) ); 
			}
		}
		
		/**
		 * 
		 * @param mediatorMap
		 * @param externalInjectorDescriptors
		 * 
		 */
		public static function mapMediatorDescriptorRules(mediatorMap:IMediatorMap, externalInjectorDescriptors:Vector.<DescriptorMediator>):void
		{
			for each(var descriptor:DescriptorMediator in externalInjectorDescriptors)
			{
				mediatorMap.mapView( getClassFromQName(descriptor.mapViewQName), getClassFromQName(descriptor.mediatorQName) );
			}
		}
		
		/**
		 * 
		 * @param qName
		 * @return 
		 * 
		 */
		public static function getClassFromQName(qName:String):Class
		{
			return getDefinitionByName(qName) as Class;
		}
		
		/**
		 * 
		 * @param cairngormDescriptor
		 * @return 
		 * 
		 */
		public static function getInjectorDescriptorFromCairngormEventDescriptor(cairngormDescriptor:DescriptorCairngormEventMap):DescriptorInjector
		{
			var descriptor:DescriptorInjector = new DescriptorInjector();
			descriptor.mapSingletonQName 	  = cairngormDescriptor.signalClassQName;
			return descriptor;
		}
	}
}