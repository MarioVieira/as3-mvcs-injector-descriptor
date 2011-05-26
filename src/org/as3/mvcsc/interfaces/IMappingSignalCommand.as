package org.as3.mvcsc.interfaces
{
	import org.as3.mvcsc.descriptors.DescriptorSignalCommand;
	
	import org.robotlegs.core.ISignalCommandMap;

	/**
	 * 
	 * @author Mario Vieira
	 * 
	 */
	public interface IMappingSignalCommand
	{
		/**
		 * 
		 * @param signalCommandMap
		 * 
		 */
		function mapSignalCommands(signalCommandMap:ISignalCommandMap):void;
	}
}