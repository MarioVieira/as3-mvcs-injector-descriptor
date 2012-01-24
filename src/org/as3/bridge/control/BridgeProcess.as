package org.as3.bridge.control
{
	import org.as3.bridge.control.RouteCairngormCommands;
	import org.as3.bridge.core.Bridge;
	import org.as3.bridge.core.CairngormCommandToSignal;
	import org.as3.bridge.interfaces.IBridgeProcess;
	import org.as3.interfaces.IBackgroundProcess;
	import org.as3.mvcsc.descriptors.DescriptorExternalAppFrameWork;
	import org.as3.mvcsc.utils.Tracer;
	import org.as3.mvcsc.vo.CairngormBridge;
	import org.robotlegs.core.IInjector;

	public class BridgeProcess implements IBridgeProcess
	{
		/** @private **/
		protected var _cairngormRouter					:CairngormCommandToSignal;
		
		/** @private **/
		protected var _bridge							:Bridge;
		
		/** @private **/
		protected var _routedCairngormFronController	:RouteCairngormCommands;
		
		/** @private **/
		protected var _injector							:IInjector;
		
		public function initializeBridge(injector:IInjector):void
		{
			//Tracer.log(this, "initialize()");
			injector.mapSingleton(RouteCairngormCommands);
			injector.mapSingleton(CairngormCommandToSignal);
			
			_injector						 = injector;
			_bridge							 = Bridge.getInstance();
			_bridge.applicationInjector		 = injector;
			_routedCairngormFronController   = injector.getInstance(RouteCairngormCommands);
			_cairngormRouter 			 	 = injector.getInstance(CairngormCommandToSignal);
		}

		public function mapCairngormCommands(cairngormEventsRules:CairngormBridge):void
		{
			_bridge.cairgormBridgeDescriptor = cairngormEventsRules;
			_routedCairngormFronController.addCairngormCommands(_injector, cairngormEventsRules);
		}
	}
}