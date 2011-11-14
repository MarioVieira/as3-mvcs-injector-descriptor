package org.as3.mvcsc.vo
{
	import org.as3.mvcsc.interfaces.ITask;
	
	public class StartupSequence
	{
		private var _sequences	:TaskSequencesVO;
		private var _sequence	:TaskSequenceVO;
		
		public function StartupSequence()
		{
			_sequences = new TaskSequencesVO();
			_sequence  = new TaskSequenceVO();
		}
		
		public function addSequence(vo:TaskSequenceVO):void
		{
			_sequences.addSequence(vo);
		}
		
		public function addTaskToFirstSequence(task:ITask):void
		{
			_sequences.sequences[0].addTaskToSequence(task);	
		}
		
		public function get sequences():TaskSequencesVO
		{
			return _sequences;
		}
		
		public function get sequence():TaskSequenceVO
		{
			return _sequence;
		}
	}
}