package
{
	import org.flixel.*;
	
	[SWF(width="768", height="768", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
		
	public class RailGunner extends FlxGame
	{
		public function RailGunner()
		{
			super(384,384,AttractPlayState,2,60,60);
			//forceDebugger = true;
			//FlxG.visualDebug = true;
			//FlxG.debug = true;
		}
	}
}