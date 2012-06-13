package  
{
	import flash.display.Sprite;
	
	
	[SWF(width = "416", height = "416", backgroundColor = "#000000",frameRate="50")]
	/**
	 * ...
	 * @author lynsun
	 */
	public class Main extends Sprite
	{
		
		public function Main() 
		{
			init();
		}
		
		//游戏初始化
		public function init():void
		{
			var tankGame:TankGame = new TankGame();
			addChild(tankGame);
		}
		
	}

}