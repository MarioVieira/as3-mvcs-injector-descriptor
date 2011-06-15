package org.as3.mvcsc.utils
{
	import org.as3.mvcsc.descriptors.DescriptorViewMap;
	import org.robotlegs.core.IMediatorMap;
	
	public class UtilsMapAdditionalViewRules
	{
		public static function mapAdditionalViewRules(mediatorMap:IMediatorMap, additonalViewRules:Vector.<DescriptorViewMap>):void
		{
			for each(var rule:DescriptorViewMap in additonalViewRules)
			{
				try
				{
					Tracer.log(UtilsMapAdditionalViewRules, "mapAdditionalViewRules - rule.viewClass: "+rule.viewClass+"  rule.viewMediator: "+rule.viewMediator);
					mediatorMap.mapView(rule.viewClass, rule.viewMediator);
				}
				catch(er:Error)
				{
					Tracer.log(UtilsMapAdditionalViewRules, er);	
				}
			}
		}
	}
}   