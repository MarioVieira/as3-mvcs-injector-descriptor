package org.as3.mvcsc.interfaces
{
	import org.osflash.signals.Signal;

	public interface INotifier
	{
		function get notifier():Signal;
		function success():void;
		function failure():void;
	}
}