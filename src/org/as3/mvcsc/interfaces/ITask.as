package org.as3.mvcsc.interfaces
{
	import org.robotlegs.core.IInjector;
	import org.as3.mvcs.interfaces.INotifier;

	public interface ITask extends INotifier
	{
		function start(injector:IInjector):void;
	}
}