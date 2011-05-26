package org.as3.bridge.control
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.as3.bridge.interfaces.ICairngormToDIIoC;
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IInjector;
	
	/**
	 * 
	 * Catches the Cairngorm events, assigns them to a queue and propagate them
	 * 
	 * @author Mario Vieira
	 *    
	 */	
	public class CommandHandler extends Signal implements ICairngormToDIIoC
	{
		/** @private **/
		protected var _commandQueue				: CommandQueue;
		
		/** @private **/
		protected var _signalCairgormCommand 	: Signal;
		
		/** @private **/
		protected var _applicationInjector 		: IInjector;
		
		/** @private **/
		public function CommandHandler()
		{
			super(CairngormEvent);
			//if(!blocker) throw new Error(EnumsCairngorm.ONLY_ONE_SINGLETON);
			
			_commandQueue = new CommandQueue();
		}
		
		/** @return The app frame work injector (DI) **/
		public function set applicationInjector(injector:IInjector):void
		{
			_applicationInjector = injector;
		}
		
		/** @return The app frame work injector (DI)  **/
		public function get applicationInjector():IInjector
		{
			return _applicationInjector;	
		}
		
		/**
		 * 
		 * It dispatches CairgormEvents of any type for the subscribers to receive it
		 * 
		 * @param e CairgormEvents for subscribers
		 * 
		 */		
		public function handleCairngormCommand(e:CairngormEvent):void
		{
			_commandQueue.addCommandMappedFromEvent(e);	
			dispatch(e);
		}
		
		/**
		 * 
		 * @cairngormEventToCheck  The event instance in which the check is to be performed
		 * @cairngormClassToCheck  The event class in which the check is to be performed
		 * @return Queued event
		 * 
		 */
		public function isCommandQueued(cairngormEventToCheck:CairngormEvent, cairngormClassToCheck:Class = null):CairngormEvent
		{
			return _commandQueue.isCommandQueued(cairngormEventToCheck, cairngormClassToCheck);
		}
		
		/**
		 *
		 * This function will help abstracting all members that are dispatching Cairngorm events
		 *  
		 **/
		public function dispatchCairngormEvent(e:CairngormEvent):void
		{
			e.dispatch();
		}
	}
}