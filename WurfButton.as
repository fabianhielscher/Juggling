package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TouchEvent;
	
	/**
	 * ...
	 * @author Fabian Hielscher
	 */
	public class WurfButton extends MovieClip
	{
		public var buttonZahl:int;
		public var deleated:Boolean;
		public var klick:Klick;
		
		public var posi:MovieClip;
		public var alphaInkrement:Number;
		public var alphaEnde:Number;
		
		public function WurfButton():void
		{
			deleated = false;
			this.posi.gotoAndStop(1);
		
		}
		
		public function setX(versatz:int):void
		{
			
			this.x += versatz;
			

		}
		
		public function blinke(alphaStart:Number, alphaEnd:Number, inkrement:Number):void
		{
			
			this.alpha = alphaStart;
			alphaEnde = alphaEnd;
			alphaInkrement = inkrement;
			
			this.addEventListener(Event.ENTER_FRAME, blinkeAus);
		}
		
		private function blinkeAus(e:Event):void
		{
			this.alpha += alphaInkrement;
			if (alphaInkrement > 0)
			{
				if (this.alpha > alphaEnde)
				{
					this.removeEventListener(Event.ENTER_FRAME, blinkeAus);
				}
			}
			else
			{
				if (this.alpha < alphaEnde)
				{
					this.removeEventListener(Event.ENTER_FRAME, blinkeAus);
				}
			}
		
		}
		
		public function getPosi():Boolean
		{
			if (this.posi.currentFrame == 1)
			{
				return true;
					//normale handposition
			}
			else
			{
				return false;
			}
		}
		
		public function switchPosi():void
		{
			//trace(this.posi.currentFrame + " Frame");
			//trace("SWITSCH POSI");
			if (this.posi.currentFrame == 1)
			{
				this.posi.gotoAndStop(2);
				
			}
			else
			{
				this.posi.gotoAndStop(1);
			}
		}
		
		public function clicked():void
		{
			if (this.y > 400)
			{
				blinke(0.4, 0.4, 0);
			}
			else
			{
				blinke(0.1, 0.5, 0.1);
			}
		}
		
		public function unclicked():void
		{
			
			if (this.y > 400)
			{
				blinke(1, 1, 0);
			}
			else
			{
				blinke(1, 0.1, -0.05);
			}
		}
		
		public function init(wurfzahl:int):void
		{
			trace("init " + wurfzahl)
			buttonZahl = wurfzahl;
			gotoAndStop(buttonZahl + 1);
			trace("botton ist bei y: "+this.y)
		}
		
		public function deleate():void
		{
			deleated = true;
			gotoAndPlay(buttonZahl * 10 + 100);
		
		}
	}

}