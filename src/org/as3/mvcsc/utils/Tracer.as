package org.as3.mvcsc.utils
{
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;
	import mx.utils.ObjectUtil;
	
	/**
	 * 
	 * @author	Per Kristian Stoveland - perk.stoveland@gmail.com
	 * 
	 */
	
	public class Tracer {
		
		private static var _useQName:Boolean = true;
		
		public static function set useQualifiedClassName( b:Boolean):void
		{
			_useQName = b;
		} 
		
		public static function log( $class:Object, $msg:Object=null, $stackTrace : String = null):void 
		{
			try 
			{
				var className:String = getQualifiedClassName( $class );
				
				if( !_useQName )
				{  
					var start:uint = className.indexOf( "::" ) + 2;
					className = className.substring( start, className.length );
				}
			} 
			catch( e:Error ) 
			{
				trace("Can not get qualified class name for: " + $class.toString() + " in Tracer.log()" );
				return;
			}
			
			var s:String = "[" + getTimer() + "]\t" + className;
			
			var lineNumber : String;			
			if ($stackTrace)
			{
				lineNumber = String(String($stackTrace.split("\n")[1]).split(":")[2]).replace("]","");				
			}
			
			if (lineNumber) s+="\t[Line "+lineNumber+"]\t";
			if( $msg != null ) s += " - " + $msg;	
			
			
			trace(s); 
		}
		
	}
}
