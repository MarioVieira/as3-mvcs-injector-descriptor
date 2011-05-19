package org.as3.mvcsc.vo
{
	public class PropertyInfo
	{
		protected var _type:String;
		protected var _name:String;
		protected var _value:*;
		
		public function PropertyInfo(name:String, value:*, type:* = null)
		{
			_type	 	= type;
			_name	    = name;
			_value 	 	= value;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get value():*
		{
			return _value;		
		}
		
		public function set type(value:*):void
		{
			_type = value;		
		}
		
		public function get type():String
		{
			return _type;		
		}
	}
}