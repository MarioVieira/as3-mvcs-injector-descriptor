package org.as3.mvcsc.task
{
	import org.as3.mvcsc.interfaces.ITask;
	import org.as3.mvcsc.utils.Tracer;
	import org.as3.mvcsc.vo.TaskSequence;
	import org.as3.mvcsc.vo.TasksSet;
	import org.robotlegs.core.IInjector;
	import org.swiftsuspenders.Injector;
	
	public class TaskManager
	{
		public static const TASK_TIME_OUT:int = 60000;
		
		private var _taskSet			:TasksSet;
		private var _currentSequence	:int;
		
		public function TaskManager(){}
		
		public function executeTaskSet(taskSet:TasksSet, injector:IInjector):void
		{
			_taskSet = taskSet;
			executeSequenciesSimultaneously(taskSet, injector);
		}
		
		private function executeSequenciesSimultaneously(taskSet:TasksSet, injector:IInjector):void
		{
			_currentSequence = 0;
			Tracer.log(this, "executeSequenciesSimultaneously");
			for each(var sequence:TaskSequence in taskSet.sequences.sequences)
			{
				startTaskSequenceExecuter(sequence, injector);
			}
		}
		
		private function startTaskSequenceExecuter(sequence:TaskSequence, injector:IInjector):void
		{
			Tracer.log(this, "startTaskSequenceExecuter");
			var executer:TasksExecuter = new TasksExecuter(TASK_TIME_OUT);
			executer.notifier.addOnce(onComplete);
			executer.startSequence(sequence, injector);
		}
		
		private function onComplete(successNotFailure:Boolean):void
		{
			Tracer.log(this, "onComplete - sequence index: "+_currentSequence);
			_currentSequence ++;
		}
	}
}