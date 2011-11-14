package org.as3.mvcs.interfaces
{
	import org.osflash.signals.Signal;

	public interface INotifier
	{
		function get notifier():Signal;
		function success():void;
		function failure():void;
	}
}