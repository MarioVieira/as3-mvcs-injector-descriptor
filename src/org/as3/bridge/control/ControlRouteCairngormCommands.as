package org.as3.bridge.control
{
	import com.adobe.cairngorm.control.FrontController;
	
	import org.as3.bridge.commands.CommandRouter;
	import org.as3.mvcsc.descriptors.DescriptorCairngormEventMap;
	import org.as3.mvcsc.model.CairngormBridge;
	import org.as3.mvcsc.utils.Tracer;
	import org.as3.mvcsc.utils.UtilsMapping;
	import org.robotlegs.core.IInjector;
	
	public class ControlRouteCairngormCommands extends FrontController
	{
		public function addCairngormCommands(injector:IInjector, descriptor:CairngormBridge):void
		{
			//Loop through and add commands
			for each(var item:DescriptorCairngormEventMap in descriptor.descriptorCollection)
			{
				Tracer.log(ControlRouteCairngormCommands, "addCairngormCommands - cairngormEventQName: "+item.cairngormEventQName);
				UtilsMapping.mapInjectorRule(injector, UtilsMapping.getInjectorDescriptorFromCairngormEventDescriptor(item));
				addCommand(item.cairngormEventType, CommandRouter);
			}
		}  
	}
}