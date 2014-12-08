package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class AttractPlayState extends FlxState
	{
		//Variables go here
		private var map:FlxTilemap;
		private var bullet:Bullet;
		private var attractPlayer:AttractPlayer;
		private var player2:Player2;
		private var enemy1:Enemy1;
		private var enemy2:Enemy2;
		private var enemy3:Enemy3;
		private var enemy4:Enemy4;
		private var enemy5:Enemy5;
		private var enemy6:Enemy6;
		private var background:FlxSprite;
		private var enemyGroup1:FlxGroup = new FlxGroup();
		private var enemyGroup2:FlxGroup = new FlxGroup();
		private var enemyGroup3:FlxGroup = new FlxGroup();
		private var enemyGroup4:FlxGroup = new FlxGroup();
		private var enemyGroup5:FlxGroup = new FlxGroup();
		private var enemyGroup6:FlxGroup = new FlxGroup();
		private var bulletGroup:FlxGroup = new FlxGroup();
		private var e1BulletGroup:FlxGroup = new FlxGroup();
		private var e2BulletGroup:FlxGroup = new FlxGroup();
		private var e3BulletGroup:FlxGroup = new FlxGroup();
		private var e4BulletGroup:FlxGroup = new FlxGroup();
		private var e5BulletGroup:FlxGroup = new FlxGroup();
		private var e6BulletGroup:FlxGroup = new FlxGroup();
		private var timer1:FlxDelay;
		private var levelResetTimer:FlxDelay;
		private var blinkTimer:FlxDelay;
		private var resetLevel:Boolean = false;
		private var scoreText:FlxText;
		private var e1Emitter:FlxEmitter;
		private var e2Emitter:FlxEmitter;
		private var e3Emitter:FlxEmitter;
		private var e4Emitter:FlxEmitter;
		private var e5Emitter:FlxEmitter;
		private var e6Emitter:FlxEmitter;
		private var playerEmitter:FlxEmitter;
		private var bulletEmitter:FlxEmitter;
		private var gameName:FlxText;
		private var startText:FlxText;
		private var instruct:FlxText;
		private var instruct2:FlxText;
		private var instruct3:FlxText;
				
		override public function create():void
		{	
			background = new FlxSprite();
			background.loadGraphic(Registry.bg4,false,false,384,384);
			add(background);
			
			map = new FlxTilemap;
			map.loadMap(new Registry.map,Registry.pipes,16,16);
			add(map);
			
			FlxG.mouse.show();
			
			FlxG.worldBounds = new FlxRect(0, 0, 384, 384);
			
			attractPlayer = new AttractPlayer(11,23);
			add(attractPlayer);
			
			initEnemies();
			
			initPlayerBullets();
			initEnemyBullets();
			
			scoreText = new FlxText(10,10,300,"Score: "+Registry.score);
			scoreText.setFormat(null,14,0xFFFFFF,"left");
			add(scoreText);
			
			initLives();
			
			initTitle();
			
			blinkTimer = new FlxDelay(500);
			blinkTimer.start();
			
			levelResetTimer = new FlxDelay(2000);
			
			timer1 = new FlxDelay(3000);
			timer1.start();
		}	
		
		override public function update():void
		{
			
			scoreText.text = "Score: "+Registry.score;
			
			if(FlxG.keys.justPressed("X"))
			{
				Registry.score = 0;
				Registry.stage = 1;
				Registry.playerLives = 5;
				FlxG.switchState(new PlayState());
			}
			
			if(blinkTimer.hasExpired)
			{
				if(startText.visible)
					startText.visible = false;
				else
					startText.visible = true;
				blinkTimer.reset(500);
			}
			
			if(timer1.hasExpired)
			{
				
				enemy1 = new Enemy1(-16,224);
				enemyGroup1.add(enemy1);
				add(enemyGroup1);
				
				enemy2 = new Enemy2(384,224);
				enemyGroup2.add(enemy2);
				add(enemyGroup2);
				
				enemy3 = new Enemy3(-16,128);
				enemyGroup3.add(enemy3);
				add(enemyGroup3);
				
				enemy4 = new Enemy4(384,128);
				enemyGroup4.add(enemy4);
				add(enemyGroup4);
				
				enemy5 = new Enemy5(-16,32);
				enemyGroup5.add(enemy5);
				add(enemyGroup5);
				
				enemy6 = new Enemy6(384,32);
				enemyGroup6.add(enemy6);
				add(enemyGroup6);
				
				initEnemyBullets();
				
				timer1.reset(3000);
				
			}
			
			if(Registry.playerLives <= 0)
			{
				bulletGroup.clear();
				enemyGroup1.clear();
				enemyGroup2.clear();
				enemyGroup3.clear();
				enemyGroup4.clear();
				enemyGroup5.clear();
				enemyGroup6.clear();
				e1BulletGroup.clear();
				e2BulletGroup.clear();
				e3BulletGroup.clear();
				e4BulletGroup.clear();
				e5BulletGroup.clear();
				e6BulletGroup.clear();
				resetLevel = false;
				Registry.playerLives = 5;
				Registry.score = 0;
				FlxG.resetState();
			}
			
			if(levelResetTimer.hasExpired && resetLevel)
			{
				bulletGroup.clear();
				enemyGroup1.clear();
				enemyGroup2.clear();
				enemyGroup3.clear();
				enemyGroup4.clear();
				enemyGroup5.clear();
				enemyGroup6.clear();
				e1BulletGroup.clear();
				e2BulletGroup.clear();
				e3BulletGroup.clear();
				e4BulletGroup.clear();
				e5BulletGroup.clear();
				e6BulletGroup.clear();
				resetLevel = false;
				Registry.playerLives -= 1;
				FlxG.resetState();
			}
			
			FlxG.overlap(e1BulletGroup,attractPlayer,killPlayer);
			FlxG.overlap(e2BulletGroup,attractPlayer,killPlayer);
			FlxG.overlap(e3BulletGroup,attractPlayer,killPlayer);
			FlxG.overlap(e4BulletGroup,attractPlayer,killPlayer);
			FlxG.overlap(e5BulletGroup,attractPlayer,killPlayer);
			FlxG.overlap(e6BulletGroup,attractPlayer,killPlayer);
			
			
			FlxG.overlap(enemyGroup1,bulletGroup,killEnemy1);
			FlxG.overlap(enemyGroup2,bulletGroup,killEnemy2);
			FlxG.overlap(enemyGroup3,bulletGroup,killEnemy3);
			FlxG.overlap(enemyGroup4,bulletGroup,killEnemy4);
			FlxG.overlap(enemyGroup5,bulletGroup,killEnemy5);
			FlxG.overlap(enemyGroup6,bulletGroup,killEnemy6);
			
			FlxG.overlap(e1BulletGroup,bulletGroup,killBullet);
			FlxG.overlap(e2BulletGroup,bulletGroup,killBullet);
			FlxG.overlap(e3BulletGroup,bulletGroup,killBullet);
			FlxG.overlap(e4BulletGroup,bulletGroup,killBullet);
			FlxG.overlap(e5BulletGroup,bulletGroup,killBullet);
			FlxG.overlap(e6BulletGroup,bulletGroup,killBullet);
			
				
			super.update();
			
		}
		
		private function killPlayer(obj1:FlxObject,obj2:FlxObject):void
		{		
			obj1.kill();
			obj2.kill();
			//FlxG.play(Registry.playerEmit,1);
			playerEmitter = new FlxEmitter(obj2.x+(obj2.width/2),obj2.y+(obj2.height/2));
			playerEmitter.setXSpeed(-100,100);
			playerEmitter.setYSpeed(-100,100);
			playerEmitter.gravity = 100;
			playerEmitter.makeParticles(Registry.playerEmit,27,0,true);
			add(playerEmitter);
			playerEmitter.start(true,2);
			resetLevel = true;
			levelResetTimer.start();
			
		}
		
		private function killEnemy1(obj1:FlxObject,obj2:FlxObject):void
		{

			
			obj2.kill();
			//FlxG.play(Registry.playerEmit,1);
			e1Emitter = new FlxEmitter(obj1.x,obj1.y);
			e1Emitter.setXSpeed(-100,100);
			e1Emitter.setYSpeed(-100,100);
			e1Emitter.gravity = 100;
			e1Emitter.makeParticles(Registry.e1Emit,27,0,true);
			add(e1Emitter);
			e1Emitter.start(true,.8);
			obj1.reset(-16,224);
			Registry.score += 100;
		}
		
		private function killEnemy2(obj1:FlxObject,obj2:FlxObject):void
		{
			
			
			obj2.kill();
			//FlxG.play(Registry.playerEmit,1);
			e2Emitter = new FlxEmitter(obj1.x,obj1.y);
			e2Emitter.setXSpeed(-100,100);
			e2Emitter.setYSpeed(-100,100);
			e2Emitter.gravity = 100;
			e2Emitter.makeParticles(Registry.e2Emit,27,0,true);
			add(e2Emitter);
			e2Emitter.start(true,.8);
			obj1.reset(384,224);
			Registry.score += 100;
		}
		
		private function killEnemy3(obj1:FlxObject,obj2:FlxObject):void
		{
			
			obj2.kill();
			//FlxG.play(Registry.playerEmit,1);
			e3Emitter = new FlxEmitter(obj1.x,obj1.y);
			e3Emitter.setXSpeed(-100,100);
			e3Emitter.setYSpeed(-100,100);
			e3Emitter.gravity = 100;
			e3Emitter.makeParticles(Registry.e3Emit,27,0,true);
			add(e3Emitter);
			e3Emitter.start(true,.8);
			obj1.reset(-16,128);
			Registry.score += 200;
		}
		
		private function killEnemy4(obj1:FlxObject,obj2:FlxObject):void
		{
			
			obj2.kill();
			//FlxG.play(Registry.playerEmit,1);
			e4Emitter = new FlxEmitter(obj1.x,obj1.y);
			e4Emitter.setXSpeed(-100,100);
			e4Emitter.setYSpeed(-100,100);
			e4Emitter.gravity = 100;
			e4Emitter.makeParticles(Registry.e4Emit,27,0,true);
			add(e4Emitter);
			e4Emitter.start(true,.8);
			obj1.reset(384,128);
			Registry.score += 200;
		}
		
		private function killEnemy5(obj1:FlxObject,obj2:FlxObject):void
		{
			
			obj2.kill();
			//FlxG.play(Registry.playerEmit,1);
			e5Emitter = new FlxEmitter(obj1.x,obj1.y);
			e5Emitter.setXSpeed(-100,100);
			e5Emitter.setYSpeed(-100,100);
			e5Emitter.gravity = 100;
			e5Emitter.makeParticles(Registry.e5Emit,27,0,true);
			add(e5Emitter);
			e5Emitter.start(true,.8);
			obj1.reset(-16,32);
			Registry.score += 300;
		}
		
		private function killEnemy6(obj1:FlxObject,obj2:FlxObject):void
		{
			
			obj2.kill();		
			//FlxG.play(Registry.playerEmit,1);
			e6Emitter = new FlxEmitter(obj1.x,obj1.y);
			e6Emitter.setXSpeed(-100,100);
			e6Emitter.setYSpeed(-100,100);
			e6Emitter.gravity = 100;
			e6Emitter.makeParticles(Registry.e6Emit,27,0,true);
			add(e6Emitter);
			e6Emitter.start(true,.8);
			obj1.reset(384,32);
			Registry.score += 300;
		}
		
		private function killBullet(obj1:FlxObject,obj2:FlxObject):void
		{
			obj1.kill();
			obj2.kill();
			//FlxG.play(Registry.death,.8);
			bulletEmitter = new FlxEmitter(obj1.x,obj1.y);
			bulletEmitter.setXSpeed(-25,25);
			bulletEmitter.setYSpeed(-25,25);
			bulletEmitter.gravity = 50;
			bulletEmitter.makeParticles(Registry.bEmit,50,0,true,.5);
			add(bulletEmitter);
			bulletEmitter.start(true,.8);
			Registry.score += 50;
		}
		
	 	private function initLives():void
		{
			switch(Registry.playerLives)
			{
				case 5:
				{
					player2 = new Player2(308,10);
					add(player2);
					player2 = new Player2(326,10);
					add(player2);
					player2 = new Player2(344,10);
					add(player2);
					player2 = new Player2(362,10);
					add(player2);
					break;
				}
				case 4:
				{
					player2 = new Player2(326,10);
					add(player2);
					player2 = new Player2(344,10);
					add(player2);
					player2 = new Player2(362,10);
					add(player2);
					break;
				}
				case 3:
				{
					player2 = new Player2(344,10);
					add(player2);
					player2 = new Player2(362,10);
					add(player2);
					break;
				}
				case 2:
				{
					player2 = new Player2(362,10);
					add(player2);
					break;
				}
			}
		}
		
		private function initEnemies():void
		{
				enemy1 = new Enemy1(-16,224);
				enemyGroup1.add(enemy1);
				add(enemyGroup1);
				
				enemy2 = new Enemy2(384,224);
				enemyGroup2.add(enemy2);
				add(enemyGroup2);
				
				enemy3 = new Enemy3(-16,128);
				enemyGroup3.add(enemy3);
				add(enemyGroup3);
				
				enemy4 = new Enemy4(384,128);
				enemyGroup4.add(enemy4);
				add(enemyGroup4);
				
				enemy5 = new Enemy5(-16,32);
				enemyGroup5.add(enemy5);
				add(enemyGroup5);
				
				enemy6 = new Enemy6(-384,32);
				enemyGroup6.add(enemy6);
				add(enemyGroup6);
		}

		private function initPlayerBullets():void
		{
			for(var v:int = 0;v<20;v++)
			{
				bullet = new Bullet(-20,-20);
				bulletGroup.add(bullet);
			}
			
			attractPlayer.bulletArray = bulletGroup.members;
			add(bulletGroup);
		}
		
		private function initEnemyBullets():void
		{
			for(var v:int = 0;v<20;v++)
			{
				bullet = new Bullet(-20,-20);
				e1BulletGroup.add(bullet);
				
				bullet = new Bullet(-20,-20);
				e2BulletGroup.add(bullet);
				
				bullet = new Bullet(-20,-20);
				e3BulletGroup.add(bullet);
				
				bullet = new Bullet(-20,-20);
				e4BulletGroup.add(bullet);
				
				bullet = new Bullet(-20,-20);
				e5BulletGroup.add(bullet);
				
				bullet = new Bullet(-20,-20);
				e6BulletGroup.add(bullet);
			}
			
			enemy1.bulletArray = e1BulletGroup.members;
			add(e1BulletGroup);
			
			enemy2.bulletArray = e2BulletGroup.members;
			add(e2BulletGroup);
			
			enemy3.bulletArray = e3BulletGroup.members;
			add(e3BulletGroup);
			
			enemy4.bulletArray = e4BulletGroup.members;
			add(e4BulletGroup);
			
			enemy5.bulletArray = e5BulletGroup.members;
			add(e5BulletGroup);
			
			enemy6.bulletArray = e6BulletGroup.members;
			add(e6BulletGroup);
		}
		
		private function initTitle():void
		{
			gameName = new FlxText(FlxG.width*0.5-100,FlxG.height*0.5-110, 200, "Rail Gunner");
			gameName.setFormat(null,40,0xFFFFFF, "center",0xFF0000);
			add(gameName);
			
			instruct = new FlxText(FlxG.width*0.5-100,FlxG.height-200, 200, "'A/D' or 'Left/Right' Arrow Keys to move");
			instruct.setFormat(null,15,0xFFFFFF, "center",0xFF0000);
			add(instruct);
			
			instruct2 = new FlxText(FlxG.width*0.5-100,FlxG.height-145, 200, "Space or Left Mouse Button to Fire");
			instruct2.setFormat(null,15,0xFFFFFF, "center",0xFF0000);
			add(instruct2);
			
			instruct3 = new FlxText(FlxG.width*0.5-100,FlxG.height-90, 200, "Each wave is 25 seconds. How many can you survive?");
			instruct3.setFormat(null,10,0xFFFFFF, "center",0xFF0000);
			add(instruct3);
			
			startText = new FlxText(FlxG.width*0.5-100,FlxG.height-50, 200, "PRESS [x] TO START");
			startText.setFormat(null,15,0xFFFFFF, "center",0xFF0000);
			add(startText);
		}
		
		private function randomRange(minNum:Number, maxNum:Number):Number
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
	}
}
