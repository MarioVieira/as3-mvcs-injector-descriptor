package org.as3.bridge.helpers
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.as3.bridge.utils.UtilsCairngormEventToSignal;
	import org.as3.mvcsc.descriptors.DescriptorCairngormEventMap;
	import org.as3.mvcsc.utils.DescribeObject;
	import org.as3.mvcsc.utils.Tracer;
	import org.as3.mvcsc.vo.PropertiesCollection;
	import org.robotlegs.core.IInjector;

	/** 
	 * @author Mario Vieira
	 * 
	 * This class is catching and sending Cairngorm events to abstract its dependency into IoC and DI
	 * 
	 */
	public class HelperCairngormRouter
	{
		[Inject]
		public var injector:IInjector;
		
		/**
		 * @private
		 */
		protected var _bridge 					:	Bridge;
	
		[PostConstruct]
		public function init():void
		{
			setupInstances();
			setupCairngormCommandHandler();
		}	

		/**
		 * @private
		 */
		protected function setupInstances() : void
		{
			_bridge = Bridge.getInstance();
		}
		
		/** 
		 * 
		 * Adds the Cairgorm handler, and checks if of the Cairngorm mapped commands are queued (events dispatched before the application frame work is setup) 
		 * 
		 **/
		protected function setupCairngormCommandHandler():void
		{
			_bridge.cairngormCommandHandler.add(handlesCairngormCommand);
			//checkForQueuedCairngormCommands();
		}
		
		/** 
		 * 
		 * Loops through all assigned commands in the RoutedCairngormController and checks whether they are queued in the IoCBridge 
		 *
		 **/ 
		 
		/*protected function checkForQueuedCairngormCommands():void
		{
			for each(var propInfo:PropertyInfo in RoutedCairngormController.routedCairgormEvents)
			{
				var canExecute:Boolean = _bridge.canExecuteCommand(propInfo.value as CairngormEvent, propInfo.value, true);
				if(canExecute) handlesCairngormCommand(propInfo.value as CairngormEvent);
			}
		}*/
		
		/** 
		 * 
		 * Handles all Cairngorm commands calls, and send them to the signal bus 
		 * @param e
		 */
		protected function handlesCairngormCommand(e:CairngormEvent) : void
		{
			//Tracer.log(this, "handlesCairngormCommand");
			//var event:GetPurchasedTracksEvent = (commonUIControl.bridge.canExecuteCommand(e, GetPurchasedTracksEvent, removeQueuedEvent)) ? e as GetPurchasedTracksEvent : null;
			routeCairngormEventToSignal(e);
		}
		
		/**
		 * 
		 * Steps:
		 * a - gets the CairngormEvent descriptor (respective Signal class QName, VO class QName, etc)
		 * @see UtilsCairngormEventToSignal.getCairngormEventDescriptor
		 * b - get the CairngormEvent event properties 
		 * @see com.amp.wimp.phase2.utils.descriptors.DescribeObject.getObjectVariables
		 * c - create the respective VO class of the CairngormEvent (provided in the CairngormEvent event descriptor), and try assigning the found properties of CairngormEvent on it
		 * @see UtilsCairngormEventToSignal.getValueObjectWithPropertyCollectionValues
		 * d - get the injected Signal class respective to the CairngormEvent (provided in the CairngormEvent event descriptor), and dispatch the created VO for the subscribers 
		 * @see UtilsCairngormEventToSignal.getInjectedSignalFromCairngormEventDescriptor
		 *  
		 * @param event
		 * 
		 */		
		protected function routeCairngormEventToSignal(event:CairngormEvent):void
		{
			//eg: object was VOGetPurchasedTracks
			//reads: _signalBus.getPurchasedTracks( DynamicSignalFactory.factorValueObject(e, RoutedCairngormController.routedCairgormEvents).dispatch(object) );
			
			var eventDescriptor:DescriptorCairngormEventMap 	= UtilsCairngormEventToSignal.getCairngormEventDescriptor(event, _bridge.cairgormBridgeDescriptor.descriptorCollection);
			var eventProperties:PropertiesCollection			= DescribeObject.getObjectVariables(event);
			var valueObjectWithCairngormEventProperties:*		= UtilsCairngormEventToSignal.getValueObjectWithPropertyCollectionValues(eventProperties, eventDescriptor.valueObjectQNameToReceiveEventProperties);
			
			Tracer.log(this, "eventDescriptor - eventDescriptor: "+eventDescriptor+" valueObjectWithCairngormEventProperties: "+valueObjectWithCairngormEventProperties);
			
			UtilsCairngormEventToSignal.getInjectedSignalFromCairngormEventDescriptor(injector, eventDescriptor).dispatch(valueObjectWithCairngormEventProperties);
		}
	}
}
