package
{
	import org.flixel.*;
	//import org.flixel.plugin.photonstorm.FlxDelay;
			
	public class Enemy1 extends FlxSprite
	{
		public var bulletArray:Array;
		private var bulletID:int = 0;
		private var bullet:FlxSprite;
		private var threshold:Number;
		private var counter:Number=0;
		private var startX:int;
		private var startY:int;
		private var bulletVelocity:int;
		
		public function Enemy1(X:Number=0,Y:Number=0)
		{
			startX = X;
			startY = Y
			super(X,Y);
			loadGraphic(Registry.e1,false,false,16,16);
			
			this.velocity.x = 50;
		}
		
		override public function update():void
		{				
			if(this.x > 400)
				this.reset(startX,startY);
			
			if(Registry.stage == 1)
			{
				threshold = 1.0;
				bulletVelocity = 45;
			}
			else if(Registry.stage == 2)
			{
				threshold = .8;
				bulletVelocity = 65;
			}
			else if(Registry.stage == 3)
			{
				threshold = .6;
				bulletVelocity = 75;
			}
			else if(Registry.stage == 4)
			{
				threshold = .4;
				bulletVelocity = 85;
			}
			else if(Registry.stage >= 5)
			{
				threshold = .2;
				bulletVelocity = 95;
			}
			
			counter += FlxG.elapsed;
			
			if(counter >= threshold)
			{
				counter = 0;
				//FlxG.play(Registry.enemyShot,0.5);
				bullet = bulletArray[bulletID];
				bullet.reset(this.x+this.width/2-1,this.y+this.height+4);
				bullet.velocity.y += bulletVelocity;
				bulletID++;
				if(bulletID == 30)
				{
					bulletID = 0;
				}
			}
			
			super.update();
		}		
	}
}