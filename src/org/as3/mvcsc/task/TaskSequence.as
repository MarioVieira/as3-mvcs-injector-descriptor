package org.as3.mvcsc.task
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.as3.interfaces.IDispose;
	import org.as3.mvcsc.utils.Tracer;
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IInjector;
	
	public class TaskSequence extends Signal implements IDispose
	{
		protected var _injector			:IInjector;
		protected var _currentTask		:TaskInit;
		protected var _tasks			:Vector.<TaskInit>;
		protected var _currentTaskCount	:int;
		protected var _taskTimer		:Timer;
		
		public function TaskSequence(taskTimeout:Number = 60000)
		{
			_tasks 		= new Vector.<TaskInit>;	
			_taskTimer 	= new Timer(taskTimeout);
		}
		
		protected function setObservers():void
		{
			_taskTimer.addEventListener(TimerEvent.TIMER, onTaskTimeout);
		}
		
		public function addTask(task:TaskInit):void
		{
			_currentTaskCount = 0;
			_tasks.push(task);
		}
		
		public function addTasks(tasks:Vector.<TaskInit>):void
		{
			_tasks 		 = tasks;
			_currentTaskCount = 0;
		}
		
		public function startSequence(injector:IInjector):void
		{
			_injector = injector;
			setObservers();
			startNextTask();
		}
		
		protected function complete():void
		{
			Tracer.log(this, "complete()");
			dispatch();
			dispose();
		}
		
		protected function startNextTask():void
		{
			_currentTask = getNextTask();
			if(_currentTask) 
			{
				_currentTaskCount++;
				_currentTask.addOnce(onTaskExecuted);
				_currentTask.start(_injector);
				startTimer();
			}
			else
			{
				complete();
			} 
		}		
		
		private function startTimer():void
		{
			_taskTimer.reset();
			_taskTimer.start();
		}
		
		private function stopTimer():void
		{
			_taskTimer.stop();
		}
		
		protected function onTaskExecuted(success:Boolean):void
		{
			stopTimer();
			startNextTask();
		}
		
		protected function getNextTask():TaskInit
		{
			if(_currentTaskCount < _tasks.length) 
				return _tasks[_currentTaskCount];
			
			return null;
		}

		public function dispose(recursive:Boolean=true):void
		{
			_taskTimer.removeEventListener(TimerEvent.TIMER, onTaskTimeout);
		}
		
		protected function removeTaskObserver():void
		{
			if(_currentTask) _currentTask.remove(onTaskExecuted);
		}
		
		private function onTaskTimeout(e:Event):void
		{
			removeTaskObserver();
			stopTimer();
			startNextTask();
		}
	}
}