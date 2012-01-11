package org.as3.mvcsc.task
{
	
	public class TaskDescriptor
	{
		private var _propertyHost					:Object;
		private var _propertyName					:String;
		private var _executeTaskUponPropertyChange	:Boolean;
		
		public function TaskDescriptor(executeTaskUponPropertyChange:Boolean = false, propertyName:String = null, propertyHost:Object = null)
		{
			_executeTaskUponPropertyChange 	= executeTaskUponPropertyChange;
			_propertyName			   		= propertyName;
			_propertyHost					= propertyHost;
		}

		public function get executeTaskUponPropertyChange():Boolean
		{
			return _executeTaskUponPropertyChange;
		}

		public function get propertyName():String
		{
			return _propertyName;
		}

		public function get propertyHost():Object
		{
			return _propertyHost;
		}

	}
}