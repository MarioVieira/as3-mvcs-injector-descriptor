package org.as3.mvcsc.interfaces
{
	import org.as3.mvcsc.descriptors.DescriptorSignalCommand;
	
	import org.robotlegs.core.ISignalCommandMap;

	public interface IMappingSignalCommand
	{
		function mapSignalCommands(signalCommandMap:ISignalCommandMap):void;
	}
}