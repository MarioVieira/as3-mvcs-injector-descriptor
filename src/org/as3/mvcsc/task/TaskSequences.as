package org.as3.mvcsc.task
{
	import org.as3.mvcsc.interfaces.ITask;

	public class TaskSequences
	{
		private var _sequences:Vector.<TaskSequence>;
		
		public function TaskSequences()
		{
			_sequences = new Vector.<TaskSequence>;
		}
		
		public function addSequence(vo:TaskSequence):void
		{
			vo.executedOnce = false;
			_sequences.push(vo);
		}
		  
		public function getSequence(index:int):TaskSequence
		{
			return _sequences[index];
		}
		
		public function get sequences():Vector.<TaskSequence>
		{
			return _sequences;
		}
		
		public function get length():int
		{
			return _sequences.length;
		}
		
		public function removeSequences():void
		{
			_sequences.length = 0;
		}
	}
}