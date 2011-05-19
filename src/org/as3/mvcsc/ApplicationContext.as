package org.as3.mvcsc
{
	import org.as3.mvcsc.descriptors.DescriptorAppFrameWork;
	import org.as3.mvcsc.descriptors.DescriptorCore;
	import org.as3.mvcsc.descriptors.DescriptorExternalAppFrameWork;
	import org.as3.mvcsc.utils.UtilsDescriptorLoader;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IMediatorMap;
	import org.robotlegs.core.ISignalCommandMap;
	import org.robotlegs.mvcs.SignalContext;
	
	/**
	 * 
	 * @author Mario Vieira
	 * 
	 */	
	public class ApplicationContext extends SignalContext
	{
		[Bindable] public var applicationFrameWorkDescriptor:DescriptorAppFrameWork; 
		
		protected var _applicationFrameWork:ApplicationFrameWork;
		/** 
		 * Holds and executes all mappings for Model, View, Control, Services, Command, and Background Processes 
		 */		
		protected var _appFrameWork				:ApplicationFrameWork;
		protected var _loadExternalDescriptor	:UtilsDescriptorLoader;
		
		override public function startup() : void
		{
			setupCore();
			loadExternalFrameWorkDescriptors();
		}
		
		/** 
		 * 
		 * Rules for making <code>injector, signalCommandMap, mediatorMap</code> available for Dependency Injecton via Interfaces 
		 * 
		 */		
		protected function setupCore():void
		{
			injector.mapValue(IInjector, injector);
			injector.mapValue(ISignalCommandMap, signalCommandMap);
			injector.mapValue(IMediatorMap, mediatorMap);
		}
		
		protected function loadExternalFrameWorkDescriptors():void
		{
			_loadExternalDescriptor = new UtilsDescriptorLoader( (applicationFrameWorkDescriptor) ? applicationFrameWorkDescriptor.uniqueAppId : 0 );
			_loadExternalDescriptor.addOnce(onExternalFrameWorkDescriptorLoaded);
			_loadExternalDescriptor.loadExternalAppFrameWorkDescriptor();
		}
  
		protected function onExternalFrameWorkDescriptorLoaded(externalAppFrameWorkDescriptor:DescriptorExternalAppFrameWork):void
		{
			_loadExternalDescriptor.dispose();  
			setupApplicationFrameWork(applicationFrameWorkDescriptor, externalAppFrameWorkDescriptor);
		}
		      
		protected function setupApplicationFrameWork(appFrameWorkDescriptor:DescriptorAppFrameWork, externalAppFrameWorkDescriptor:DescriptorExternalAppFrameWork):void
		{
			_appFrameWork = new ApplicationFrameWork( new DescriptorCore(injector, signalCommandMap, mediatorMap), appFrameWorkDescriptor, externalAppFrameWorkDescriptor);
		}
	}
}
