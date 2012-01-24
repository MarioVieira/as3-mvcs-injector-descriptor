package org.as3.mvcsc.task
{
	import org.as3.mvcsc.interfaces.ITask;
	
	public class TasksSet
	{
		public var executeViaSignal	:Boolean;
		private var _sequences		:TaskSequences;
		
		public function TasksSet()
		{
			_sequences = new TaskSequences();
		}
		
		public function addSequence(vo:TaskSequence):void
		{
			vo.id = _sequences.sequences.length;
			vo.executedOnce = false;
			_sequences.addSequence(vo);
		}
		
		public function get sequences():TaskSequences
		{
			return _sequences;
		}
		
		public function removeAllTaskSequences():void
		{
			_sequences.removeSequences();
			
		}
	}
}