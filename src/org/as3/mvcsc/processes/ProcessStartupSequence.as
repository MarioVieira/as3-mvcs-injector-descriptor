package org.as3.mvcsc.processes
{
	import org.as3.interfaces.IBackgroundProcess;
	import org.as3.mvcsc.interfaces.INotifier;
	import org.as3.mvcsc.signals.SignalStartupSequences;
	import org.as3.mvcsc.task.TaskManager;
	import org.as3.mvcsc.task.TaskSequenceNotifier;
	import org.as3.mvcsc.task.TasksSet;
	import org.as3.mvcsc.vo.VOStartupSequences;
	import org.osflash.signals.Signal;
	import org.robotlegs.core.IInjector;
	
	/**
	 * 
	 * @author Mario Vieira
	 * 
	 */
	public class ProcessStartupSequence implements IBackgroundProcess
	{
		/**
		 * 
		 */
		protected var _startupSequenceManager	:TaskManager;
		protected var _injector					:IInjector;
		
		//Statuup sequences is fired after login by Cairngorm as an event, and the Bridge api maps it to a signal dispatching the VOStartupSequences (which is also mapped in the injector by the Bridge)
		protected var _startupSequencesSignal	:SignalStartupSequences;
		protected var _startSequenceResquested	:Boolean;
		protected var _tasks					:TasksSet;
		protected var _notifier					:INotifier;
		
		/**
		 * 
		 * 
		 */
		public function ProcessStartupSequence()
		{
			_startupSequenceManager = new TaskManager();
			_notifier 				= new TaskSequenceNotifier();
		}
		
		/**
		 * 
		 * @param injector
		 * 
		 */
		public function init(injector:IInjector):void
		{
			//Tracer.log(this, "init: "+ (IInjector) );
			_injector 				= injector;
			
			injector.mapSingleton(SignalStartupSequences);
			_startupSequencesSignal = injector.getInstance(SignalStartupSequences);
			
			obsorveStartupSequencesSignal();
		}
		
		public function requestStartupSequence():void
		{
			//Tracer.log(this, "requestStartupSequence");
			_startSequenceResquested = true;
			executeTasksIfApplicable();
		}

		private function obsorveStartupSequencesSignal():void
		{
			_startupSequencesSignal.add(onStartupSequencesRequest);	
		}

		private function onStartupSequencesRequest(vo:VOStartupSequences):void
		{
			if(vo.restartStartupSequence)
				requestStartupSequence();
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set data(value:Object):void
		{
 			//Tracer.log(this, "data: "+ (value as TasksSet));
			_tasks = value as TasksSet;
			executeTasksIfApplicable();
		}

		private function executeTasksIfApplicable():void
		{
			if(_startSequenceResquested && _tasks)
			{
				//	Tracer.log(this, "executeTasksIfApplicable");
				_startupSequenceManager.notifier.addOnce(onComplete);
				_startupSequenceManager.executeTaskSet(_tasks, _injector);
			}
		}
		
		private function onComplete(success:Boolean):void
		{
			obsorveStartupSequencesSignal();
		}		
		
		public function get notifier():Signal
		{
			return _startupSequenceManager.notifier;
		}
	}
}