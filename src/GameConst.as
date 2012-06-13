package  
{
	import flash.display.Bitmap;
	import flash.display.Stage;
	/**
	 * ...
	 * @author lynsun
	 */
	public class GameConst 
	{
		//游戏图片
		public static var gameImage:Bitmap;
		
		
		//tile的尺寸
		public static const TILEWIDTH = 16;
		public static const TILEHEIGHT = 16;
		
		//地图的尺寸
		public static const MAPWIDTH = 416;
		public static const MAPHEIGHT = 416;
		
		//地图数组行列数
		public static const MAPROW = 26;
		public static const MAPCOL = 26;
		
		
		//坦克的正常速度
		public static const TANKSPEED_NORMAL = 2;
		//坦克的快速
		public static const TANKSPEED_HIGH = 4;
		
		//子弹的正常速度
		public static const BULLET_SPEED_NORMAL = 5;
		
		//运动方向
		public static const UP = 'up';
		public static const DOWN = 'down';
		public static const RIGHT = 'right';
		public static const LEFT = 'left';
		
		//坦克运动状态
		public static const STATIC = 'static';
		public static const MOVING = 'moving';
		
		//游戏图片大小
		public static const IMAGEWIDTH = '';
		public static const IMAGEHEIGHT = '';
		
		//坦克阵营，我方坦克是1，敌人是2
		public static const MYTEAM = 1;
		public static const ENEMYTEAM = 2;
		
		//敌人坦克的类型
		public static const SIMPLEENEMY = 'SimpleEnemy';
		
		
		//游戏地图
		public static var map:Array=[
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [3,3,3,3,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,3,3,3,3],
            [3,3,3,3,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,3,3,3,3],
            [3,3,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,3,3],
            [3,3,0,0,0,0,0,1,1,1,3,3,1,1,3,3,1,1,1,0,0,0,0,0,3,3],
            [0,0,0,0,0,0,1,1,1,1,3,3,1,1,3,3,1,1,1,1,0,0,0,0,0,0],
            [0,0,0,0,0,0,1,1,3,3,3,3,1,1,3,3,3,3,1,1,0,0,0,0,0,0],
            [0,0,0,0,0,0,1,1,3,3,3,3,1,1,3,3,3,3,1,1,0,0,0,0,0,0],
            [0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0],
            [3,3,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,3,3],
            [3,3,0,0,0,0,1,1,1,1,3,3,1,1,3,3,1,1,1,1,0,0,0,0,3,3],
            [3,3,3,3,0,0,0,0,1,1,3,3,1,1,3,3,1,1,0,0,0,0,3,3,3,3],
            [3,3,3,3,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,3,3,3,3],
            [4,4,4,4,4,4,0,0,1,1,1,1,1,1,1,1,1,1,0,0,4,4,4,4,4,4],
            [4,4,4,4,4,4,0,0,1,1,1,1,1,1,1,1,1,1,0,0,4,4,4,4,4,4],
            [0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,1,1,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0],
            [0,0,0,0,0,0,0,0,1,0,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0],
            [0,2,0,2,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,2,0,2,0],
            [0,2,0,2,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,2,0,2,0],
            [1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1],
            [1,0,1,0,1,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,1,0,1,0,1],
            [2,0,2,0,2,0,0,2,0,0,0,1,9,8,1,0,0,0,2,0,0,2,0,2,0,2],
            [2,0,2,0,2,0,0,2,0,0,0,1,8,8,1,0,0,0,2,0,0,2,0,2,0,2]
		];
		
		public function GameConst() 
		{
			
		}
		
	}

}