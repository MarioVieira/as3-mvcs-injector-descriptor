package org.as3.interfaces
{
	import org.robotlegs.core.IInitializer;
	import org.robotlegs.core.IInjector;

	public interface IBackgroundProcess extends IInitializer
	{
		function set data(value:Object):void;
	}
}