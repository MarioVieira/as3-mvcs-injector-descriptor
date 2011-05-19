package org.as3.mvcsc.utils
{
	CONFIG::DESKTOP
	{
		import flash.filesystem.File;
		import flash.filesystem.FileMode;
		import flash.filesystem.FileStream;
	}
	
	public class WriteFile
	{
		public static function saveUTF8FileToDesktop(fileName:String, content:String, folderName:String = null, fileExtension:String = ".xml"):void
		{
			CONFIG::DESKTOP
			{
				var file:File = (!folderName) ? File.desktopDirectory.resolvePath(fileName + fileExtension) : File.desktopDirectory.resolvePath(folderName + "/" +fileName + fileExtension);
				var stream:FileStream = new FileStream();
				stream.open(file, FileMode.WRITE);
				stream.writeUTFBytes(content);
				stream.close();
			}
		}
	}
}