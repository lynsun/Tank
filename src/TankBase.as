package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import GameConst;
	
	/**
	 * ...
	 * @author lynsun
	 */
	public class TankBase extends Sprite
	{
		//速度
		public var vx:Number = 0;
		public var vy:Number = 0;
		protected var speed:Number = GameConst.TANKSPEED_NORMAL;
		
		//初始宽高
		protected var w:Number = 0;
		protected var h:Number = 0;
		
		//是否可以移动
		protected var moveable:Boolean=true;
		
		//当前的方向[up,right,down,left]
		protected var _direction:String = GameConst.UP;
		
		//坦克的状态
		protected var state:String = GameConst.STATIC;
		
		//子弹对象,每个坦克同时只能有一发炮弹
		protected var _bullet:BulletBase;

		//游戏图片
		public static var tankImage:Bitmap;// = new TileMap() as Bitmap;
		
		//坦克图片的切片
		protected var tankBitmap:Bitmap;
		
		//坦克阵营
		protected var _team:Number;

		/*
		 * @初始化
		 * @param x{Number}:初始水平坐标
		 * @param y{Number}:初始竖直坐标
		 * @param w{Number}:初始宽度
		 * @param h{Number}:初始高度
		 * */
		public function TankBase(x,y,w:Number=32,h:Number=32) 
		{
			this.x = x;
			this.y = y;
			this.w = w;
			this.h = h;
			
			this.tankBitmap = new Bitmap();
			this.tankBitmap.bitmapData = new BitmapData(w, h);
			
			this.render();
		}
		
		//render
		public function render():void
		{
			
		}
		
		//update
		public  function update():void
		{
			
		}
		
		//方向 getter setter，设置方向后要重新render一下
		public function get direction():String
		{
			return this._direction;
		}
		
		public function set direction(dir:String):void
		{
			this._direction = dir;
			this.render();
		}
		
		//子弹 getter setter ,set后要设置子弹的owner属性为tank实例本身
		public function get bullet():BulletBase
		{
			return this._bullet;
		}
		
		public function set bullet(bul:BulletBase):void
		{
			this._bullet = bul;
			if (bul) {//如果bul不存在则为置空操作
				bul.owner = this;
			}
		}
		
		//阵营
		public function get team():Number
		{
			return this._team;
		}
		
		//坦克阵亡
		public function die():void
		{
			this.parent.removeChild(this);
		}
		
		/*
		 * @射击
		 * */
		protected function shoot():void
		{
			var x, y, w = 6, h = 6;
			switch(this.direction){
				case GameConst.UP:
					x = this.x + (32 - 6) / 2;
					y = this.y - 6;
					break;
				case GameConst.DOWN:
					x = this.x + (32 - 6) / 2;
					y = this.y + 32;
					break;
				case GameConst.LEFT:
					x = this.x -6;
					y = this.y + (32 - 6) / 2;
					break;
				case GameConst.RIGHT:
					x = this.x + 32;
					y = this.y + (32 - 6) / 2;
					break;
			}
			var bul = new BulletBase(x, y, w, h, this.direction);
			this.bullet = bul;
			var scene:TankGame = GameUtil.gameScene;
			scene.bullets.addChild(bul);
		}
		
		
		//和砖，海洋等障碍物的碰撞检测
		protected function hitTestMap() 
		{
			var rect=GameUtil.tankHitTestTile(this.getBounds(stage),this.direction);	
			if(rect){
				//调整tank位置
				switch(this.direction){
					case 'up':
						this.y=rect.y+rect.height;
						break;
					case 'right':
						this.x=rect.x-this.width;
						break;
					case 'down':
						this.y=rect.y-this.height;
						break;
					case 'left':
						this.x=rect.x+rect.width;
						break;
					default :
						break;
				}
			}
			return rect;
		}
		
		//和墙壁的碰撞
		protected function hitTestWall():Boolean
		{
			var isHit=false,
				stageWidth:Number = stage.stageWidth,
				stageHeight:Number = stage.stageHeight;
			
			if (this.x < 0) {
				this.x = 0;
				isHit = true;
			}else if ((this.x + this.width) >stageWidth) {
				this.x = stageWidth - this.width;
				isHit = true;
			}
			
			if (this.y < 0) {
				this.y = 0;
				isHit = true;
			}else if ((this.y + this.height) > stageHeight) {
				this.y = stageHeight - this.height;
				isHit = true;
			}
			
			return isHit;
		}
		
		//是否和其他tank相撞
		public function hitTestTank(tank:TankBase):Boolean
		{
			var isHit:Boolean = false;
			if (GameUtil.hitTestRectangle(this.getBounds(stage),tank.getBounds(stage))) {
				switch(this._direction) {
					case GameConst.UP:
						if (this.y > tank.y) {
							this.y = tank.y + tank.height;
							return true;
						}
						break;
					case GameConst.DOWN:
						if (this.y < tank.y) {
							this.y = tank.y - this.height;
							return true;
						}
						break;
					case GameConst.LEFT:
						if (this.x > tank.x) {
							this.x = tank.x + tank.width;
							return true
						}
						break;
					case GameConst.RIGHT:
						if (this.x < tank.x) {
							this.x = tank.x - this.width;
							return true;
						}
						break;
				}
			}
			return isHit;
		}
		
		
		//调整tank的位置，保证x或者y在某个网格的开始位置（16的倍数）
		protected function fixPosition():void
		{
			switch(this.direction){
				case GameConst.UP:
				case GameConst.DOWN:
					var x=int((this.x+8)/16);
					this.x=x*16;
					break;
				case GameConst.LEFT:
				case GameConst.RIGHT:
					var y=int((this.y+8)/16);
					this.y=y*16;
					break;
			}
		}
		
	}

}