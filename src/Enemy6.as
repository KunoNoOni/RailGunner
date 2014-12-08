package
{
	import org.flixel.*;
	//import org.flixel.plugin.photonstorm.FlxDelay;
			
	public class Enemy6 extends FlxSprite
	{
		public var bulletArray:Array;
		private var bulletID:int = 0;
		private var bullet:FlxSprite;
		private var threshold:Number;
		private var counter:Number=0;	
		private var startX:int;
		private var startY:int;
		private var bulletVelocity:int;
		
		public function Enemy6(X:Number=0,Y:Number=0)
		{	
			startX = X;
			startY = Y
			super(X,Y);
			loadGraphic(Registry.e6,false,false,16,16);
			
			this.velocity.x = -45;
		}
		
		override public function update():void
		{				
			if(this.x < -20)
				this.reset(startX,startY);
			
			if(Registry.stage == 1)
			{
				threshold = 1.0;
				bulletVelocity = 200;
			}
			else if(Registry.stage == 2)
			{
				threshold = .8;
				bulletVelocity = 210;
			}
			else if(Registry.stage == 3)
			{
				threshold = .6;
				bulletVelocity = 220;
			}
			else if(Registry.stage == 4)
			{
				threshold = .4;
				bulletVelocity = 230;
			}
			else if(Registry.stage >= 5)
			{
				threshold = .2;
				bulletVelocity = 240;
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