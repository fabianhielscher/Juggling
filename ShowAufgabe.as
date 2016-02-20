package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Fabian Hielscher
	 */
	public class ShowAufgabe extends MovieClip
	{
		var zaehler:int = 0;
		var buffer:int = 2; // alle 10 frames eine aufgabe malen
		var trick:Aufgabe;
		public static var ziel_x:Number = 0;
		public static var pos:Number;
		var vx:Number = 0;
		public static var rechts:Boolean = false;
		public static var links:Boolean = false;
		public static var trickArray:Array;
		
		public function ShowAufgabe():void
		{
			trickArray = new Array();
			addEventListener(Event.ENTER_FRAME, maleAufgaben);
			addEventListener(Event.ENTER_FRAME, loop);
		
		}
		
		public function setInfo():void
		{
			
		}
		
		public function rechts_click():void
		{
			
			if ((-375 + (Main.aufgabe.length) * 75) > -ziel_x)
			{
				
				ziel_x -= 375;
			}
		}
		
		public function links_click():void
		{
			if (ziel_x < 0)
			{
				ziel_x += 375;
			}
		
		}
		
		private function loop(e:Event):void
		{
			if (links)
			{
				links = false;
				links_click();
			}
			if (rechts)
			{
				rechts = false;
				rechts_click();
			}
			vx = 0.1 * (ziel_x - this.x);
			this.x += vx;
			pos = this.x;
		}
		
		private function maleAufgaben(e:Event):void
		{
			if (zaehler < buffer*Main.aufgabe.length)
			{
				
				if (zaehler % buffer == 0)
				{
					trick = new Aufgabe(-150 + zaehler * 75/buffer, 0, zaehler/buffer, true);
					addChild(trick);
					trickArray[zaehler] = trick;
				}
				zaehler++;
			}
			else
			{
				removeEventListener(Event.ENTER_FRAME, maleAufgaben);
			}
		
		}
	
	}

}