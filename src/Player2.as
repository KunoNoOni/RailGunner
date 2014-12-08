package
{
	import org.flixel.*;
	//import org.flixel.plugin.photonstorm.FlxDelay;
			
	public class Player2 extends FlxSprite
	{
		
		public function Player2(X:Number=0,Y:Number=0)
		{
			super(X,Y);
			loadGraphic(Registry.playerShip,false,false,16,16);
		}
		
		override public function update():void
		{				
			super.update();
		}
	}
}