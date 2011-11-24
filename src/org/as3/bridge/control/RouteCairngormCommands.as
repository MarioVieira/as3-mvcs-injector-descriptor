package org.as3.bridge.control
{
	import com.adobe.cairngorm.control.FrontController;
	
	import org.as3.bridge.commands.CommandRouter;
	import org.as3.mvcsc.descriptors.DescriptorCairngormEventMap;
	import org.as3.mvcsc.vo.CairngormBridge;
	import org.as3.mvcsc.utils.Tracer;
	import org.as3.mvcsc.utils.UtilsMapping;
	import org.robotlegs.core.IInjector;
	
	
	/**
	 * 
	 * It <code>addCairngormCommands</code> to CommandRouter via protected <code>mapSignal</code> method (converts an event into a Signal)
	 * @see org.as3.mvcsc.model.CairngormBridge
	 * @see org.as3.bridge.commands.CommandRouter
	 * 
	 * @author Mario Vieira
	 * 
	 */
	public class RouteCairngormCommands extends FrontController
	{
		
		/**
		 * 
		 * @param injector
		 * @param descriptor
		 * 
		 */
		public function addCairngormCommands(injector:IInjector, descriptor:CairngormBridge):void
		{
			//Loop through and add commands
			for each(var item:DescriptorCairngormEventMap in descriptor.descriptorCollection)
			{
				mapSignal(item,injector);
				Tracer.log(RouteCairngormCommands, "addCairngormCommands - cairngormEventQName: "+item.cairngormEventQName);
				addCommand(item.cairngormEventType, CommandRouter);
			}
		}

		/**  
		 * 
		 * @param item
		 * @param injector
		 * 
		 */
		protected function mapSignal(item:DescriptorCairngormEventMap, injector:IInjector):void
		{
			if(!item.mapSignalClass)
				return;
			
			Tracer.log(RouteCairngormCommands, "mapSignal - signalClassQName: "+item.signalClassQName);
			UtilsMapping.mapInjectorRule(injector, UtilsMapping.getInjectorDescriptorFromCairngormEventDescriptor(item));
		}
	}
}