package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxDelay;

	//import org.flixel.plugin.photonstorm.FlxDelay;
			
	public class AttractPlayer extends FlxSprite
	{
		public var bulletArray:Array;
		private var bulletID:int = 0;
		private var bullet:FlxSprite;
		private var threshold:Number = 0.3;
		private var counter:Number=0;	
		private var tileSize:int=16;
		private var timer:FlxDelay;
		private var rndNum1:int;
		private var velNum:int;
		private var chooseDir:Boolean = true;
		
		public function AttractPlayer(X:Number=0,Y:Number=0)
		{
			super(X*16,Y*16);
			loadGraphic(Registry.playerShip,false,false,16,16);
			
			if(randomRange(1,6)<=3)
				velNum = 100;
			else
				velNum = -100
			timer = new FlxDelay(2200);
			timer.start();
		}
		
		override public function update():void
		{				
			if(this.x < 0)
				this.x = 0;
			if(this.y < 0)
				this.y = 0;
			
			if(this.x > 368 )
				this.x = 368;
			if(this.y > 368)
				this.y = 368;
			
			
			this.velocity.x = velNum;
			this.velocity.y = 0;
			counter += FlxG.elapsed;

			if(timer.hasExpired && chooseDir)
			{
				chooseDir = false
				velNum = -velNum;
				rndNum1 = randomRange(750,2200);
				chooseDir = true;
				timer.reset(rndNum1);
			}

			if(counter >= threshold)
			{
				counter = 0;
				//FlxG.play(Registry.LaserShoot,0.5);
				bullet = bulletArray[bulletID];
				bullet.reset(this.x+this.width/2-2,this.y-4);
				bullet.velocity.y -= 200;
				bulletID++;
				if(bulletID == 20)
				{
					bulletID = 0;
				}
			}
			
			super.update();
		}
		
		private function randomRange(minNum:Number, maxNum:Number):Number
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
	}
}