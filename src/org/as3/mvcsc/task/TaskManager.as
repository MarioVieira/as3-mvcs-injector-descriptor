package org.as3.mvcsc.task
{
	import org.as3.mvcsc.interfaces.INotifier;
	import org.as3.mvcsc.signals.SignalStartupSequences;
	import org.as3.mvcsc.task.utils.TasksUtils;
	import org.as3.mvcsc.task.vo.TaskSequenceInfo;
	import org.as3.mvcsc.utils.Tracer;
	import org.as3.mvcsc.vo.VOStartupSequences;
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IInjector;
	
	public class TaskManager implements INotifier
	{
		public static const TASK_TIME_OUT	:int = 60000;
		
		private var _taskSet				:TasksSet;
		private var _currentSequence		:int = 0;
		private var _started				:Boolean;
		private var _notifier				:Signal;
		private var _success				:Boolean;
		private var _injector				:IInjector;
		private var _sequencesExecutionInfo	:Vector.<TaskSequenceInfo>;
		private var _signalRestartSequence	:SignalStartupSequences;
		
		public function TaskManager()
		{
			_notifier = new Signal(Boolean);
		}
		
		private function setupSequencesRestart(signal:SignalStartupSequences):void
		{
			_signalRestartSequence = signal;
			_signalRestartSequence.add(onRestartSequence);
		}
		
		private function get isRestart():Boolean
		{
			return (_signalRestartSequence != null);
		}
		
		private function onRestartSequence(vo:VOStartupSequences):void
		{
			//Tracer.log(this, "onRestartSequence - vo.restartStartupSequence: "+ vo.restartStartupSequence);
			
			if(vo.restartStartupSequence)
			{
				removeSequencesCantBeRestarted();
				executeTaskSet(_taskSet, _injector);
			}
		}
		
		public function get restartSignal():SignalStartupSequences
		{
			return _signalRestartSequence;
		}
		
		private function reset():void
		{
			_sequencesExecutionInfo = new Vector.<TaskSequenceInfo>;
			//Tracer.log(this, "reset - _sequencesExecutionInfo: "+_sequencesExecutionInfo);
			_currentSequence 		= 0;
		}
		
		public function get taskSetExecutionInfo():Vector.<TaskSequenceInfo>
		{
			return _sequencesExecutionInfo;
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
			//once it's complete it should be fired up again via a SignalExecuteStartSequence
			makeItBeExecutedUponSignal();
			_notifier.dispatch(true);	
		}
		
		private function makeItBeExecutedUponSignal():void
		{
			_taskSet.executeViaSignal = true;
		}
		
		public function failure():void
		{
			_notifier.dispatch(false);	
		}
		
		public function executeTaskSet(taskSet:TasksSet, injector:IInjector):void
		{
			reset();
			
			if(!_signalRestartSequence)
				setupSequencesRestart( injector.getInstance(SignalStartupSequences) );
			
			_started = true;
			_taskSet = taskSet;
			_injector = injector;
			
			//Tracer.log(this, "executeTaskSet - _taskSet: "+_taskSet);
			executeNextTaskSequence(taskSet, injector);
		}
		
		private function executeNextTaskSequence(taskSet:TasksSet, injector:IInjector, increaseSequenceCount:Boolean = true):void
		{
			var currentSequence:TaskSequence = getNextTaskSequence(taskSet, increaseSequenceCount);
			
			//Tracer.log(this, "executeNextTaskSequence - currentSequence: "+currentSequence);
			if(currentSequence && !currentSequence.executedOnce)
			{
				currentSequence.executedOnce = true;
				var isSimultaneousNotSequentialSequence:Boolean = (!currentSequence.simultaneousNotSequential)
				starNextTaskSequenceExecuter(currentSequence, injector, isSimultaneousNotSequentialSequence);
			}
			else if(currentSequence)
			{
				executeNextTaskSequence(taskSet, injector);
				//Tracer.log(this, "executeNextTaskSequence - ALL TASK WERE SEQUENCES EXECUTED");
			}
		}
		
		private function starNextTaskSequenceExecuter(sequence:TaskSequence, injector:IInjector, executeNextTaskOnCurrentTaskCompletion:Boolean):void
		{
			//Tracer.log(this, "startTaskSequenceExecuter");
			var executer:TasksExecuter = new TasksExecuter(TASK_TIME_OUT);
			executer.signalExecution.addOnce(onTaskSetComplete);
			if(executeNextTaskOnCurrentTaskCompletion)
			{
				executer.signalExecution.addOnce(onCurrentTaskCompletionExecuteNextTaskSet);
				executer.startSequence(sequence, injector);
			}
			else
			{
				executer.startSequence(sequence, injector);
				executeNextTaskSequence(_taskSet, _injector);
			}
		}
		
		private function onCurrentTaskCompletionExecuteNextTaskSet(taskSetId:int, value:Boolean):void
		{
			executeNextTaskSequence(_taskSet, _injector);
		}
		
		public function get started():Boolean
		{
			return _started;
		}
		
		private function onTaskSetComplete(taskSqeuenceId:int, successNotFailure:Boolean):void
		{
			//Tracer.log(this, "onTaskSetComplete - taskSqeuenceId: "+taskSqeuenceId+" successNotFailure: "+successNotFailure);
			saveTaskExecutionInfo(taskSqeuenceId,successNotFailure);
			checkIsTaskSetComplete();
		}
		
		private function checkIsTaskSetComplete():void
		{
			//Tracer.log(this, "checkIsTaskSetComplete() - _sequencesExecutionInfo.length:"+_sequencesExecutionInfo.length+" _taskSet.sequences.length: "+_taskSet.sequences.length);
			if(_sequencesExecutionInfo.length == _taskSet.sequences.length)
			{
				success();
			}
		}
		
		private function removeSequencesCantBeRestarted():void
		{
			//Tracer.log(this, "removeSequencesCantBeRestarted");
			var tmpTaskSet:TasksSet 	= new TasksSet();
			tmpTaskSet.executeViaSignal = _taskSet.executeViaSignal;
			
			for each(var seq:TaskSequence in _taskSet.sequences.sequences)
			{
				if(seq.canRestart)
				{
					//Tracer.log(this, "removeSequencesCantBeRestarted");
					tmpTaskSet.addSequence(seq);
				}
			}
			
			_taskSet.removeAllTaskSequences();
			for each(var seq:TaskSequence in tmpTaskSet.sequences.sequences)
			{
				if(seq.canRestart)
				{
					_taskSet.addSequence(seq);
				}
			}
			
		}
		
		private function saveTaskExecutionInfo(taskSqeuenceId:int, successNotFailure:Boolean):void
		{
			var currentTaskSequence:TaskSequence = getNextTaskSequenceById(_taskSet, taskSqeuenceId);
			currentTaskSequence.executedOnce = true;
			//Tracer.log(this, "saveTaskExecutionInfo - _sequencesExecutionInfo: "+_sequencesExecutionInfo);
			_sequencesExecutionInfo.push( new TaskSequenceInfo(currentTaskSequence.id, successNotFailure) );
		}

		
		private function getNextTaskSequence(taskSet:TasksSet, increaseCount:Boolean):TaskSequence
		{
			var sequence:TaskSequence;
			
			//Tracer.log(this, "getNextTaskSequenceAndIncreaseCount() - _currentSequence:"+_currentSequence+" taskSet.sequences.length: "+taskSet.sequences.length);
			
			if(_currentSequence < taskSet.sequences.length)
			{
				sequence = taskSet.sequences.getSequence(_currentSequence);
				if(increaseCount)
					_currentSequence ++;
				
				return sequence;
			}
			
			return null;
		}
		
		private function getNextTaskSequenceById(taskSet:TasksSet, id:int):TaskSequence
		{
			for each (var taskSequence:TaskSequence in taskSet.sequences.sequences) 
			{
				if(taskSequence.id == id)	
					return taskSequence;
			}
			
			return null;
		}
	}
}