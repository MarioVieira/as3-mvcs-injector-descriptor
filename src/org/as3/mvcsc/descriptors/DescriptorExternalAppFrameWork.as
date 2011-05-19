package org.as3.mvcsc.descriptors
{
	import org.as3.mvcsc.model.BackgroundProcesses;
	import org.as3.mvcsc.model.CairngormBridge;
	import org.as3.mvcsc.model.Commands;
	import org.as3.mvcsc.model.Controls;
	import org.as3.mvcsc.model.Models;
	import org.as3.mvcsc.model.Services;
	import org.as3.mvcsc.model.Views;

	public class DescriptorExternalAppFrameWork
	{
		[Serialize] public var modelRules				:Models;
		[Serialize] public var viewRules				:Views;
		[Serialize] public var controlRules				:Controls;
		[Serialize] public var serviceRules				:Services;
		[Serialize] public var signalCommandRules		:Commands;
		[Serialize] public var backgroundProcessesRules	:BackgroundProcesses;
		[Serialize] public var cairngormEventsRules		:CairngormBridge;
	}
}