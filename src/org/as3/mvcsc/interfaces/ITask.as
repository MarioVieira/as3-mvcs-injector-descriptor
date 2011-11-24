package org.as3.mvcsc.interfaces
{
	import org.as3.mvcsc.task.TaskDescriptor;
	import org.robotlegs.core.IInjector;

	public interface ITask extends INotifier
	{
		function start(injector:IInjector):void;
		function get descriptor():TaskDescriptor;
	}
}