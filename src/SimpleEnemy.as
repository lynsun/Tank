package  
{
	
	import flash.events.*;
	import flash.display.*;
	import flash.geom.*;
	/**
	 * ...
	 * @author lynsun
	 */
	public class SimpleEnemy extends EnemyTank
	{
		private var _type:String=GameConst.SIMPLEENEMY
		
		public function SimpleEnemy(x,y,w:Number=32,h:Number=32) 
		{
			super(x, y, w, h);
			render();
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		//init 
		public function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			this.vx = 0;
			this.vy = GameConst.TANKSPEED_NORMAL;
		}
		
		
		//render
		override public function render():void
		{
			var sx, sy=32,rect;
			switch(this.direction) {
				case GameConst.UP:
					sx = 0;
					break;
				case GameConst.RIGHT:
					sx=96;
					break;
				case GameConst.DOWN:
					sx=32;
					break;
				case GameConst.LEFT:
					sx=64;
					break;
				default:
					break;
			}
			rect = new Rectangle(sx, sy, w,h);
			
			this.tankBitmap.bitmapData.copyPixels(TankBase.tankImage.bitmapData, rect, new Point(0, 0));
			addChild(this.tankBitmap);
		}
	}

}