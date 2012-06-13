package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.events.*;
	
	/**
	 * ...
	 * @author lynsun
	 */
	public class Bomb extends Sprite 
	{
		private static var _scene:DScene;
		
		public function Bomb() 
		{
			
		}
		
		public static function bomb(x,y):void
		{
			if (!_scene) {
				initScene();
			}
			var mc:DMovieClip = new DMovieClip(32, 32);
			mc.addScene(_scene);
			mc.x = x;
			mc.y = y;
			mc.addEventListener(DMovieClipEvent.STOP, onStop);
			GameUtil.stage.addChild(mc);
			
			mc.gotoAndPlay(0, _scene, 1);
		}
		
		private static function initScene():void
		{
			var frame1:DFrame = new DFrame(GameConst.gameImage, new Rectangle(320, 0, 32, 32), 'bomb1');
			var frame2:DFrame = new DFrame(GameConst.gameImage, new Rectangle(352, 0, 32, 32), 'bomb2');
			var frame3:DFrame = new DFrame(GameConst.gameImage, new Rectangle(384, 0, 32, 32), 'bomb3');
			
			var scene:DScene = new DScene('bomb', 3);
			
			scene.addFrame(frame1);
			scene.addFrame(frame2);
			scene.addFrame(frame3);
			scene.addFrame(frame2);
			scene.addFrame(frame1);
			
			_scene = scene;
		}
		
		private static function onStop(e:DMovieClipEvent):void
		{
			var mc:DMovieClip = e.target as DMovieClip;
			mc.parent.removeChild(mc);
			trace('stop');
		}
	}
}