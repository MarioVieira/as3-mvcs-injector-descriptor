package org.as3.mvcsc.task
{
	import org.as3.mvcsc.utils.Tracer;
	import org.robotlegs.core.IInjector;
	
	public class TaskFinal extends TaskBase
	{
		public function TaskFinal()
		{
			super(new TaskDescriptor());
		}
		
		override public function start(injector:IInjector):void
		{
			throw new Error(" start(injector:IInjector):void - MUST be implemented in subclass");
		}
	}
}