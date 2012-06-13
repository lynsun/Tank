package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	/**
	 * ...
	 * @author lynsun
	 */
	public class MapManager extends Sprite
	{
		
		//tile的尺寸
		private var tileWidth:Number = GameConst.TILEWIDTH;
		private var tileHeight:Number = GameConst.TILEHEIGHT;
		//行列数
		private var rows:Number = GameConst.MAPROW;
		private var cols:Number = GameConst.MAPCOL;
		//地图尺寸
		private var mapWidth:Number = GameConst.MAPWIDTH;
		private var mapHeight:Number = GameConst.MAPHEIGHT;
		
		
		private var canvasBitmap:Bitmap;
		private var	tileMapBitmap:Bitmap;
		
		private var canvasBitmapData:BitmapData;
		private var tileMapBitmapData:BitmapData;
		
		public function MapManager(image:Bitmap) 
		{
			this.tileMapBitmap = image;
		}
		
		public function render(map:Array):void
		{
			if (this.numChildren == 1) {
				this.removeChildAt(0);
			}
			this.drawMap(map);
			addChild(this.canvasBitmap);
		}
		
		//绘制地图
		public function drawMap(map:Array):void
		{
			this.canvasBitmap = new Bitmap();
			this.canvasBitmapData = new BitmapData(mapWidth,mapHeight, 1,0x000000);
			this.tileMapBitmapData = tileMapBitmap.bitmapData;
			
			for (var i = 0; i < rows; i++) {
				var row = map[i];
				for (var j = 0; j < cols; j++) {
					var num = row[j];
					drawTile(i,j,num);
				}
			}
			canvasBitmap.bitmapData = canvasBitmapData;
		}
		
		//画tile
		public function drawTile(row:Number,col:Number,mapNum:Number):void
		{
			var sx, sy = 96,
				sw=tileWidth,sh=tileHeight,
				rectangle:Rectangle=new Rectangle(0,0,tileWidth,tileHeight),
				destPoint:Point=new Point(0,0);
			switch(mapNum) {
				//空地
				case 0:
					return;
					break;
				//红砖	
				case 1:
					sx = 0;
					break;
				//白砖
				case 2:
					sx = 16;
					break;
				//草坪
				case 3:
					sx = 32; 
					break;
				//海洋
				case 4:
					sx = 48; 
					break;
				//雪地
				case 5:
					sx = 60; 
					break;
				//可忽略
				case 8:
					return;
					break;
				//老家
				case 9:
					sw = sh = tileWidth * 2;
					break;
				default:
					return;
					break;
			}
			destPoint = new Point(col * tileWidth, row * tileHeight);
			rectangle = new Rectangle(sx, sy, sw, sh);
			canvasBitmapData.copyPixels(tileMapBitmapData, rectangle, destPoint);
			
		}
		
	}

}