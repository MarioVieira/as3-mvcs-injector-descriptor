package org.as3.mvcsc.utils
{
	import org.as3.interfaces.IBackgroundProcess;
	import org.as3.mvcsc.descriptors.DescriptorBackgroundProcess;
	import org.as3.serializer.Serializer;
	import org.as3.serializer.utils.GetTypedObject;
	import org.robotlegs.core.IInjector;
	
	/**
	 * 
	 * @author Mario
	 * 
	 */	
	public class UtilsProcesses
	{
		public static function initializeBackgroundProcess(injector:IInjector, process:DescriptorBackgroundProcess):void
		{
			var ClassReference:Class = process.backgrounProcessClass;
			
			Tracer.log(UtilsProcesses, "initializeBackgroundProcess - ClassReference: "+ClassReference);
			injector.mapSingleton(ClassReference);
			process.backgrounProcessReferece = injector.getInstance(ClassReference);
			
			if(!process.backgrounProcessReferece is IBackgroundProcess)
			{
				injector.unmap(ClassReference);	
				throw new Error("org.as3.mvcsc.utils.UtilsProcesses - process.backgrounProcessReferece class reference: "+ClassReference+" does NOT implement IBackgroundProcess");
			}
		}
	}
}