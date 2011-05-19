package org.as3.bridge.control
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.utils.getQualifiedClassName;
	
	import org.as3.mvcsc.utils.Tracer;

	public class ControlCommandQueue
	{
		/**
		 * 
		 * @private
		 * 
		 */		
		public function ControlCommandQueue()
		{
			_commands = new Vector.<CairngormEvent>();
		}
		  
		/**
		 * 
		 * @private
		 *  
		 */		
		protected var _commands:Vector.<CairngormEvent>;
		
		/**
		 * 
		 * @return Vector of added commands
		 * 
		 */		
		public function get commands():Vector.<CairngormEvent>
		{
			return _commands;
		}
		
		/**
		 * 
		 * @param event The CairgormEvent which had been mapped to the CommandHandler
		 * 
		 */		
		public function addCommandMappedFromEvent(event:CairngormEvent):void
		{
			Tracer.log(this, 'addCommandMappedFromEvent '+event);
			_commands.push(event);
		}
		
		/**
		 * 
		 * @cairngormEventToCheck  The event instance in which the check is to be performed
		 * @cairngormClassToCheck  The event class in which the check is to be performed
		 * @return The queued the event 
		 * 
		 */
		public function isCommandQueued(cairngormEventToCheck:CairngormEvent, cairngormClassToCheck:Class = null):CairngormEvent
		{
			for(var i:int; i < _commands.length; i++)
			{
				var checkClassName:String = (cairngormEventToCheck) ? getQualifiedClassName(cairngormEventToCheck) : getQualifiedClassName(cairngormClassToCheck);
				if(getQualifiedClassName(_commands[i]) == checkClassName)
				{
					var foundEvent:CairngormEvent = _commands[i];
					removeCommandIndex(i);
					return foundEvent;
				}
			}
			
			return null;
		}
		
		/** @private **/
		protected function removeCommandIndex(index:int):void
		{
			Tracer.log(this, 'removeCommandIndex '+_commands);
			_commands.slice(index, 1);										  
		}
	}
}