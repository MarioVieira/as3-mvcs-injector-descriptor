package org.as3.mvcsc.task
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.as3.interfaces.IDispose;
	import org.as3.mvcsc.interfaces.ITask;
	import org.as3.mvcsc.utils.Tracer;
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IInjector;
	
	public class TaskSequence extends Signal implements IDispose
	{
		protected var _injector					:IInjector;
		protected var _currentTask				:ITask;
		protected var _tasks					:Vector.<ITask>;
		protected var _currentTaskCount			:int;
		protected var _taskTimer				:Timer;
		protected var _simultaneousNotSequential:Boolean; 
		
		public function TaskSequence(taskTimeout:Number = 60000, simultaneousNotSequential:Boolean = true)
		{
			_tasks 		= new Vector.<ITask>;
			_taskTimer 	= new Timer(taskTimeout);
		}
		
		protected function setObservers():void
		{
			_taskTimer.addEventListener(TimerEvent.TIMER, onTaskTimeout);
		}
		
		/**
		 *
		 * Adds tasks to the a first sequence
		 *  
		 * @param task
		 * 
		 */		
		public function addTask(task:ITask):void
		{
			_currentTaskCount = 0;
			_tasks.push(task);
		}
		
		/**
		 *
		 * Adds a sequence of tasks for execution
		 *  
		 * @param task
		 * 
		 */
		
		public function addTasks(tasks:Vector.<ITask>):void
		{
			_tasks 			  = tasks;
			_currentTaskCount = 0;
		}
		
		public function startSequence(injector:IInjector):void
		{
			_injector = injector;
			setObservers();
			if(!_simultaneousNotSequential)
			{
				startNextTask();
			}
			else
			{
				fireAllTasks();
			}
		}
		
		private function fireAllTasks():void
		{
			for each(var task:ITask in _tasks)
			{
				task.start(_injector);
			}
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
				_currentTask.notifier.add(onTaskExecuted);
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
		
		protected function getNextTask():ITask
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
			if(_currentTask) 
				_currentTask.notifier.remove(onTaskExecuted);
		}
		
		private function onTaskTimeout(e:Event):void
		{
			removeTaskObserver();
			stopTimer();
			startNextTask();
		}
	}
}