package org.as3.bridge.core
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import org.as3.bridge.utils.UtilsCairngormEventToSignal;
	import org.as3.mvcsc.descriptors.DescriptorCairngormEventMap;
	import org.as3.mvcsc.utils.DescribeObject;
	import org.as3.mvcsc.vo.PropertiesCollection;
	import org.robotlegs.core.IInjector;

	/** 
	 * 
	 * Subscriber of CommandHandler via Bridge. It's catching Cairngorm events dispatched to trigger Commands.
	 * It assign the events properties into their respective mapped value objects, and broadcast these VOs via their mapped signals
	 * 
	 * @see org.as3.bridge.control.CommandHandler
	 * @see org.as3.bridge.utils.UtilsCairngormEventToSignal
	 * @see org.as3.mvcsc.utils.DescribeObject
	 * 
	 * @author Mario Vieira
	 * 
	 */
	public class CairngormCommandToSignal
	{
		/**
		 * The application injector 
		 */		
		[Inject]
		public var injector:IInjector;
		
		/**
		 * @private
		 */
		protected var _bridge 					:	Bridge;
	
		/** private **/
		[PostConstruct]
		public function init():void
		{
			setupInstances();
			observeCairngormCommandHandler();
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
		 * Subscriber the Cairgorm handler for all routed Cairngom Commands 
		 * 
		 **/
		protected function observeCairngormCommandHandler():void
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
		 * Handles routed Cairngorm commands 
		 * @param e
		 */
		protected function handlesCairngormCommand(e:CairngormEvent) : void
		{
			//Tracer.log(this, "handlesCairngormCommand");
			routeCommandToSignal(e);
		}
		
		/**
		 * 
		 * Get the properties of the Cairngorm event (dispatched to trigger a Command) into a value object, and broadcast it via a Signal (provided in CairngormBridge)
		 * @see org.as3.mvcsc.model.CairngormBridge
		 * 
		 * a - gets the CairngormEvent descriptor (respective Signal class QName, VO class QName, etc)
		 * @see org.as3.bridge.utils.UtilsCairngormEventToSignal.getCairngormEventDescriptor
		 * b - get the CairngormEvent event properties 
		 * @see org.as3.mvcsc.utils.DescribeObject.getObjectVariables
		 * c - create the respective VO class of the CairngormEvent (provided in the CairngormEvent event descriptor), and try assigning the found properties of CairngormEvent on it
		 * @see org.as3.bridge.utils.UtilsCairngormEventToSignal.getValueObjectWithPropertyCollectionValues
		 * d - get the injected Signal class respective to the CairngormEvent (provided in the CairngormEvent event descriptor), and dispatch the created VO for the subscribers 
		 * @see UtilsCairngormEventToSignal.getInjectedSignalFromCairngormEventDescriptor
		 *  
		 * @param event
		 * 
		 */		
		protected function routeCommandToSignal(event:CairngormEvent):void
		{
			var eventDescriptor:DescriptorCairngormEventMap = UtilsCairngormEventToSignal.getCairngormEventDescriptor(event, _bridge.cairgormBridgeDescriptor.descriptorCollection);
			var eventProperties:PropertiesCollection		= DescribeObject.getObjectVariables(event);
			var valueObjectWithCairngormEventProperties:*	= UtilsCairngormEventToSignal.getValueObjectWithPropertyCollectionValues(eventProperties, eventDescriptor.valueObjectQNameToReceiveEventProperties);
			
			//Tracer.log(this, "eventDescriptor - eventDescriptor: "+eventDescriptor+" valueObjectWithCairngormEventProperties: "+valueObjectWithCairngormEventProperties);
			UtilsCairngormEventToSignal.getInjectedSignalFromCairngormEventDescriptor(injector, eventDescriptor).dispatch(valueObjectWithCairngormEventProperties);
		}
	}
}
