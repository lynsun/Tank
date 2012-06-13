package  
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author lynsun
	 */
	public class Tank extends TankBase 
	{
		
		public function Tank(x:Number,y:Number,w:Number,h:Number) 
		{
			super(x, y, w, h);
			this._team = GameConst.MYTEAM;
			render();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//addToStage后初始化 
		private function init(e:Event):void
		{
			bind();
			removeEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		//绑定事件
		private function bind():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDownListener);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUpListener);
		}
		
		private function onKeyDownListener(e:KeyboardEvent):void
		{
			switch(e.keyCode) {
				//up
				case Keyboard.UP:
					vx=0;
					vy = -GameConst.TANKSPEED_NORMAL;
					state = GameConst.MOVING;
					if (this.direction != GameConst.UP) {
						direction = GameConst.UP;
						this.render();
					}
					break;
				//down
				case Keyboard.DOWN:
					vx=0;
					vy=GameConst.TANKSPEED_NORMAL;
					state = GameConst.MOVING;
					if (this.direction != GameConst.DOWN) {
						direction = GameConst.DOWN;
						this.render();
					}
					break;
				//left
				case Keyboard.LEFT:
					vx=-GameConst.TANKSPEED_NORMAL;
					vy=0;
					state = GameConst.MOVING;
					if (this.direction != GameConst.LEFT) {
						direction = GameConst.LEFT;
						this.render();
					}
					break;
				//right
				case Keyboard.RIGHT:
					vx=GameConst.TANKSPEED_NORMAL;
					vy=0;
					state = GameConst.MOVING;
					if (this.direction != GameConst.RIGHT) {
						direction = GameConst.RIGHT;
						this.render();
					}
					break;
				//shoot
				case Keyboard.A:
					if (!this.bullet) {
						this.shoot();
					}
					break;
				default:	
					break;
			}
		}
		
		//keyup
		private function onKeyUpListener(e:KeyboardEvent):void
		{
			switch(e.keyCode) {
				case Keyboard.UP:
					this.vy = 0;
					this.state = GameConst.STATIC;
					break;
				case Keyboard.DOWN:
					this.vy = 0;
					this.state = GameConst.STATIC;
					break;
				case Keyboard.RIGHT:
					this.vx = 0;
					this.state = GameConst.STATIC;
					break;
				case Keyboard.LEFT:
					this.vx = 0;
					this.state = GameConst.STATIC;
					break;
				default:
					break;
			}
		}
		
		//render
		override public function render():void
		{
			var sx, sy,rect;
			switch(this.direction) {
				case GameConst.UP:
					sx=sy=0;
					break;
				case GameConst.RIGHT:
					sx=96;
					sy=0;
					break;
				case GameConst.DOWN:
					sx=32;
					sy=0;
					break;
				case GameConst.LEFT:
					sx=64;
					sy=0;
					break;
				default:
					break;
			}
			rect = new Rectangle(sx, sy, w,h);
			this.tankBitmap.bitmapData.copyPixels(TankBase.tankImage.bitmapData, rect, new Point(0, 0));
			addChild(this.tankBitmap);
		}
		
		//update
		override public function update():void
		{
			if (this.moveable) {
				if (this.state == GameConst.MOVING) {
					//更新位置
					this.x += vx;
					this.y += vy;
					
					//碰撞检测-砖块
					this.hitTestMap();
					//碰撞检测-墙壁
					this.hitTestWall();
					//调整位置
					this.fixPosition();
				}
			}
		}
		
	}

}