package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.FrameLabel;
	import flash.display.Scene;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	/**
	 * ...
	 * @author lynsun
	 */
	public class DMovieClip extends Sprite
	{
		private var _currentFrame:int;
		
		private var _currentFrameLabel:String;
		
		private var _currentScene:DScene;
		
		private var _scenes:Array;
		
		private var _totalFrames:int;
		//是否在播放
		private var _isPlay:Boolean = false;
		//已经延迟了多少帧
		private var _delayFrameCount:Number = 0;
		//播放当前场景的次数，0为循环播放，1为播放一次后停止
		private var _repeatCount:int;
		//已经播放了多少次
		private var _playCount:int = 0;
		
		
		private var _w:Number = 0;
		private var _h:Number = 0;
		
		private var _canvas:Bitmap;
		private var _bd:BitmapData;
		
		public function DMovieClip(w:Number,h:Number) 
		{
			this._w = w;
			this._h = h;
			this._currentFrame = 0;
			this._scenes = new Array();
			this._repeatCount = 0;
			this._canvas = new Bitmap();
			this._bd = new BitmapData(w, h);
			this._canvas.bitmapData = this._bd;
		}
		
		public function addScene(scene:DScene):void
		{
			this._scenes.push(scene);
		}
		
		private function setCurrentFrame(frameIndex:int,scene:DScene):void
		{
			this._currentScene = scene;
			this._currentFrame = frameIndex;
		}
		
		public function gotoAndPlay(frameIndex:int,scene:DScene,repeatCount:int):void
		{
			this._isPlay = true;
			this.setCurrentFrame(frameIndex, scene);
			this._repeatCount = repeatCount;
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		
		public function gotoAndStop(frameIndex:int,scene:DScene):void
		{
			this._isPlay = false;
			this.setCurrentFrame(frameIndex,scene);
			this.render();
			stage.removeEventListener(Event.ENTER_FRAME, update);
		}
		
		public function nextFrame():void
		{
			this._currentFrame++;
			if (this._currentFrame == this._currentScene.numFrames) {
				this.setCurrentFrame(0, this._currentScene);
				this._playCount++;
				//分发scene_end
				var sceneEndEvent:DMovieClipEvent = new DMovieClipEvent(DMovieClipEvent.SCENE_END);
				this.dispatchEvent(sceneEndEvent);
				if (this._playCount == this._repeatCount) {//播放了指定的次数后停止
					this.stop();
					return
				}
			}
			this.setCurrentFrame(this._currentFrame, this._currentScene);
		}
		
		public function stop():void
		{
			this._isPlay = false;
			this._playCount = 0;
			this._repeatCount = 0;
			stage.removeEventListener(Event.ENTER_FRAME, update);
			var stopEvent:DMovieClipEvent = new DMovieClipEvent(DMovieClipEvent.STOP);
			this.dispatchEvent(stopEvent);
		}
		
		public function getCurrentFrame():DFrame
		{
			return this._currentScene.frames[this._currentFrame];
		}
		
		public function render():void
		{
			var frame:DFrame = this.getCurrentFrame();
			var rect:Rectangle = frame.rect;
			this._bd.copyPixels(frame.bitmap.bitmapData,rect, new Point(0, 0));
			this.addChild(this._canvas);
		}
		
		public function update(e:Event):void
		{
			if (!this._isPlay) {
				return
			}
			this._delayFrameCount++;
			if (this._delayFrameCount == this._currentScene.delay) {
				this._delayFrameCount = 0;
				this.nextFrame();
				this.render();
			}
		}
		
	}

}