package org.as3.mvcsc
{
	import org.as3.mvcsc.descriptors.DescriptorAppFrameWork;
	import org.as3.mvcsc.descriptors.DescriptorCore;
	import org.as3.mvcsc.descriptors.DescriptorExternalAppFrameWork;
	import org.as3.mvcsc.utils.UtilsDescriptorLoader;
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IMediatorMap;
	import org.robotlegs.core.ISignalCommandMap;
	import org.robotlegs.mvcs.SignalContextInit;
	
	/**
	 * 
	 * MVCS Command and Background Processes application context
	 * It takes descriptions for the mapping in compile time (descriptor object) and run time (XML seralized into typed object)
	 * 
	 * @author Mario Vieira
	 * 
	 */	
	public class ApplicationContext extends SignalContextInit
	{
		/**
		 * 
		 * 
		 * @return  
		 * 
		 */
		[Bindable] public var applicationFrameWorkDescriptor : DescriptorAppFrameWork; 
		[Bindable] public var useExternalXMLDescriptors		 : Boolean = true; 
		
		/**
		 * @private
		 */
		
		protected var _applicationFrameWork:ApplicationFrameWork;
		/** 
		 * @private 
		 */
		
		protected var _appFrameWork				:ApplicationFrameWork;
		/**  
		 * @private 
		 */
		protected var _loadExternalDescriptor	:UtilsDescriptorLoader;
		
		/**
		 * 
		 * 
		 */
		override public function startup() : void
		{
			setupCore();
			if(useExternalXMLDescriptors) loadExternalFrameWorkDescriptors();
			else 						  setupApplicationFrameWork(applicationFrameWorkDescriptor, null);						  
		}
		
		/** 
		 * 
		 * Rules for making <code>injector, signalCommandMap, mediatorMap</code> available via injector
		 * 
		 */		
		protected function setupCore():void
		{
			injector.mapValue(IInjector, injector);
			injector.mapValue(ISignalCommandMap, signalCommandMap);
			injector.mapValue(IMediatorMap, mediatorMap);
		}
		
		/**
		 * 
		 * 
		 */
		protected function loadExternalFrameWorkDescriptors():void
		{
			_loadExternalDescriptor = new UtilsDescriptorLoader( applicationFrameWorkDescriptor.descriptorFolderName );
			_loadExternalDescriptor.addOnce(onExternalFrameWorkDescriptorLoaded);
			_loadExternalDescriptor.loadExternalAppFrameWorkDescriptor();
		}
  
		/**
		 * 
		 * @private
		 * 
		 */
		protected function onExternalFrameWorkDescriptorLoaded(externalAppFrameWorkDescriptor:DescriptorExternalAppFrameWork):void
		{
			_loadExternalDescriptor.dispose();  
			setupApplicationFrameWork(applicationFrameWorkDescriptor, externalAppFrameWorkDescriptor);
		}
		      
		/**
		 * 
		 * @param appFrameWorkDescriptor
		 * @param externalAppFrameWorkDescriptor
		 * 
		 */
		protected function setupApplicationFrameWork(appFrameWorkDescriptor:DescriptorAppFrameWork, externalAppFrameWorkDescriptor:DescriptorExternalAppFrameWork):void
		{
			_appFrameWork = new ApplicationFrameWork( new DescriptorCore(injector, signalCommandMap, mediatorMap), appFrameWorkDescriptor, externalAppFrameWorkDescriptor);
		}
	}
}
