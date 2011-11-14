package org.as3.mvcsc.vo
{
	import org.as3.mvcsc.interfaces.ITask;
	
	public class TaskSequenceVO
	{
		private var _sequence:Vector.<ITask>;
		
		public function TaskSequenceVO()
		{
			_sequence = new Vector.<ITask>;
		}
		
		public function addTaskToSequence(task:ITask):void
		{
			_sequence.push(task);
		}
		
		public function getTask(index:int):ITask
		{
			return _sequence[index];
		}
		
		public function get sequence():Vector.<ITask>
		{
			return _sequence;
		}
		
		public function get length():int
		{
			return _sequence.length;
		}
	}
}