package org.as3.mvcsc.task
{
	import flash.events.Event;
	
	import mx.binding.utils.ChangeWatcher;
	
	import org.as3.interfaces.IDispose;
	import org.as3.mvcsc.interfaces.ITask;
	import org.as3.mvcsc.utils.Tracer;
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IInitializer;
	import org.robotlegs.core.IInjector;
	
	/**
	 * 
	 * A task to be executed by sequentialy or simulatneously receiving the application injector and a piece of data
	 * 
	 * @author Mario Vieira
	 * 
	 */	
	
	public class TaskBase implements ITask, IDispose
	{
		protected var _notifier		:Signal;
		private var _watcher		:ChangeWatcher;
		private var _descriptor 	:TaskDescriptor;
		private var _successWatcher	:ChangeWatcher;
		
		public function TaskBase(descriptor:TaskDescriptor) 
		{
			_descriptor = descriptor;
			_notifier = new Signal(Boolean);
		}
		
		public function get descriptor():TaskDescriptor
		{
			return _descriptor;
		}

		public function get notifier():Signal
		{
			return _notifier;
		}
		
		/**
		 *  
		 * If the task descriptor uses has <code>executeTaskUponPropertyChange = true</code>, this method must be overriden, and success or failure implemented
		 *  
		 * @param injector
		 * 
		 */		
		public function start(injector:IInjector):void
		{
			if(_descriptor.executeTaskUponPropertyChange)
			{
				setupExecuteOnPropertyChange(_descriptor);
			} 
			else
			{
				throw new Error("descriptor():TaskDescriptor is NOT triggeredOnPropertyChange, therefore start(injector:IInjector):void MUST be implemented in subclass");
			}
		}
		
		/**
		 * 
		 * When <code>descriptor</code> is set to execute task upon a property change this method is called, and needs to be overriden as it will be called to execute the task
		 * Notice that a second listener is set to broadcast task execution success, so only the execution logic itself needs to be provided upon overriding this method
		 *  
		 * @param propertyName
		 * @param instance
		 * @return whether property can be watched or not 
		 * 
		 */
		protected function executeTaskUponPropertyChange(e:Event):void
		{
			throw new Error("executeTaskUponPropertyChange():void MUST be implemented in subclass");
		}
		
		private function setupExecuteOnPropertyChange(descriptor:TaskDescriptor):Boolean
		{
			var canWatch:Boolean = ChangeWatcher.canWatch(descriptor.propertyHost, descriptor.propertyName);
			
			if(!canWatch)
				return false;
			
			_watcher 		= ChangeWatcher.watch(descriptor.propertyHost, [descriptor.propertyName], executeTaskUponPropertyChange);
			_successWatcher = ChangeWatcher.watch(descriptor.propertyHost, [descriptor.propertyName], onWatchedPropertyChange);
			
			return true;
		}
		
		private function onWatchedPropertyChange(e:Event):void
		{
			dispose();
			success();
		}
		
		public function success():void
		{  
			_notifier.dispatch(true);
		}
		
		public function failure():void
		{
			_notifier.dispatch(false);
		}
		
		public function dispose(recursive:Boolean=true):void
		{
			if(_watcher && _successWatcher)
			{
				_watcher.unwatch();
				_successWatcher.unwatch();
			}
			
		}
	}
}