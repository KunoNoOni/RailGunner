package
{
	import org.flixel.*;
	//import org.flixel.plugin.photonstorm.FlxDelay;
			
	public class Player extends FlxSprite
	{
		public var bulletArray:Array;
		private var bulletID:int = 0;
		private var bullet:FlxSprite;
		private var threshold:Number = 0.3;
		private var counter:Number=0;	
		private var tileSize:int=16;
		
		public function Player(X:Number=0,Y:Number=0)
		{
			super(X*16,Y*16);
			loadGraphic(Registry.playerShip,false,false,16,16);
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
			
			
			this.velocity.x = 0;
			this.velocity.y = 0;
			counter += FlxG.elapsed;
			
			if(FlxG.keys.LEFT || FlxG.keys.A)
			{
				this.velocity.x -= 100;
				
			}
			if(FlxG.keys.RIGHT || FlxG.keys.D)
			{
				this.velocity.x += 100;
			}

			
			if(FlxG.mouse.pressed() || FlxG.keys.SPACE)
			{
				if(counter >= threshold)
				{
					counter = 0;
					FlxG.play(Registry.playerShot,0.5);
					bullet = bulletArray[bulletID];
					bullet.reset(this.x+this.width/2-2,this.y-4);
					bullet.velocity.y -= 200;
					bulletID++;
					if(bulletID == 20)
					{
						bulletID = 0;
					}
				}
			}
			
			super.update();
		}
	}
}