package org.as3.mvcsc.descriptors
{
	import org.as3.bridge.interfaces.IBridgeProcess;
	import org.as3.mvcsc.interfaces.IMappingCairngormDataExchange;
	import org.as3.mvcsc.interfaces.IMappingInjector;
	import org.as3.mvcsc.interfaces.IMappingMediator;
	import org.as3.mvcsc.interfaces.IMappingSignalCommand;
	import org.as3.mvcsc.task.TasksSet;
	import org.as3.mvcsc.vo.BackgroundProcesses;

	/**
	 * 
	 * The application MVCS Command and Background Processes descriptor for injection mapping
	 * 
	 * @author Mario Vieira 
	 * 
	 */
	public class DescriptorAppFrameWork
	{
		/**
		 * 
		 */
		public var descriptorFolderName			: String = "";
		
		/**
		 * 
		 */
		public var modelsMapping 				: IMappingInjector;
		
		/**
		 * 
		 */
		public var viewsMapping 				: IMappingMediator;
		
		/**
		 * 
		 */
		public var controlsMapping 				: IMappingInjector;
		
		/**
		 * 
		 */
		public var servicesMapping 				: IMappingInjector;
		
		/**
		 * 
		 */
		public var commandsMapping	 			: IMappingSignalCommand;
		
		
		/**
		 * 
		 */
		public var bridgeProcess	 			: IBridgeProcess;
		
		/**
		 * 
		 */
		public var backgroundProcesses 			: BackgroundProcesses;
		
		/**
		 * 
		 */
		public var startupSequence				: TasksSet;
	
		/**
		 * 
		 */
		public var externalDescriptorClasses	: Array;
	}
}