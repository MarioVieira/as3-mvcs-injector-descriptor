package org.as3.mvcsc.vo
{
	/**
	 * 
	 * 
	 * Holds properties information once for describeType
	 * @see flash.utils.describeType
	 * 
	 * @author Mario Vieira
	 */
	public class PropertyInfo
	{
		/**
		 * @private
		 */
		private var _type:String;
		/**
		 * @private
		 */
		private var _name:String;
		/**
		 * @private
		 */
		private var _value:*;
		
		/**
		 * 
		 * @param name
		 * @param value
		 * @param type
		 * 
		 */
		public function PropertyInfo(name:String, value:*, type:* = null)
		{
			_type	 	= type;
			_name	    = name;
			_value 	 	= value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get name():String
		{
			return _name;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get value():*
		{
			return _value;		
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */
		public function set type(value:*):void
		{
			_type = value;		
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */
		public function get type():String
		{
			return _type;		
		}
	}
}