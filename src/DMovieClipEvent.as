package  
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author lynsun
	 */
	public class DMovieClipEvent extends Event 
	{
		//场景播放完毕
		public static const SCENE_END:String = 'scene_end';
		//停止播放
		public static const STOP:String = 'stop';
		
		public function DMovieClipEvent(type) 
		{
			super(type);
		}
		
	}

}