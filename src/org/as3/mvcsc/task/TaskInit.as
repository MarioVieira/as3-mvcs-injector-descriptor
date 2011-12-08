package org.as3.mvcsc.task
{
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IInitializer;
	import org.robotlegs.core.IInjector;
	
	/**
	 * 
	 * It allow asyncronous sequential tasks based on the injector dictionary instances
	 * 
	 * @author Mario Vieira
	 * 
	 */	 
	public class TaskInit extends Signal implements IInitializer
	{
		public function TaskInit() 
		{
			super(Boolean);
		}
		
		public function init(injector:IInjector):void
		{
			start(injector);
		}
		
		public function start(injector:IInjector):void
		{
			
		}
		
		protected function complete():void
		{
			dispatch(true);
		}
		
		public function cancel():void
		{
			dispatch(false);
		}
		
		protected function error():void
		{
			cancel();
		}
	}
}