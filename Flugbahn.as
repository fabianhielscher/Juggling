package
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Fabian Hielscher
	 */
	public class Flugbahn extends Sprite
	{
		private var zeitIntervall:Number;
		//public var pos_y:Number;
		//public var pos_x:Number;
		//public var strecke_x:Number;
		//public var zeit:Number;
		//public var vy:Number;
		//public var vx;
		public var punkt:Shape;
		public var alleFlugdaten:Array;
		public var zaehler:int;
		
		public function Flugbahn(z:Number)
		{
			zaehler = 0;
			zeitIntervall = z;
			
			alleFlugdaten = new Array();

		}
		
		public function showFlugKoords():void
		{
			punkt = new Shape();
			addChild(punkt);
			punkt.graphics.beginFill(0xFFFFFF);
			
			//punkt.graphics.lineStyle(6, 0xDDDDFF);
			trace(alleFlugdaten);
			this.addEventListener(Event.ENTER_FRAME, show);
		}
		
		public function berechneFlugKoords(start_x:Number, end_x:Number, w:int):void
		{
			// generiere flugdaten
			
			var Koords:Array = new Array();

			var pos_y:int = 0;
			var pos_x:Number = start_x;
			var strecke_x:Number = end_x - start_x;
			var zeit:Number = (w * zeitIntervall - zeitIntervall)
			
			if (zeit <= 0)
			{
				zeit = zeitIntervall / 2;
			}
			
			var vy:Number = zeit * (-1) * Ball.g / 2;
			var vx:Number = strecke_x / zeit;
			
			
			if (zeit <= 0)
			{
				zeit = zeitIntervall / 2;
			}
			
			var z:int = 1;
			while (z <= zeit)
			{
				
				pos_x += vx;
				pos_y += vy;
				
				vy += Ball.g;
				Koords.push(new Point(int(pos_x), pos_y));
				z++;
				
			}
			
			alleFlugdaten.push(Koords);
		
		}
		
		private function show(e:Event):void
		{
			if (alleFlugdaten.length > 0)
			{
				for (var i:int = 0; i < alleFlugdaten.length; i++)
				{
					//trace("show  "+zaehler);
					
					//if (alleFlugdaten[i].length > 0)
					if (alleFlugdaten[i].length > 0)
					{
						punkt.graphics.drawCircle(alleFlugdaten[i][0].x, alleFlugdaten[i][0].y, 1+2 * zaehler / (zeitIntervall));
						alleFlugdaten[i].splice(0, 1);
					}
					if (alleFlugdaten[i].length > 0)
					{
						punkt.graphics.drawCircle(alleFlugdaten[i][0].x, alleFlugdaten[i][0].y, 1+2 * zaehler / (zeitIntervall));
						alleFlugdaten[i].splice(0, 1);
					}
					if (alleFlugdaten[i].length > 0)
					{
						punkt.graphics.drawCircle(alleFlugdaten[i][0].x, alleFlugdaten[i][0].y, 1+2 * zaehler / (zeitIntervall));
						alleFlugdaten[i].splice(0, 1);
					}
				}
				
				zaehler++;
			}
			else
			{
				zaehler = 0;
				this.removeEventListener(Event.ENTER_FRAME, show);
			}
		}
	
	}

}