package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
		
	public class Bullet extends FlxSprite
	{
		//public static var damage:int = 5;
		
		public function Bullet(X:Number=0,Y:Number=0)
		{
			super(X,Y);
			loadGraphic(Registry.bullet,false,false,4,4);
		}
		 
		override public function update():void
		{	
			/*if(this.y < -10)
				this.kill();*/
			
			super.update();
		}
	}
}