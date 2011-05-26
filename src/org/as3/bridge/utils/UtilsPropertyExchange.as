package org.as3.bridge.utils
{
	import com.adobe.cairngorm.model.IModelLocator;
	
	import org.as3.mvcsc.utils.Tracer;
	import org.robotlegs.core.IInjector;

	/** 
	 * 
	 * Exchange properties from a Cairngorm ModelLocators to injector based Models
	 * 
	 * @author Mario Vieira
	 * 
	 */
	public class UtilsPropertyExchange
	{
		public static function passPropertyFromModelLocatorToInjectedModel(cairngormModel:IModelLocator, injector:IInjector, injectorModel:Class, fromPropertyName:String, toPropertyName:String):void
		{
			//Tracer.log(PropertyExchange, "injector: "+injector);
			try { injector.getInstance(injectorModel)[toPropertyName] = cairngormModel[fromPropertyName]; }
			catch(er:Error){ Tracer.log(UtilsPropertyExchange, er) };		
		}
	}
}
