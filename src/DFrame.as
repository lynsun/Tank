package  
{
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author lynsun
	 */
	public class DFrame 
	{
		private var _bitmap:Bitmap;
		
		private var _label:String;
		
		private var _rect:Rectangle;
		
		public function DFrame(bitmap:Bitmap,rect:Rectangle,label:String) 
		{
			this._bitmap = bitmap;
			this._rect = rect;
			this._label = label;
		}
		
		public function get bitmap():Bitmap
		{
			return this._bitmap;
		}
		
		public function get label():String
		{
			return this._label;
		}
		
		public function get rect():Rectangle
		{
			return this._rect;
		}
		
	}

}