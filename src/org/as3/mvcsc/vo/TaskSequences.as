package org.as3.mvcsc.vo
{
	import org.as3.mvcsc.interfaces.ITask;

	public class TaskSequences
	{
		private var _sequences:Vector.<TaskSequence>;
		
		public function TaskSequences()
		{
			_sequences = new Vector.<TaskSequence>;
			
			initializeFirstSequence();
		}
		
		private function initializeFirstSequence():void
		{
			addSequence( new Vector.<TaskSequence> );
		}
		
		public function addSequence(vo:TaskSequence):void
		{
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
	}
}