package org.as3.mvcsc.descriptors
{
	import org.as3.interfaces.IBackgroundProcess;

	/**
	 * 
	 * Background Processes descriptor 
	 * 
	 * @author Mario Vieira 
	 * 
	 */
	public class DescriptorBackgroundProcess
	{
		
		public function DescriptorBackgroundProcess(backgrounProcessClass:Class) 
		{	
			this.backgrounProcessClass = backgrounProcessClass;
		}
		
		/**  
		 * @backgrounProcessClass A Class that implements IBackgroundProcess
		 * @see org.as3.interfaces.IBackgroundProcess
		 */ 
		public var backgrounProcessClass : Class;
		private var _backgrounProcessReferece:IBackgroundProcess;
		
		/**
		 *The reference where the background process lives on 
		 */		
		public function set backgrounProcessReferece(value:IBackgroundProcess):void
		{
			_backgrounProcessReferece 		= value;
			_backgrounProcessReferece.data 	= null;
		}
		
		public function get backgrounProcessReferece():IBackgroundProcess
		{
			return _backgrounProcessReferece;
		}
	}
}