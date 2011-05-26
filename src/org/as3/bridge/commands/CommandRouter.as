package org.as3.bridge.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.as3.bridge.core.Bridge;
	
	/**
	 * 
	 * Routes Cairngorm Commands execution to a static reference of ControlCommandHandler
	 * @see org.as3.bridge.control.CommandHandler
	 * 
	 * @author Mario Vieira
	 * 
	 */	
	public class CommandRouter implements ICommand
	{
		/**
		 * 
		 * @param event Any CairngormEvent to be propagated through the CairngormCommandHandler
		 * 
		 */		
		public function execute(event:CairngormEvent):void
		{
			var handler:Bridge = Bridge.getInstance();
			handler.cairngormCommandHandler.handleCairngormCommand(event);
		}
	}
}