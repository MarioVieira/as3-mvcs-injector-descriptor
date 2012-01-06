package org.as3.bridge.interfaces
{
	import org.as3.mvcsc.vo.CairngormBridge;
	import org.robotlegs.core.IInjector;

	public interface IBridgeProcess
	{
		/**
		 * 
		 * @param injector
		 * @param appFrameWorkDescriptor
		 * 
		 */
		function initializeBridge(injector:IInjector):void;
		
		/**
		 * 
		 * @param cairngormEventsRules
		 * 
		 */		
		function mapCairngormCommands(cairngormEventsRules:CairngormBridge):void
	}
}