package org.as3.interfaces
{
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	/**
	 * @author Mario Vieira
	 */
	public interface IModelChange
	{
		function get dataChange():Signal;
		function broadcastModelChange(changeType:String):void;
	}
}
