package
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Fabian Hielscher
	 */
	public class Auge extends MovieClip
	{
		var vx:Number = 0;
		var vy:Number = 0;
		var ax:Number = 0;
		var ay:Number = 0;
		
		public var home_x:Number;
		public var home_y:Number;
		public var ziel_x:Number;
		public var ziel_y:Number;
		
		public var augenPunkt:Shape;
		
		public function Auge()
		{
			augenPunkt = new Shape();
			
			augenPunkt.graphics.beginFill(0x00000, 1);
			
			augenPunkt.graphics.drawCircle(0, 0, 3);
			//augenPunkt.x -= 5;
			//augenPunkt.y -= 5;
			augenPunkt.graphics.endFill();
			this.addChild(augenPunkt);
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function hoechster_ball():Object
		{
			
			var k:int = 0;
			
			// welcher ball am höchsten
			for (var i:int = 0; i < Player.BallLuftArray.length; i++)
			{
				if (Player.BallLuftArray[i].y <= Player.BallLuftArray[k].y)
				{
					k = i;
				}
				
			}
			return Player.BallLuftArray[k];
		}
		
		private function loop(e:Event):void
		{
			if (Player.BallLuftArray.length == 0)
			{
				// Auf Hand gucken
				if (augenPunkt.x > 0)
				{
					ax = 0.05 * (Main.char.HandRechts.x - (this.x - Main.breite / 2));
					ay = 0.08 * (Main.char.HandRechts.y - (this.y - Player.augenY - 100));
				}
				else
				{
					ax = 0.05 * (Main.char.HandLinks.x - (this.x - Main.breite / 2));
					ay = 0.08 * (Main.char.HandLinks.y - (this.y - Player.augenY - 100));
				}
				
			}
			else
			{
				// Auf Ball gucken
				ax = 0.05 * ((hoechster_ball().x) - (this.x - Main.breite / 2));
				ay = 0.08 * ((hoechster_ball().y) - (this.y - Player.augenY - 150));
			}
			
			vx *= 0.2;
			vy *= 0.2;
			
			vx += ax;
			vy += ay;
			//
			augenPunkt.x = vx;
			augenPunkt.y = vy;
			
			// Augen Punkt innerhalb Radius
			while (Math.sqrt((augenPunkt.x) * (augenPunkt.x) + (augenPunkt.y) * (augenPunkt.y)) >= Player.augenRadius)
			{
				augenPunkt.x *= 0.99;
				augenPunkt.y *= 0.99;
			}
			
			//Augen Punkt innerhalb Auge
			while (augenPunkt.y <= Player.augenBegrenzung)
			{
				augenPunkt.y *= 0.96;
			}
		
		}
	
	}

}