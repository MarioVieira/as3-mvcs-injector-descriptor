package org.as3.bridge.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.as3.bridge.helpers.Bridge;
	
	/**
	 * 
	 * Routes mapped Cairngorm Events / Commands to an static reference to support the task of loosing coupling
	 * the application components and features from the static references of Cairngorm
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
			var wimpControl:Bridge = Bridge.getInstance();
			wimpControl.cairngormCommandHandler.handleCairngormCommand(event);
		}
	}
}