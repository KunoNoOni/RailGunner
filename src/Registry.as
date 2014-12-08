package
{
	import org.flixel.*;

	public class Registry
	{
		//public static var levelIndex:int = 0;

		public static var score:int;
		public static var playerLives:int = 5;
		public static var stage:int = 1;
		public static var haveLaser:Boolean = false;


		[Embed(source = 'Sprites/pipes.png')] static public var pipes:Class;
		[Embed(source = 'Sprites/playerShip.png')] static public var playerShip:Class;
		[Embed(source = 'Sprites/bullet.png')] static public var bullet:Class;
		[Embed(source = 'Sprites/Enemy1.png')] static public var e1:Class;
		[Embed(source = 'Sprites/Enemy2.png')] static public var e2:Class;
		[Embed(source = 'Sprites/Enemy3.png')] static public var e3:Class;
		[Embed(source = 'Sprites/Enemy4.png')] static public var e4:Class;
		[Embed(source = 'Sprites/Enemy5.png')] static public var e5:Class;
		[Embed(source = 'Sprites/Enemy6.png')] static public var e6:Class;
		[Embed(source = 'Sprites/enemy1Emitter.png')] static public var e1Emit:Class;
		[Embed(source = 'Sprites/enemy2Emitter.png')] static public var e2Emit:Class;
		[Embed(source = 'Sprites/enemy3Emitter.png')] static public var e3Emit:Class;
		[Embed(source = 'Sprites/enemy4Emitter.png')] static public var e4Emit:Class;
		[Embed(source = 'Sprites/enemy5Emitter.png')] static public var e5Emit:Class;
		[Embed(source = 'Sprites/enemy6Emitter.png')] static public var e6Emit:Class;
		[Embed(source = 'Sprites/playerEmitter.png')] static public var playerEmit:Class;
		[Embed(source = 'Sprites/bulletEmitter.png')] static public var bEmit:Class;
		[Embed(source = 'Sprites/background4.png')] static public var bg4:Class;		
			
		[Embed(source = 'Maps/mapCSV_Group1_Map1.csv', mimeType = 'application/octet-stream')] static public var map:Class;
		
		[Embed(source = 'sounds/bulletExplosion.mp3')] static public var bulletExplosion:Class;
		[Embed(source = 'sounds/enemyExplosion.mp3')] static public var enemyExplosion:Class;
		[Embed(source = 'sounds/enemyShot.mp3')] static public var enemyShot:Class;
		[Embed(source = 'sounds/playerExplosion.mp3')] static public var playerExplosion:Class;
		[Embed(source = 'sounds/playerShot.mp3')] static public var playerShot:Class;
		[Embed(source = 'sounds/waveSound.mp3')] static public var waveSound:Class;
		[Embed(source = 'sounds/1.mp3')] static public var one:Class;
		[Embed(source = 'sounds/2.mp3')] static public var two:Class;
		[Embed(source = 'sounds/3.mp3')] static public var three:Class;
		[Embed(source = 'sounds/4.mp3')] static public var four:Class;
		[Embed(source = 'sounds/5.mp3')] static public var five:Class;
		
		
		
		//[Embed(source="../assets/celtic-bitty.ttf", fontFamily="Celtic", embedAsCFF="false")] static public var fntCeltic:String;
		
		
		public function Registry()
		{
		}	
	}
}