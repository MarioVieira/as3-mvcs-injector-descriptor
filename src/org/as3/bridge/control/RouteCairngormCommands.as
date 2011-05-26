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
	 * It <code>addCairngormCommands</code> and <code>mapCommandSignal</code> of those Commands
	 * @see org.as3.mvcsc.model.CairngormBridge
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
				mapCommandSignal(item,injector);
				addCommand(item.cairngormEventType, CommandRouter);
			}
		}

		/**
		 * 
		 * @param item
		 * @param injector
		 * 
		 */
		protected function mapCommandSignal(item:DescriptorCairngormEventMap, injector:IInjector):void
		{
			Tracer.log(RouteCairngormCommands, "addCairngormCommands - cairngormEventQName: "+item.cairngormEventQName);
			UtilsMapping.mapInjectorRule(injector, UtilsMapping.getInjectorDescriptorFromCairngormEventDescriptor(item));
		}
	}
}