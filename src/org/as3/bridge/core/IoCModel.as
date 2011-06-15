package org.as3.bridge.core
{
	import org.as3.mvcsc.descriptors.DescriptorCore;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IMediatorMap;
	import org.robotlegs.core.ISignalCommandMap;
	
	public class IoCModel
	{
		public static const NO_CONSTRUCTOR:String = "org.as3.bridge.core.IoCModel is direct access to the injector dictionaries | 1st call: setCoreModel, then access its getters";
		public static const GET_CORE_MODEL_ERROR:String = "org.as3.bridge.core.IoCModel.coreModel - 1st you need to call: IoCModel.setCoreModel(injector:IInjector, mediatorMap:IMediatorMap, signalCmmand:ISignalCommandMap)";
		
		private static var _descriptorCore:DescriptorCore;
		
		public function IoCModel()
		{
			throw new Error(NO_CONSTRUCTOR);
		}
		
		public static function setCoreModel(injector:IInjector, mediatorMap:IMediatorMap, signalCmmand:ISignalCommandMap):void
		{
			_descriptorCore = new DescriptorCore(injector, signalCmmand, mediatorMap);
		}
		
		public static function get coreModel():DescriptorCore
		{ 
			if(!_descriptorCore) throw new Error(GET_CORE_MODEL_ERROR);
			return _descriptorCore;
		}
		
		public static function get injector():IInjector
		{
			return coreModel.injector;
		}
		
		public static function get signalCommandMap():ISignalCommandMap
		{
			return coreModel.signalCommandMap;
		}
		
		public static function get mediatorMap():IMediatorMap
		{
			return coreModel.mediatorMap;
		}
	}
}