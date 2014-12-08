package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class PlayState extends FlxState
	{
		//Variables go here
		private var map:FlxTilemap;
		private var bullet:Bullet;
		private var player:Player;
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
		private var waveTextDelay:FlxDelay;
		private var waveDelay:FlxDelay;
		private var gameOverDelay:FlxDelay;
		private var resetLevel:Boolean = false;
		private var playedFive:Boolean = false;
		private var playedFour:Boolean = false;
		private var playedThree:Boolean = false;
		private var playedTwo:Boolean = false;
		private var playedOne:Boolean = false;
		private var scoreText:FlxText;
		private var waveText:FlxText;
		private var secondsLeft:FlxText;
		private var gameOverText:FlxText;
		private var e1Emitter:FlxEmitter;
		private var e2Emitter:FlxEmitter;
		private var e3Emitter:FlxEmitter;
		private var e4Emitter:FlxEmitter;
		private var e5Emitter:FlxEmitter;
		private var e6Emitter:FlxEmitter;
		private var playerEmitter:FlxEmitter;
		private var bulletEmitter:FlxEmitter;
		
				
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
			
			player = new Player(11,23);
			add(player);
				
			initEnemies();
			
			initPlayerBullets();
			initEnemyBullets();
			
			scoreText = new FlxText(10,10,300,"Score: "+Registry.score);
			scoreText.setFormat(null,14,0xFFFFFF,"left", 0xFF0000);
			add(scoreText);
			
			waveText = new FlxText(FlxG.width*0.5-100,FlxG.height*0.5-110, 200, "Wave "+Registry.stage);
			waveText.setFormat(null,40,0xFFFFFF,"center",0xFF0000);
			add(waveText);
			
			FlxG.play(Registry.waveSound,.8);
			
			waveTextDelay = new FlxDelay(2000);
			waveTextDelay.start();

			waveDelay = new FlxDelay(26000);
			waveDelay.start();
			
			secondsLeft = new FlxText(85,15,300, "Seconds Remaining: "+waveDelay.secondsRemaining);
			secondsLeft.setFormat(null,8,0xFFFFFF,"center",0xFF0000);
			add(secondsLeft);
			
			gameOverText = new FlxText(FlxG.width*0.5-100,FlxG.height*0.5-110, 200, "Game Over");
			gameOverText.setFormat(null,40,0xFFFFFF,"center",0xFF0000);
			add(gameOverText);
			gameOverText.visible = false;
			
			initLives();
			
			levelResetTimer = new FlxDelay(2000);
			
			timer1 = new FlxDelay(3000);
			timer1.start();		
		}	
		
		override public function update():void
		{			
			scoreText.text = "Score: "+Registry.score;
			secondsLeft.text = "Seconds Remaining: "+waveDelay.secondsRemaining;
			
			/*if(Registry.playerLives == 0)
			{
				
			}*/
			
			if(gameOverDelay != null)
			{			
				if(gameOverDelay.hasExpired)
				{
					FlxG.switchState(new AttractPlayState());
				}
			}
			
			if(!gameOverText.visible)
			{
				if(waveDelay.secondsRemaining == 5 && !playedFive)
				{
					playedFive = true;
					FlxG.play(Registry.five,1);
				}
				else if(waveDelay.secondsRemaining == 4 && !playedFour)
				{
					playedFour = true;
					FlxG.play(Registry.four,1);
				}
				else if(waveDelay.secondsRemaining == 3 && !playedThree)
				{
					playedThree = true;
					FlxG.play(Registry.three,1);
				}
				else if(waveDelay.secondsRemaining == 2 && !playedTwo)
				{
					playedTwo = true;
					FlxG.play(Registry.two,1);
				}
				else if(waveDelay.secondsRemaining == 1 && !playedOne)
				{
					playedOne = true;
					FlxG.play(Registry.one,1);
				}
			}
			
			if(waveTextDelay.hasExpired)
			{
				waveText.visible = false;
			}
			
			if(waveDelay.hasExpired && Registry.playerLives > 0)
			{
				trace("inside wave delay");
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
				Registry.stage += 1;
				FlxG.resetState();	
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
				FlxG.resetState();
			}
	
			FlxG.overlap(e1BulletGroup,player,killPlayer);
			FlxG.overlap(e2BulletGroup,player,killPlayer);
			FlxG.overlap(e3BulletGroup,player,killPlayer);
			FlxG.overlap(e4BulletGroup,player,killPlayer);
			FlxG.overlap(e5BulletGroup,player,killPlayer);
			FlxG.overlap(e6BulletGroup,player,killPlayer);		
			
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
			
		}//end Update
		
		private function killPlayer(obj1:FlxObject,obj2:FlxObject):void
		{		
			obj1.kill();
			obj2.kill();
			FlxG.play(Registry.playerExplosion,.8);
			playerEmitter = new FlxEmitter(obj2.x+(obj2.width/2),obj2.y+(obj2.height/2));
			playerEmitter.setXSpeed(-100,100);
			playerEmitter.setYSpeed(-100,100);
			playerEmitter.gravity = 100;
			playerEmitter.makeParticles(Registry.playerEmit,27,0,true);
			add(playerEmitter);
			playerEmitter.start(true,2);
			Registry.playerLives -= 1;
			
			if(Registry.playerLives <= 0)
			{
				
				trace("Starting gameOverDelay Timer");
				gameOverDelay = new FlxDelay(5000);
				gameOverDelay.start();
				waveText.visible = false;
				gameOverText.visible = true;
				resetLevel = false;
			}
			else if(Registry.playerLives > 0)
			{
				resetLevel = true;
				levelResetTimer.start();
			}
		}
				
		private function killEnemy1(obj1:FlxObject,obj2:FlxObject):void
		{
			obj2.kill();
			FlxG.play(Registry.enemyExplosion,.8);
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
			FlxG.play(Registry.enemyExplosion,.8);
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
			FlxG.play(Registry.enemyExplosion,.8);
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
			FlxG.play(Registry.enemyExplosion,.8);
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
			FlxG.play(Registry.enemyExplosion,.8);
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
			FlxG.play(Registry.enemyExplosion,.8);
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
			FlxG.play(Registry.bulletExplosion,.8);
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
				player.bulletArray = bulletGroup.members;
				add(bulletGroup);
			}
		}
		
		private function initEnemyBullets():void
		{
			for(var v:int = 0;v<30;v++)
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

		private function randomRange(minNum:Number, maxNum:Number):Number
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
	}
}
