package org.as3.mvcsc.task
{
	import org.as3.mvcsc.interfaces.INotifier;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;
	
	
	public class TaskSequenceNotifier implements INotifier
	{
		private var _signal:Signal;
		
		public function TaskSequenceNotifier()
		{
			_signal = new Signal(Boolean);
		}
		
		public function get notifier():Signal
		{
			return _signal;
		}
		
		public function success():void
		{
			_signal.dispatch(true);
		}
		
		public function failure():void
		{
			_signal.dispatch(false);
		}
	}
}