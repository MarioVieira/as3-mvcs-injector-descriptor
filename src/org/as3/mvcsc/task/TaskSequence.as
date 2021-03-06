package org.as3.mvcsc.task
{
	import org.as3.mvcsc.interfaces.ITask;
	
	public class TaskSequence
	{
		private var _sequence					:Vector.<ITask>;
		private var _simultaneousNotSequential	:Boolean;
		
		/**
		 *  
		 * If any task of sequence will be executed upon a property change it's by defintion not a sequential task (but simultaneous), and so <code> simultaneousNotSequential = true </code> will be ignored
		 *  
		 * @see org.as3.mvcsc.task.TaskDescriptor
		 * @param simultaneousNotSequential
		 * 
		 */		
		public function TaskSequence(simultaneousNotSequential:Boolean)
		{
			_simultaneousNotSequential = simultaneousNotSequential;
			_sequence = new Vector.<ITask>;
		}
		
		public function get simultaneousNotSequential():Boolean
		{
			return _simultaneousNotSequential;
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