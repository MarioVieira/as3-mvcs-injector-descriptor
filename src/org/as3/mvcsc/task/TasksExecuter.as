package org.as3.mvcsc.task
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.as3.interfaces.IDispose;
	import org.as3.mvcs.interfaces.INotifier;
	import org.as3.mvcsc.interfaces.ITask;
	import org.as3.mvcsc.utils.Tracer;
	import org.as3.mvcsc.vo.TaskSequence;
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IInjector;
	
	public class TasksExecuter implements INotifier, IDispose
	{
		protected var _injector					:IInjector;
		protected var _currentTask				:ITask;
		protected var _tasks					:TaskSequence;
		protected var _currentTaskCount			:int;
		protected var _taskTimer				:Timer;
		
		private var _notifier:Signal;
		
		public function TasksExecuter(taskTimeout:Number = 60000)
		{
			_taskTimer 	= new Timer(taskTimeout);
			_notifier   = new Signal();
		}
		
		public function dispose(recursive:Boolean=true):void
		{
			_taskTimer.removeEventListener(TimerEvent.TIMER, onTaskTimeout);
		}
		
		public function get notifier():Signal
		{
			return _notifier;	
		}
		
		public function success():void
		{
			_notifier.dispatch(true);
		}
		
		public function failure():void
		{
			_notifier.dispatch(false);
		}
		
		protected function setObservers():void
		{
			_taskTimer.addEventListener(TimerEvent.TIMER, onTaskTimeout);
		}
		
		public function startSequence(sequence:TaskSequence, injector:IInjector):void
		{
			_tasks = sequence;
			Tracer.log(this, "startSequence - sequence.simultaneousNotSequential: "+sequence.simultaneousNotSequential);
			
			_injector = injector;
			setObservers();
			
			if(!sequence.simultaneousNotSequential)
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
			for each(var task:ITask in _tasks.sequence)
			{
				task.start(_injector);
			}
			
			complete();
		}
		
		protected function complete():void
		{
			//Tracer.log(this, "complete()");
			success();
			dispose();
		}
		
		protected function startNextTask():void
		{
			_currentTask = getNextTask();
			//Tracer.log(this, "startNextTask() - _currentTask: "+_currentTask);
			
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
		
		protected function getNextTask():ITask
		{
			if(_currentTaskCount < _tasks.length) 
				return _tasks.getTask(_currentTaskCount);
			
			return null;
		}
		
		protected function removeTaskObserver():void
		{
			if(_currentTask) 
				_currentTask.notifier.remove(onTaskExecuted);
		}
		
		protected function onTaskExecuted(success:Boolean):void
		{
			stopTimer();
			startNextTask();
		}
		
		private function onTaskTimeout(e:Event):void
		{
			removeTaskObserver();
			stopTimer();
			startNextTask();
		}
	}
}