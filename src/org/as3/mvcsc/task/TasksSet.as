package org.as3.mvcsc.task
{
	import org.as3.mvcsc.interfaces.ITask;
	
	public class TasksSet
	{
		private var _sequences	:TaskSequences;
		
		public function TasksSet()
		{
			_sequences = new TaskSequences();
		}
		
		public function addSequence(vo:TaskSequence):void
		{
			_sequences.addSequence(vo);
		}
		
		public function get sequences():TaskSequences
		{
			return _sequences;
		}
	}
}