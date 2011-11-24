package org.as3.mvcsc.descriptors
{
	import org.as3.mvcsc.interfaces.IMappingBackgroundProcesses;
	import org.as3.mvcsc.interfaces.IMappingInjector;
	import org.as3.mvcsc.interfaces.IMappingMediator;
	import org.as3.mvcsc.interfaces.IMappingSignalCommand;
	import org.as3.mvcsc.interfaces.ITask;
	import org.as3.mvcsc.task.TaskBase;
	import org.as3.mvcsc.task.TasksSet;

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
		public var backgroundProcessesMapping 	: IMappingBackgroundProcesses;
		
		/**
		 * 
		 */
		public var startupSequence				: TasksSet;
	}
}