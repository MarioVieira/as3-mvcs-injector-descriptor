package org.as3.bridge.interfaces
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import org.as3.bridge.control.ControlCommandHandler;
	import org.robotlegs.core.IInjector;
	/** 
	 * @author Mario Vieira
	 */
	public interface ICairngormToDIIoC
	{
	
	
	/** @return The app frame work injector (DI) **/
		function set applicationInjector(injector:IInjector):void
		
		/** @return The app frame work injector (DI)  **/
		function get applicationInjector():IInjector
		
		/**
		 * 
		 * It dispatches CairgormEvents of any type for the subscribers to receive it
		 * 
		 * @param e CairgormEvents for subscribers
		 * 
		 */		
		function handleCairngormCommand(e:CairngormEvent):void
		
		/**
		 *
		 * This function will help abstracting all members that are dispatching Cairngorm events
		 *  
		 **/
		function dispatchCairngormEvent(e:CairngormEvent):void
	}
}
