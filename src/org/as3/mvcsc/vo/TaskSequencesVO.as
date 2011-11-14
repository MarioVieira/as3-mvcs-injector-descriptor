package org.as3.mvcsc.vo
{
	import org.as3.mvcsc.interfaces.ITask;

	public class TaskSequencesVO
	{
		private var _sequences:Vector.<TaskSequenceVO>;
		
		public function TaskSequencesVO()
		{
			_sequences = new Vector.<TaskSequenceVO>;
			
			initializeFirstSequence();
		}
		
		private function initializeFirstSequence():void
		{
			addSequence( new Vector.<TaskSequenceVO> );
		}
		
		public function addSequence(vo:TaskSequenceVO):void
		{
			_sequences.push(vo);
		}
		
		public function getSequence(index:int):TaskSequenceVO
		{
			return _sequences[index];
		}
		
		public function get sequences():Vector.<TaskSequenceVO>
		{
			return _sequences;
		}
		
		public function get length():int
		{
			return _sequences.length;
		}
	}
}