package org.as3.mvcsc.descriptors
{
	import org.as3.mvcsc.vo.BackgroundProcesses;
	import org.as3.mvcsc.vo.CairngormBridge;
	import org.as3.mvcsc.vo.Commands;
	import org.as3.mvcsc.vo.Controls;
	import org.as3.mvcsc.vo.Models;
	import org.as3.mvcsc.vo.Services;
	import org.as3.mvcsc.vo.Views;

	/**
	 * 
	 * 
	 * The XML based descriptor is serialized into an instance of this class
	 * 
	 * @author Mario Vieira
	 */
	public class DescriptorExternalAppFrameWork
	{
		/**
		 * 
		 */
		public var modelRules				:Models;
		/**
		 * 
		 */
		public var viewRules				:Views;
		/**
		 * 
		 */
		public var controlRules				:Controls;
		/**
		 * 
		 */
		public var serviceRules				:Services;
		/**
		 * 
		 */
		public var signalCommandRules		:Commands;
		/**
		 * 
		 */
		public var backgroundProcesses		:BackgroundProcesses;
		/**
		 * 
		 */
		public var cairngormEventsRules		:CairngormBridge;
	}
}