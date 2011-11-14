package org.as3.mvcsc.task
{
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IInitializer;
	import org.robotlegs.core.IInjector;
	import org.as3.mvcsc.interfaces.ITask;
	
	/**
	 * 
	 * A task to be executed by sequentialy or simulatneously receiving the application injector and a piece of data
	 * 
	 * @author Mario Vieira
	 * 
	 */	
	
	public class Task implements ITask
	{
		protected var _notifier	: Signal;
		
		public function Task() 
		{
			_notifier = new Signal(Boolean);
		}
		
		public function get notifier():Signal
		{
			return _notifier;
		}
		
		public function start(injector:IInjector):void
		{
			throw new Error("start(injector:IInjector, data:Object = null):void MUST be implemented in subclass");	
		}
		
		public function success():void
		{
			_notifier.dispatch(true);
		}
		
		public function failure():void
		{
			_notifier.dispatch(false);
		}
	}
}