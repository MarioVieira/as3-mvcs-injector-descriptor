package org.as3.bridge.interfaces
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.as3.bridge.control.CommandHandler;
	import org.robotlegs.core.IInjector;
	
	/** 
	 * 
	 * @author Mario Vieira
	 * 
	 */
	public interface ICairngormToDIIoC
	{
	
		function set applicationInjector(injector:IInjector):void
			
		
		function get applicationInjector():IInjector
		
		/**
		 * 
		 * @param e 
		 * 
		 */		
		function handleCairngormCommand(e:CairngormEvent):void
		
		/**
		 * 
		 * @param e
		 * 
		 */		
		function dispatchCairngormEvent(e:CairngormEvent):void
	}
}
