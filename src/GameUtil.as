package  
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.display.Stage;
	/**
	 * ...
	 * @author lynsun
	 */
	public class GameUtil 
	{
		
		
		//游戏主场景,所有类都可见
		public static var gameScene:TankGame;
		//游戏地图管理类，所有类可见
		public static var gameMapManager:MapManager;
		//stage
		public static var stage:Stage;
		
		public function GameUtil() 
		{
			
		}
		
		/*
		* @两个矩形的碰撞检测
		*/	
		public static function hitTestRectangle(rect1:Rectangle,rect2:Rectangle):Boolean
		{	
			return rect1.intersects(rect2);
		}
		
		/*
		 * @获取point所在的单元格
		 * @ret arr{Array}:元素分别为单元格的行列数
		 * */
		public static function locate(point:Point):Array
		{
			var x:Number=Math.floor(point.x/GameConst.TILEWIDTH);
			var y:Number=Math.floor(point.y/GameConst.TILEHEIGHT);
			return [x,y];
		}
		
		
		/*
		 * @根据tank的方向和中心的位置获取需要进行碰撞检测的tile
		 * @param rect{Rectangle}:待检测的矩形
		 * @param direction{String}:矩形的运动方向
		 * @ret Rectangle:单元格矩形
		 * */
		public static function tankHitTestTile(rect:Rectangle,direction:String){
			
			var	map = GameConst.map,
				center=new Point(rect.x+rect.width/2,rect.y+rect.height/2),
				cLoc = locate(center),
				x=cLoc[0],
				y = cLoc[1],
				tileWidth = GameConst.TILEWIDTH,
				tileHeight = GameConst.TILEHEIGHT,
				ret;
			
			switch(direction){
				case 'up':
					ret=[[x-1,y-1],[x,y-1],[x+1,y-1]];
					break;
				case 'right':
					ret=[[x+1,y-1],[x+1,y],[x+1,y+1]];
					break;
				case "down":
					ret = [[x - 1, y + 1], [x, y + 1], [x + 1, y + 1]];
					break;
				case 'left':
					ret=[[x-1,y-1],[x-1,y],[x-1,y+1]];
					break;
				default:break;
			}
			
			
			for(var i=0,len=ret.length;i<len;i++){
				var	elem=ret[i],
					x=elem[1],
					y=elem[0],
					rectangle=new Rectangle(y*tileWidth,x*tileHeight,tileWidth,tileHeight);
				//如果在地图数组中有这个元素
				if (!map[x] || !map[x][y]) {
					continue;
				}
				if ((map[x][y]==1)||(map[x][y]==2)||(map[x][y]==4)) {
					 if(hitTestRectangle(rect,rectangle)){
						//如果发生碰撞则返回碰撞的rect对象
						return rectangle;
					 }
				}
			}
			return null;
		}
		
		/*
		 * @根据bullet的方向和中心的位置获取需要进行碰撞检测的tile
		 * @param rect{Rectangle}:待检测的矩形
		 * @param direction{String}:矩形的运动方向
		 * @ret isHit:是否碰撞
		 * */
		public static function bulletHitTestTile(rect:Rectangle, direction:String):Boolean
		{
			var	map = GameConst.map,
				center=new Point(rect.x+rect.width/2,rect.y+rect.height/2),
				cLoc = locate(center),
				x=cLoc[0],
				y = cLoc[1],
				tileWidth = GameConst.TILEWIDTH,
				tileHeight = GameConst.TILEHEIGHT,
				ret,
				isHit=false;
			
			switch(direction){
				case 'up':
					ret=[[x-1,y],[x,y],[x+1,y]];
					break;
				case 'right':
					ret=[[x,y-1],[x,y],[x,y+1]];
					break;
				case "down":
					ret = [[x - 1, y ], [x, y ], [x + 1, y ]];
					break;
				case 'left':
					ret=[[x,y-1],[x,y],[x,y+1]];
					break;
				default:break;
			}
			
			
			for(var i=0,len=ret.length;i<len;i++){
				var	elem=ret[i],
					x=elem[1],
					y=elem[0],
					rectangle=new Rectangle(y*tileWidth,x*tileHeight,tileWidth,tileHeight);
				//如果在地图数组中有这个元素
				if (!map[x] || !map[x][y]) {
					continue;
				}
				if (map[x][y]==1) {
					 if(hitTestRectangle(rect,rectangle)){
						//如果发生碰撞，则修改地图数据
						map[x][y] = 0;
						isHit = true;
					 }
				}
			}
			
			return isHit;
		}
		
	}

}