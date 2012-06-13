package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author lynsun
	 */
	public class BulletBase extends Sprite 
	{
		//方向
		protected var _direction:String=GameConst.DOWN;
		
		//速度
		protected var vx:Number = 0;
		protected var vy:Number = 0;
		
		//初始宽高
		protected var w:Number = 0;
		protected var h:Number = 0;
		
		//所有者
		public var owner:Object;
		
		//bitmap
		protected var bulletBitmap:Bitmap;
		
		public function BulletBase(x:Number,y:Number,w:Number,h:Number,direction:String) 
		{
			this.x = x;
			this.y = y;
			this.w = w;
			this.h = h;
			this._direction = direction;
			
			this.bulletBitmap = new Bitmap();
			this.bulletBitmap.bitmapData = new BitmapData(w, h);
			
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function get direction():String
		{
			return this._direction;
		}
		
		public function set direction(dir:String):void
		{
			this._direction = dir;
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			this.render();
		}
		
		
		//render
		protected function render():void
		{
			var sx, sy = 96, rect;
			switch(this.direction) {
				case GameConst.UP:
					sx = 80;
					this.vy = -GameConst.BULLET_SPEED_NORMAL;
					break;
				case GameConst.RIGHT:
					sx = 98; 
					this.vx = GameConst.BULLET_SPEED_NORMAL;
					break;
				case GameConst.DOWN:
					sx = 86; 
					this.vy = GameConst.BULLET_SPEED_NORMAL;
					break;
				case GameConst.LEFT:
					sx = 92; 
					this.vx = -GameConst.BULLET_SPEED_NORMAL;
					break;
				default:
					break;
			}
			rect = new Rectangle(sx, sy, w,h);
			this.bulletBitmap.bitmapData.copyPixels(TankBase.tankImage.bitmapData, rect, new Point(0, 0));
			addChild(this.bulletBitmap);
		}
		
		//update
		public function update():void
		{
			this.x += vx;
			this.y += vy;
		}
		
		//和砖块的碰撞
		public function hitTestBrick():Boolean
		{
			return GameUtil.bulletHitTestTile(this.getBounds(stage), this.direction);
		}
		
		
		//和墙壁的碰撞
		public function hitTestWall():Boolean
		{
			var ishit=false,
				stageWidth:Number = stage.stageWidth,
				stageHeight:Number = stage.stageHeight;
			
			
			if (this.x < 0) {
				ishit = true;
			}else if ((this.x + this.width) >stageWidth) {
				ishit = true;
			}
			
			if (this.y < 0) {
				ishit = true;
			}else if ((this.y + this.height) > stageHeight) {
				ishit = true;
			}
			
			return ishit;
		}
		
		
		//清除垃圾
		public function dispose():void
		{
			//执行子弹爆炸动画
			Bomb.bomb(this.x-16, this.y-16);
			this.owner.bullet = null;
			this.parent.removeChild(this);
			
		}
	}

}