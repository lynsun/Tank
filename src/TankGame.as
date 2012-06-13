package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.DRMAuthenticationCompleteEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.display.MovieClip;
	
	import TankBase;
	import Tank;
	
	/**
	 * ...
	 * @author lynsun
	 */
	public class TankGame extends Sprite 
	{	
		[Embed(source='tankAll.gif')]
		private var TileMap:Class;
				
		//玩家坦克容器
		public var mytanks:Sprite = new Sprite();
		//所有enemy的容器
		public var enemies:Sprite = new Sprite();
		//所有的子弹的容器
		public var bullets:Sprite = new Sprite();
		
		public function TankGame():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//添加game objects的容器
			addChild(mytanks);//玩家
			addChild(enemies);//敌军坦克
			addChild(bullets);//子弹
			
			//初始化游戏图片
			var gameImage:Bitmap = new TileMap() as Bitmap;
			GameConst.gameImage = gameImage;
			
			
			TankBase.tankImage = gameImage;
			var tank = new Tank(144, 384,32,32);
			mytanks.addChild(tank);
			
			var senemy1:SimpleEnemy = new SimpleEnemy(0, 0);
			var senemy2:SimpleEnemy = new SimpleEnemy(64, 0);
			var senemy3:SimpleEnemy = new SimpleEnemy(200, 0);
			var senemy4:SimpleEnemy = new SimpleEnemy(100, 0);
			var senemy5:SimpleEnemy = new SimpleEnemy(140, 0);
			var senemy6:SimpleEnemy = new SimpleEnemy(250, 0);
			enemies.addChild(senemy1);
			enemies.addChild(senemy2);
			enemies.addChild(senemy3);
			enemies.addChild(senemy4);
			enemies.addChild(senemy5);
			enemies.addChild(senemy6);
			
			
			
			//绘制地图
			var mapManager:MapManager = new MapManager(gameImage);
			mapManager.render(GameConst.map);
			addChild(mapManager);
			
			//主场景赋值
			GameUtil.gameScene = this;
			
			GameUtil.gameMapManager = mapManager;
			
			GameUtil.stage = stage;
			
			Bomb.bomb(0, 0);
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrameListener);
		}
		
		private function onEnterFrameListener(e:Event):void
		{
			updateGameObject();
		}
		
		//更新所有游戏对象
		private function updateGameObject():void
		{
			updateMyTank();
			updateEnemy();
			updateBullet();
			
			bulletHitTankCheck();
			bulletHitBullet();
			tankHitTank();
		}
		
		//更新我方坦克
		private function updateMyTank():void
		{
			var len = mytanks.numChildren;
			for (var i = 0; i < len; i++) {
				var mytank = mytanks.getChildAt(i);
				if (mytank) {
					mytank.update();
				}
			}
		}
		
		//更新子弹
		private function updateBullet():void 
		{
			for (var i = 0; i < bullets.numChildren; i++) {
				var bullet = bullets.getChildAt(i);
				if (bullet) {
					bullet.update();
					//和砖块的碰撞
					if (bullet.hitTestBrick()) {
						//爆炸动画
						bullet.dispose();
						GameUtil.gameMapManager.render(GameConst.map);
						i--;
						continue;
					}
					
					
					//是否出界
					if (bullet.hitTestWall()) {
						bullet.dispose();
						i--
						continue;
					}
					
				}
			}
		}
		
		
		//更新敌人
		private function updateEnemy():void
		{
			var len = enemies.numChildren;
			for (var i = 0; i < len; i++) {
				var enemy = enemies.getChildAt(i);
				if (enemy) {
					enemy.update();
				}
			}
		}
		
		//检测子弹是否击中坦克
		private function bulletHitTankCheck():void
		{
			for (var i = 0; i < bullets.numChildren; i++) {
				var bullet:BulletBase = bullets.getChildAt(i) as BulletBase;
				var owner:TankBase = bullet.owner as TankBase;
				for (var j = 0; j < enemies.numChildren; j++) {
					var enemy:EnemyTank = enemies.getChildAt(j) as EnemyTank;
					if (owner.team != enemy.team) {//如果阵营不同的话就检测
						if (enemy.hitTestObject(bullet)) {
							enemy.die();
							bullet.dispose();
							i--;
							break;
						}
					}
				}
				
				for (var k = 0; k < mytanks.numChildren; k++) {
					var mytank:Tank = mytanks.getChildAt(k) as Tank;
					if (owner.team != mytank.team) {
						if (mytank.hitTestObject(bullet)) {
							mytank.die();
							bullet.dispose();
							i--;
							break;
						}
					}
				}
			}
		}
		
		//子弹之间的碰撞
		private function bulletHitBullet():void
		{
			for (var i = 0; i < bullets.numChildren-1; i++) {
				var bullet:BulletBase = bullets.getChildAt(i) as BulletBase;
				for (var j = 1; j < bullets.numChildren; j++) {
					var innerBullet:BulletBase = bullets.getChildAt(j) as BulletBase;
					if (bullet.hitTestObject(innerBullet)) {
						//判断阵营
						var owner:TankBase = bullet.owner as TankBase;
						var innerOwner:TankBase = innerBullet.owner as TankBase;
						if (owner.team != innerOwner.team) {
							bullet.dispose();
							innerBullet.dispose();
							i--;
							break;
						}
					}
				}
			}
		}
		
		
		//坦克之间的碰撞
		private function tankHitTank():void
		{
			var tanks:Array = new Array();
			for (var i = 0, len1 = enemies.numChildren; i < len1; i++) {
				tanks.push(enemies.getChildAt(i));
			}
			for (var j = 0, len2 = mytanks.numChildren; j < len2; j++) {
				tanks.push(mytanks.getChildAt(j));
			}
			
			var len = tanks.length;
			for (var k = 0; k < len-1; k++) {
				var outerTank:TankBase = tanks[k];
				for (var z = 1; z < len; z++) {
					var innerTank:TankBase = tanks[z];
					if (outerTank.hitTestTank(innerTank)){
						if (outerTank.team == GameConst.MYTEAM) {
							
						}else {
							outerTank.vx = 0;
							outerTank.vy = 0;
							EnemyTank(outerTank).random();
						}
					}
				}
			}
		}
		
	}
	
}