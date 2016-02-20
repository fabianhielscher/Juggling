package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Fabian Hielscher
	 */
	public class Ball extends Sprite
	{
		public var rechtsWirdFangen:Boolean;
		public var wurfzahl:int;
		public var animationStart:int;
		public var animationEnde:int;
		public var multiLoop:int = 1;
		
		public static var up_keulenwurf:int = 1;
		public static var up_born_time:Number = 20; // wieviele frames bis ball erscheint
		
		public var born_time:Number;
		public var zeit:Number;
		public var zeit_end:Number;
		public var x_end:Number;
		
		public var nach_rechts:Boolean;
		public var ball_x:int;
		public var ball_y:int;
		public var vx:Number;
		public var vy:Number;
		public static var e:Number = 1; // Stoßzahl
		public static var g:Number;
		public var tot:Boolean;
		
		public var ball_in_hand:Boolean;
		public var screenData:BitmapData;
		public var screen:Bitmap;
		
		
		public var flip:Boolean;
		public var ballVariation:Number = 0;
		//public var keule:MovieClip;
		
		public function Ball(ball_x:int, ball_y:int):void
		{
	
			
			
			this.x = ball_x;
			this.y = ball_y;
			vx = 0;
			vy = 0;
			
			addEventListener(Event.ADDED_TO_STAGE, activation);
			//if (vx == 0)
			//{
			//zeit_end = Math.sqrt(2 * Player.ballSpawnHight / g);
			//}
		
		}
		
		private function activation(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, activation);
			born_time = 0;
			
			
			init();
			initSprite();
			
			
			tot = false;
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		public function init():void
		{
			ball_in_hand = true;
			zeit = 0;
			flip = false;
			
		}
		
		public function berechneFangzeit():void
		{
			zeit = 0;
			zeit_end = -2 * vy / g;
			
			x_end = this.x + zeit_end * vx;
		}
		
		private function initSprite():void
		{
			screenData = new BitmapData(256, 256, true, 0xFF0000);
			screen = new Bitmap(screenData);
			
			// bitmap zentrieren
			screen.x -= 128;
			screen.y -= 128;
			
			addChild(screen);
			
			
		
		}
		
		public function setSprite():void
		{
			
			var frame:int;
			
			if (ball_in_hand)
			{
				
				// Ball in der Hand
				
				var handWert:Number;
				if (this.x > 0)
				{
					handWert = (this.x - Main.char.handAbstand) / Main.char.handRadius; // wert zwischen 0 (ball inder mitte) und 1 (ball außen) alles ind der hand
				}
				else
				{
					handWert = (this.x + Main.char.handAbstand) / Main.char.handRadius;
				}
				
				// variation in der handhaltung
				handWert = handWert + ballVariation * (0.5-handWert)
				
				
				frame = int(30 - 30 * handWert);
				if (frame < 1)
				{
					frame = 0;
					
				}
			}
			else
			{
				
				// Ball in der Luft
				if (zeit < zeit_end)
				{
					frame = animationStart + (animationEnde - animationStart) * (((multiLoop * zeit) % zeit_end) / zeit_end);
				}
				else
				{
					frame = 60 + 60 * zeit / zeit_end;
				}
				
			}
			
			var spalte:int = 2;
			var zeile:int = 2;
			while (frame >= 31) // bilder für eine Zeile
			{
				zeile += 258;
				frame -= 31;
				
			}
			while (frame > 0)
			{
				spalte += 258;
				frame--;
			}
			
			screenData.copyPixels(Player.ballSprite, new Rectangle(spalte, zeile, 256, 256), new Point(0, 0)); // rect(0,0,512,512) (512,0,512,512
			
			if (flip)
			{
				
				var flipped:BitmapData = new BitmapData(screen.bitmapData.width, screen.bitmapData.height, true, 0);
				var matrix:Matrix;
				
				matrix = new Matrix(-1, 0, 0, 1, screen.bitmapData.width, 0);
				
				flipped.draw(screen.bitmapData, matrix, null, null, null, true);
				screenData.copyPixels(flipped, new Rectangle(2, 2, 256, 256), new Point(0, 0));	
			}
		
		}
		
		public function flipBitmapData():void
		{
			flip = true;
		}
		
		public function einblenden():void
		{
			this.alpha = 0;
			addEventListener(Event.ENTER_FRAME, born);
		}
		
		public function fallen():Boolean
		{
			if (vy >= 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public function setSpeed(set_vx:Number, set_vy:Number):void
		{
			vx = set_vx;
			vy = set_vy;
		}
		
		public function deleate():void
		{
			removeEventListener(Event.ENTER_FRAME, loop);
			removeChild(screen);
			parent.removeChild(this);
		}
		
		private function born(e:Event):void
		{
			
			if (born_time <= up_born_time)
			{
				this.alpha = born_time / up_born_time;
				born_time++;
			}
			else
			{
				this.alpha = 1;
				removeEventListener(Event.ENTER_FRAME, born);
			}
		
		}
		
		public function loop(e:Event):void
		{
			
			if (ball_in_hand)
			{
				
			}
			else
			{
				this.y += vy;
				this.x += vx;
				vy += g;
				
				zeit++;
				
			}
			setSprite();
		}
		
		private function berechne_wurfzahl():int
		{
			var zahl:int = 0;
			if (zeit_end + (up_keulenwurf * zeit_end) < 20 || wurfzahl == 1)
			{
				zahl = 0;
				
			}
			else if (zeit_end + (up_keulenwurf * zeit_end) < 80)
			{
				zahl = 1;
				
			}
			else if (zeit_end + (up_keulenwurf * zeit_end) < 140)
			{
				zahl = 2;
				
			}
			else if (zeit_end + (up_keulenwurf * zeit_end) < 200)
			{
				zahl = 3;
				
			}
			else if (zeit_end + (up_keulenwurf * zeit_end) <= 264)
			{
				zahl = 4;
				
			}
			else if (zeit_end + (up_keulenwurf * zeit_end) > 264)
			{
				zahl = 5;
				
			}
			
			return zahl;
		
		}
	}
}