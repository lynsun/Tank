package  
{
	/**
	 * ...
	 * @author lynsun
	 */
	public class EnemyTank extends TankBase 
	{
		
		private var _lastShootTime:Date;
		
		public function EnemyTank(x,y,w:Number=32,h:Number=32) 
		{
			super(x, y, w, h);
			this._direction = GameConst.DOWN;//默认方向为下方
			this._team = GameConst.ENEMYTEAM;
			this.state = GameConst.MOVING;
			this._lastShootTime = new Date();
		}
		
		//update
		override public function update():void
		{
			
			var now:Date = new Date();
			var ran:Number = int(Math.random() * 4) + 3;//敌人每隔3-6s发射一次子弹
			if (now.time - this._lastShootTime.time > ran*1000) {//可以射击
				if (!this._bullet) {
					this.shoot();
					this._lastShootTime = now;
				}
			}
			
			if (this.moveable) {
				if (this.state == GameConst.MOVING) {
					//更新位置
					this.x += vx;
					this.y += vy;
					
					if (hitTestMap()) {
						random();
					}
					
					if (hitTestWall()) {
						random();
					}
					
					//调整位置
					this.fixPosition();
				}
			}
		}
		
		//随机运动
		public function random():void
		{
			var arr_dir:Array = new Array(GameConst.UP, GameConst.DOWN, GameConst.LEFT, GameConst.RIGHT);
			var ranIndex:Number = int(Math.random() * 4);
			this.direction = arr_dir[ranIndex];
			this.render();
			switch(this.direction) {
				case GameConst.UP:
					this.vx = 0;
					this.vy = -this.speed;
					break;
				case GameConst.RIGHT:
					this.vx = this.speed;
					this.vy = 0;
					break;
				case GameConst.DOWN:
					this.vx = 0;
					this.vy = this.speed;
					break;
				case GameConst.LEFT:
					this.vx = -this.speed;
					this.vy = 0;
					break;
				default:
					break;
			}
		}
		
	}

}