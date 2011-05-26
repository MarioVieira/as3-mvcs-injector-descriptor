package org.as3.mvcsc.utils
{
	import flash.utils.describeType;
	
	import org.as3.mvcsc.vo.PropertiesCollection;
	import org.as3.mvcsc.vo.PropertyInfo;

	/**
	 * 
	 *
	 * Returns the object properties of a given Object into a PropertiesCollection (Note that it should be cached as descrybeType is costly!)
	 * @see org.as3.mvcsc.vo.PropertiesCollection
	 * 
	 * @param object
	 * @return 
	 * 
	 * @author Mario Vieira
	 */	
	public class DescribeObject
	{
		/**
		 * 
		 */
		public static const VARIABLE : String = "variable";
		/**
		 * 
		 */
		public static const CONSTANT : String = "constant";
		
		/**
		 * 
		 * 
		 */
		public function DescribeObject(){}
		
		/**
		 * 
		 * @param object
		 * @return 
		 * 
		 */		
		public static function getObjectConstants(object:Object):PropertiesCollection
		{
			return getObjectMember(object, CONSTANT);
		}
		
		/**
		 * 
		 * @param object
		 * @return 
		 * 
		 */
		public static function getObjectVariables(object:Object):PropertiesCollection
		{
			return getObjectMember(object, VARIABLE);
		}
		
		/**
		 * 
		 * @param object
		 * @param memberType
		 * @return 
		 * 
		 */
		public static function getObjectMember(object:Object, memberType:String):PropertiesCollection
		{
			var collection:PropertiesCollection = new PropertiesCollection();
			var array:Array = [];
			var vector:Vector.<PropertyInfo> = new Vector.<PropertyInfo>;
			var members:XMLList = describeType(object)[memberType];
			
			var length:int = members.length();
			
			for(var i:int; i < length; i++)
			{
				var info:PropertyInfo = new PropertyInfo(members[i].@name, object[members[i].@name], members[i].@type);	
				vector[vector.length] = info;
				array[array.length] = info;
			}
			
			collection.propertyInfoArray  = array;
			collection.propertyInfoVector = vector;
			
			return collection;
		}
	}
}  