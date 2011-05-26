package org.as3.bridge.core
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.model.IModelLocator;
	
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import org.as3.bridge.control.CommandHandler;
	import org.as3.bridge.interfaces.ICairngormToDIIoC;
	import org.as3.mvcsc.descriptors.DescriptorCairngormModelLocator;
	import org.as3.mvcsc.vo.CairngormBridge;
	import org.as3.mvcsc.utils.Tracer;
	import org.robotlegs.core.IInjector;

	/**
	 * 
	 * Provides the <code>injector</code> applications reference, the Cairngorm ModelLocators (serialized from XML) accessors, and the CommandHandler reference
	 * @see org.as3.bridge.control.CommandHandler
	 * 
	 * @author Mario Vieira
	 * 
	 */	
	public class Bridge implements ICairngormToDIIoC
	{
		public var cairgormBridgeDescriptor		: CairngormBridge;
		private var _cairngormCommandHandler	: CommandHandler;
		
		private static var _instance			: Bridge;
		
		
		/**
		 * Cairngorm command handler to receive all commands and broadcast it to the subscribers  
		 */
		public function get cairngormCommandHandler():CommandHandler
		{
			return _cairngormCommandHandler;
		}

		/**
		 * The bridge between Cairgorm and IoC
		 * 
		 * It provides the static reference of the ModelLocator, and a of generic Cairgorm CommandHandler (for subrscribers to catch the commands)
		 * 
		 */		
		public function Bridge(enforcer:SingletonEnforcer) 
		{	
			if(enforcer == null)
			{
				throw new Error("Singleton class - use Class.getInstance()");
			}
			else
			{
				_cairngormCommandHandler = new CommandHandler();
			}
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public static function getInstance() : Bridge 
		{
			if (_instance == null) 
			{
				_instance = new Bridge(new SingletonEnforcer);
			}
			return _instance;
		}

		
		/**
		 * 
		 * @copy com.amp.wimp.phase2.bridge.interfaces.ICairngormMigrationToDIwithIoC#applicationInjector
		 * @see com.amp.wimp.phase2.bridge.interfaces.ICairngormMigrationToDIwithIoC#applicationInjector
		 * 
		 */		
		public function set applicationInjector(injector : IInjector) : void
		{
			cairngormCommandHandler.applicationInjector = injector;
		}
		
		/**
		 * 
		 * @copy com.amp.wimp.phase2.bridge.interfaces.ICairngormMigrationToDIwithIoC#applicationInjector
		 * @see com.amp.wimp.phase2.bridge.interfaces.ICairngormMigrationToDIwithIoC#applicationInjector
		 * 
		 */		
		public function get applicationInjector() : IInjector
		{
			return cairngormCommandHandler.applicationInjector;
		}
		
		
		/** 
		 * 
		 * @param eventReceived The dispatched Cairgorm Event cought by the CommandHandler 
		 * @param eventExpected The event class the caller expects in order to perform it's functionality
		 * @param removeQueuedCommand Whether it should use <code>isCommandQueued</code> to remove the reference of this command in the CommandQueue
		 * @return The event typed in accordance with the <code>eventExpected</code> class
		 *
		 * <listing version="3.0">
		 * Example:
		 * 	var event:GetPurchasedTracksEvent = (bridge.canExecuteCommand(e, GetPurchasedTracksEvent, removeQueuedEvent)) ? e as GetPurchasedTracksEvent : null;
		 * </listing>  
		 * 
		 * 
		 */
		public function canExecuteCommand(eventReceived:CairngormEvent, eventExpected:Class, removeQueuedCommand:Boolean) : Boolean
		{
			if(removeQueuedCommand) cairngormCommandHandler.isCommandQueued(eventReceived, eventExpected);
			return ( getQualifiedClassName(eventReceived) == getQualifiedClassName(eventExpected) );
		}
		
		/** 
		 * 
		 * @copy com.amp.wimp.phase2.bridge.interfaces.ICairngormMigrationToDIwithIoC#isCommandQueued
		 * @see com.amp.wimp.phase2.bridge.interfaces.ICairngormMigrationToDIwithIoC#isCommandQueued
		 * 
		 */
		public function isCommandQueued(cairngormEventToCheck:CairngormEvent, cairngormClassToCheck:Class = null) : CairngormEvent
		{
			return cairngormCommandHandler.isCommandQueued(cairngormEventToCheck, cairngormClassToCheck);
		}

		/**
		 * 
		 * @copy com.amp.wimp.phase2.bridge.interfaces.ICairngormMigrationToDIwithIoC#handleCairngormCommand
		 * @see com.amp.wimp.phase2.bridge.interfaces.ICairngormMigrationToDIwithIoC#handleCairngormCommand
		 * 
		 */		
		public function handleCairngormCommand(e : CairngormEvent) : void
		{
			cairngormCommandHandler.handleCairngormCommand(e);				
		}

		/**
		 * 
		 * @copy com.amp.wimp.phase2.bridge.interfaces.ICairngormMigrationToDIwithIoC#dispatchCairngormEvent
		 * @see com.amp.wimp.phase2.bridge.interfaces.ICairngormMigrationToDIwithIoC#dispatchCairngormEvent
		 * 
		 */		
		public function dispatchCairngormEvent(e : CairngormEvent) : void
		{
			cairngormCommandHandler.dispatchCairngormEvent(e);			
		}
		
		/**
		 * 
		 * @param nickName
		 * @return 
		 * 
		 */		
		public function getModelLocatorInstance(nickName:String = null) : IModelLocator
		{
			var clazz:* = getModelLocatorClass(nickName);
			try{ return clazz.getInstance(); }
			catch(er:Error){ Tracer.log(this, er.toString()); }
			
			return null;
		}
		
		/**
		 * 
		 * @param nickName
		 * @return 
		 * 
		 */		
		protected function getModelLocatorClass(nickName:String) : Class
		{
			var classQName:String;
			
			if(cairgormBridgeDescriptor)
			{
				for each(var modelInfo:DescriptorCairngormModelLocator in cairgormBridgeDescriptor.cairngornModelLocators)
				{
					if(modelInfo.nick == nickName) 	classQName = modelInfo.modelLocatorQName;
				}
			}
			
			return (classQName) ? getDefinitionByName(classQName) as Class : null;
		}
	}
}

class SingletonEnforcer {}