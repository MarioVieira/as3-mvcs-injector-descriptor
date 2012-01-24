package org.as3.mvcsc.task.vo
{
	public class TaskSequenceInfo
	{
		public function TaskSequenceInfo(id:int = -1, successfullyExecuted:Boolean = false) 
		{
			this.id = id;
			this.successfullyExecuted = successfullyExecuted;
		}
		
		public var id:int;
		public var successfullyExecuted:Boolean;
	}
}