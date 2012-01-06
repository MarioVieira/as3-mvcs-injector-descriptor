package org.as3.interfaces
{
	import org.osflash.signals.ISignal;
	

	/**
	 * @author Mario Vieira
	 */
	public interface IModelChange
	{
		function get dataChange()						:ISignal;
		//function broadcastModelChange(changeType:String):void;
	}
}