package  
{
	/**
	 * ...
	 * @author lynsun
	 */
	public class DScene 
	{
		
		private var _name:String;
		
		private var _frames:Array;
		
		private var _numFrames:Number;
		
		private var _delay:int;
		
		public function DScene(name:String,delay:int) 
		{
			this._name = name;
			this._delay = delay;
			this._frames = new Array();
		}
		
		public function get name():String
		{
			return this._name;
		}
		
		public function get numFrames():int
		{
			return this._frames.length;
		}
		
		public function get delay():int
		{
			return this._delay;
		}
		
		public function get frames():Array
		{
			return this._frames;
		}
		
		public function addFrame(frame:DFrame):void
		{
			this._frames.push(frame);
		}
		
		
	}

}