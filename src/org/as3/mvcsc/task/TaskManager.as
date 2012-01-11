package org.as3.mvcsc.task
{
	import org.as3.mvcsc.interfaces.INotifier;
	import org.as3.mvcsc.interfaces.ITask;
	import org.as3.mvcsc.utils.Tracer;
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IInjector;
	import org.swiftsuspenders.Injector;
	
	public class TaskManager implements INotifier
	{
		public static const TASK_TIME_OUT:int = 60000;
		
		private var _taskSet			:TasksSet;
		private var _currentSequence	:int;
		private var _started			:Boolean;
		private var _notifier			:Signal;
		private var _success			:Boolean;
		
		public function TaskManager()
		{
			_notifier = new Signal(Boolean);
		}
		
		public function hasSucceded():Boolean
		{
			return _success; 
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
		
		public function executeTaskSet(taskSet:TasksSet, injector:IInjector):void
		{
			_started = true;
			_taskSet = taskSet;
			//Tracer.log(this, "executeTaskSet - _taskSet: "+_taskSet);
			executeSequenciesSimultaneously(taskSet, injector);
		}
		
		public function get started():Boolean
		{
			return _started;
		}
		
		private function executeSequenciesSimultaneously(taskSet:TasksSet, injector:IInjector):void
		{
			_currentSequence = 0;
			//Tracer.log(this, "executeSequenciesSimultaneously");
			for each(var sequence:TaskSequence in taskSet.sequences.sequences)
			{
				startTaskSequenceExecuter(sequence, injector);
			}
		}
		
		private function startTaskSequenceExecuter(sequence:TaskSequence, injector:IInjector):void
		{
			//Tracer.log(this, "startTaskSequenceExecuter");
			var executer:TasksExecuter = new TasksExecuter(TASK_TIME_OUT);
			executer.notifier.addOnce(onComplete);
			executer.startSequence(sequence, injector);
		}
		
		private function onComplete(successNotFailure:Boolean):void
		{
			_currentSequence ++;
			//Tracer.log(this, "onComplete - sequence index: "+_currentSequence +"  _success: "+(_currentSequence >= _taskSet.sequences.length) );
			
			if(_currentSequence >= _taskSet.sequences.length)
				_success = true;
			
			success();
		}
	}
}