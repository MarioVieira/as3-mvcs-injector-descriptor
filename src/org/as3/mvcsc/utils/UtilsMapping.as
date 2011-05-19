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

	public class UtilsMapping
	{
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
		
		public static function mapInjectorDescriptorRule(injector:IInjector, externalInjectorDescriptors:Vector.<DescriptorInjector>):void
		{
			for each(var descriptor:DescriptorInjector in externalInjectorDescriptors)
			{
				mapInjectorRule(injector, descriptor);
			}
		}
		
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
		
		public static function mapSignalCommandDescriptorRules(signalCommandMap:ISignalCommandMap, externalInjectorDescriptors:Vector.<DescriptorSignalCommand>):void
		{
			for each(var descriptor:DescriptorSignalCommand in externalInjectorDescriptors)
			{
				signalCommandMap.mapSignalClass( getClassFromQName(descriptor.signalClassQName), getClassFromQName(descriptor.signalCommandQName) ); 
			}
		}
		
		public static function mapMediatorDescriptorRules(mediatorMap:IMediatorMap, externalInjectorDescriptors:Vector.<DescriptorMediator>):void
		{
			for each(var descriptor:DescriptorMediator in externalInjectorDescriptors)
			{
				mediatorMap.mapView( getClassFromQName(descriptor.mapViewQName), getClassFromQName(descriptor.mediatorQName) );
			}
		}
		
		public static function getClassFromQName(qName:String):Class
		{
			return getDefinitionByName(qName) as Class;
		}
		
		public static function getInjectorDescriptorFromCairngormEventDescriptor(cairngormDescriptor:DescriptorCairngormEventMap):DescriptorInjector
		{
			var descriptor:DescriptorInjector = new DescriptorInjector();
			descriptor.mapSingletonQName 	  = cairngormDescriptor.signalClassQName;
			return descriptor;
		}
	}
}