package org.as3.mvcsc.task
{
	import flash.events.Event;
	
	import org.as3.mvcsc.utils.Tracer;
	
	public class TaskOnPropertyChange extends TaskBase
	{
		public function TaskOnPropertyChange(propertyName:String, propertyHost:Object)
		{
			super(new  TaskDescriptor(true, propertyName, propertyHost) );
		}
		
		override protected function executeTaskUponPropertyChange(e:Event):void
		{
			throw new Error("executeTaskUponPropertyChange(e:Event):void MUST be implemented in subclass");
		}
	}
}