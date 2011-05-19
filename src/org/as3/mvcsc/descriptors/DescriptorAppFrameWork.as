package org.as3.mvcsc.descriptors
{
	import org.as3.mvcsc.interfaces.IMappingBackgroundProcesses;
	import org.as3.mvcsc.interfaces.IMappingInjector;
	import org.as3.mvcsc.interfaces.IMappingMediator;
	import org.as3.mvcsc.interfaces.IMappingSignalCommand;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IMediatorMap;
	import org.robotlegs.core.ISignalCommandMap;

	public class DescriptorAppFrameWork
	{
		public var uniqueAppId					: int;
		
		public var modelsMapping 				: IMappingInjector;
		
		public var viewsMapping 				: IMappingMediator;
		
		public var controlsMapping 				: IMappingInjector;
		
		public var servicesMapping 				: IMappingInjector;
		
		public var commandsMapping	 			: IMappingSignalCommand;
		
		public var backgroundProcessesMapping 	: IMappingBackgroundProcesses;
	}
}