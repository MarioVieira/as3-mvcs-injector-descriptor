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
		[Serialize] public var modelRules				:Models;
		/**
		 * 
		 */
		[Serialize] public var viewRules				:Views;
		/**
		 * 
		 */
		[Serialize] public var controlRules				:Controls;
		/**
		 * 
		 */
		[Serialize] public var serviceRules				:Services;
		/**
		 * 
		 */
		[Serialize] public var signalCommandRules		:Commands;
		/**
		 * 
		 */
		[Serialize] public var backgroundProcessesRules	:BackgroundProcesses;
		/**
		 * 
		 */
		[Serialize] public var cairngormEventsRules		:CairngormBridge;
	}
}