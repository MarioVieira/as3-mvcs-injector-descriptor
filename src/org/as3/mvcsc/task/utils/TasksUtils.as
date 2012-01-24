package org.as3.mvcsc.task.utils
{
	import org.as3.mvcsc.interfaces.ITask;
	import org.as3.mvcsc.task.TaskSequence;
	
	public class TasksUtils
	{
		public static function isAnyTaskExecutedUponPropertyChange(tasks:TaskSequence):Boolean
		{
			for each (var task:ITask in tasks.sequence) 
			{
				if(task.descriptor.executeTaskUponPropertyChange)
					return true;
			}
			
			return false;
		}
		
	}
}