package org.as3.mvcsc.descriptors
{
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IMediatorMap;
	import org.robotlegs.core.ISignalCommandMap;

	public class DescriptorCore
	{
		public var injector			:IInjector;
		public var signalCommandMap	:ISignalCommandMap;
		public var mediatorMap		:IMediatorMap;
		
		public function DescriptorCore(injector:IInjector, signalCommandMap:ISignalCommandMap, mediatorMap:IMediatorMap):void
		{
			this.injector 			= injector;
			this.signalCommandMap 	= signalCommandMap;
			this.mediatorMap 		= mediatorMap;
		}
	}
}