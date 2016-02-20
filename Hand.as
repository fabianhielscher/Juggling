package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Fabian Hielscher
	 */
	public class Hand extends MovieClip
	{
		
		public var Links:Boolean;
		public var Rechts:Boolean;
		public var normal:Boolean;
		
		public var fangBall:int;
		
		public var werfe_x:Number;
		public var fange_x:Number;
		public var radius:Number;
		public var abstand:Number;
		
		// Zeit bis Hand fängt, je größter, desto früher fängt Hand
		public var fangzeit:Number;
		
		// Geschwindigkeit
		public var vx:Number = 0;
		public var vy:Number = 0;
		// Beschleunigung
		public var ax:Number = 0;
		public var ay:Number = 0;
		
		public var beschleunigung_x:Number;
		public var beschleunigung_y:Number;
		public var daempfung_x:Number;
		public var daempfung_y:Number;
		public var vx_max:Number;
		public var vy_max:Number;
		
		public function Hand(p:int, h:Number, r:Number, f:Number, a1:Number, a2:Number, d1:Number, d2:Number, v1:Number, v2:Number):void
		{
			// p=Player, h=handabstand, r=radius, f=fangzeit a=handbeschleunigung, d=handdämpfung, v=max handgeschwindigkeit
			
			vx_max = v1;
			vy_max = v2;
			
			normal = true;
			this.gotoAndStop(p);
			werfe_x = h - r;
			fange_x = h + r;
			this.x = werfe_x;
			
			// wann gefangen wird
			fangzeit = Player.zeitIntervall;
			beschleunigung_x = a1;
			beschleunigung_y = a2;
			daempfung_x = d1;
			daempfung_y = d2;
			radius = r;
			abstand = h;
		
	
		}
		
		public function wechsel():void
		{
			
			var n:Number = werfe_x;
			werfe_x = fange_x;
			fange_x = n;
			
			if (normal == true)
			{
				normal = false;
			}
			else
			{
				normal = true;
			}
		
		}
		
		public function move(array:Array):void
		{
			
			// Array ist LuftBallArray
			// check welcher ball zu fangen ist, und ob hand berührt
			
			fangBall = getFangball(array);
			
			if (fangBall >= 0)
			{
				
				ax = -this.x + array[fangBall].x_end;
				ay = -this.y;
				
			}
			else
			{
				
				// gehe zu wurfposition
				ax = -this.x + werfe_x;
				ay = -this.y;
				
					//ax *= 4;
				
			}
			
			// Handposition
			vx += beschleunigung_x * 0.04 * ax;
			vy += beschleunigung_y * 0.04 * ay;
			
			if (vx > vx_max)
			{
				vx = vx_max;
			}
			else if (vx < -(vx_max))
			{
				vx = -vx_max;
			}
			
			if (vy > vy_max)
			{
				vy = vy_max;
			}
			else if (vy < -(vy_max))
			{
				vy = -vy_max;
			}
			
			vy *= daempfung_y;
			vx *= daempfung_x;
			
			this.x += vx*Main.frameDropMultiplikator;
			this.y += vy*Main.frameDropMultiplikator;
			
			//while (Math.sqrt((this.x - abstand) * (this.x - abstand) + (this.y) * (this.y)) >= Math.abs(radius))
			//{
				//
				//this.x -= abstand;
				//this.x *= 0.99;
				//this.x += abstand;
				//this.y *= 0.99;
				//
				//vx *= 0.99;
				//vy *= 0.99;
				//
			//}
			
			// nach außen begrenzen
			if (Math.abs(this.x) > 1.0 * (Math.abs(abstand + radius)))
			{
				this.x = 1.0 * (abstand + radius);
				
			}
			
			// nach innen begrenzen
			if (Math.abs(this.x) < (Math.abs(abstand) - Math.abs(radius)) / 1.0)
			{
				this.x = (abstand - radius) / 1.0;
				
			}
		
			//while (Math.sqrt((this.x - abstand) * (this.x - abstand) + (this.y) * (this.y)) >= Math.abs(radius))
			//{
			//
			//this.x -= abstand;
			//this.x *= 0.99;
			//this.x += abstand;
			//this.y *= 0.99;
			//
			//vx *= 0.99;
			//vy *= 0.99;
			//
			//}
		
		}
		
		public function getFangball(array:Array):int
		{
			// wenn es keinen ball zum fangen gibt dann -1
			
			var myFangBall = -1;
			if (array.length > 0)
			{
				
				var record_zeit:Number = 1000;
				var zeit_bis_fangen:Number;
				for (var i:int = 0; i < array.length; i++)
				{
					
					zeit_bis_fangen = array[i].zeit_bis_fangen;
					
					
	
					trace("array[i].zeit_end "+ array[i].zeit_end);
					trace("array[i].zeit "+ array[i].zeit);
					trace("zeit_bis_fangen "+ zeit_bis_fangen);
					
					if (zeit_bis_fangen >= 0 && (zeit_bis_fangen <= (Player.zeitIntervall)) && (zeit_bis_fangen < record_zeit) && Rechts == true && (array[i].rechtsWirdFangen == true && Rechts == true))
					{

						myFangBall = i;
						record_zeit = zeit_bis_fangen;
					}
					else if (zeit_bis_fangen >= 0 && (zeit_bis_fangen <= (Player.zeitIntervall)) && (zeit_bis_fangen < record_zeit) && Links == true && (array[i].rechtsWirdFangen == false && Links == true))
					{
						myFangBall = i;
						record_zeit = zeit_bis_fangen;
					}
				}
				
			}
			return myFangBall;
		
		}
	
	/*public function abstand(x1:Number, x2:Number, y1:Number, y2:Number):Number
	   {
	   var n:Number = Math.sqrt(Math.pow((x1 - x2), 2) + Math.pow((y1 - y2), 2));
	   return n;
	 }*/
	
	}
}