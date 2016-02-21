package
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Fabian Hielscher
	 */
	public class ButtonLeiste extends MovieClip
	{
		
		public var plex_l:int = 0;
		public var plex_r:int = 0;
		
		public var l0:WurfButton;
		public var l1:WurfButton;
		public var l2:WurfButton;
		public var l3:WurfButton;
		public var l4:WurfButton;
		public var l5:WurfButton;
		public var l6:WurfButton;
		public var r0:WurfButton;
		public var r1:WurfButton;
		public var r2:WurfButton;
		public var r3:WurfButton;
		public var r4:WurfButton;
		public var r5:WurfButton;
		public var r6:WurfButton;
		
		public var letzte_pos_l:Point;
		public var letzte_pos_r:Point;
		
		public function ButtonLeiste()
		{
			//stage = s;
			
			addEventListener(Event.ADDED_TO_STAGE, added);
		
		}
		
		private function added(e:Event):void
		{
			// init buttons
			var abstand:int = 110;
			l0 = new WurfButton();
			l0.x = -180;
			l0.y = 0;
			l0.init(7);
			
			l1 = new WurfButton();
			l1.x = -180 + abstand;
			l1.y = 0;
			l1.init(1);
			
			l2 = new WurfButton();
			l2.x = -180 - abstand;
			l2.y = 0;
			l2.init(2);
			
			l3 = new WurfButton();
			l3.x = -180 + abstand / 2;
			l3.y = -95;
			l3.init(3);
			
			l4 = new WurfButton();
			l4.x = -180 - abstand / 2;
			l4.y = -95;
			l4.init(4);
			
			l5 = new WurfButton();
			l5.x = -180 + abstand / 2;
			l5.y = 95;
			l5.init(5);
			
			l6 = new WurfButton();
			l6.x = -180 - abstand / 2;
			l6.y = 95;
			l6.init(6);
			
			r0 = new WurfButton();
			r0.x = 180;
			r0.y = 0;
			r0.init(7);
			
			r1 = new WurfButton();
			r1.x = 180 - abstand;
			r1.y = 0;
			r1.init(1);
			
			r2 = new WurfButton();
			r2.x = 180 + abstand;
			r2.y = 0;
			r2.init(2);
			
			r3 = new WurfButton();
			r3.x = 180 - abstand / 2;
			r3.y = -95;
			r3.init(3);
			
			r4 = new WurfButton();
			r4.x = 180 + abstand / 2;
			r4.y = -95;
			r4.init(4);
			
			r5 = new WurfButton();
			r5.x = 180 - abstand / 2;
			r5.y = 95;
			r5.init(5);
			
			r6 = new WurfButton();
			r6.x = 180 + abstand / 2;
			r6.y = 95;
			r6.init(6);
			
			l0.x += Main.breite / 2;
			l0.y += Main.hoehe - Main.breite / 4;
			l1.x += Main.breite / 2;
			l1.y += Main.hoehe - Main.breite / 4;
			l2.x += Main.breite / 2;
			l2.y += Main.hoehe - Main.breite / 4;
			l3.x += Main.breite / 2;
			l3.y += Main.hoehe - Main.breite / 4;
			l4.x += Main.breite / 2;
			l4.y += Main.hoehe - Main.breite / 4;
			l5.x += Main.breite / 2;
			l5.y += Main.hoehe - Main.breite / 4;
			l6.x += Main.breite / 2;
			l6.y += Main.hoehe - Main.breite / 4;
			
			r0.x += Main.breite / 2;
			r0.y += Main.hoehe - Main.breite / 4;
			r1.x += Main.breite / 2;
			r1.y += Main.hoehe - Main.breite / 4;
			r2.x += Main.breite / 2;
			r2.y += Main.hoehe - Main.breite / 4;
			r3.x += Main.breite / 2;
			r3.y += Main.hoehe - Main.breite / 4;
			r4.x += Main.breite / 2;
			r4.y += Main.hoehe - Main.breite / 4;
			r5.x += Main.breite / 2;
			r5.y += Main.hoehe - Main.breite / 4;
			r6.x += Main.breite / 2;
			r6.y += Main.hoehe - Main.breite / 4;
			
			this.addChild(l0);
			this.addChild(l1);
			this.addChild(l2);
			this.addChild(l3);
			this.addChild(l4);
			this.addChild(l5);
			this.addChild(l6);
			this.addChild(r0);
			this.addChild(r1);
			this.addChild(r2);
			this.addChild(r3);
			this.addChild(r4);
			this.addChild(r5);
			this.addChild(r6);
			
			//r0.init(7);
			//r1.init(1);
			//r2.init(2);
			//r3.init(3);
			//r4.init(4);
			//r5.init(5);
			//r6.init(6);
			
			removeEventListener(Event.ADDED_TO_STAGE, added);
			
			l0.addEventListener(TouchEvent.TOUCH_BEGIN, begin);
			r0.addEventListener(TouchEvent.TOUCH_BEGIN, begin);
		
		}
		
		public function initButtons(b1:Boolean, b2:Boolean, b3:Boolean, b4:Boolean, b5:Boolean, b6:Boolean):void
		{
			r1.visible = false;
			r2.visible = false;
			r3.visible = false;
			r4.visible = false;
			r5.visible = false;
			r6.visible = false;
			
			l1.visible = false;
			l2.visible = false;
			l3.visible = false;
			l4.visible = false;
			l5.visible = false;
			l6.visible = false;
			
			if (b1 == true)
			{
				l1.visible = true;
				r1.visible = true;
			}
			if (b2 == true)
			{
				l2.visible = true;
				r2.visible = true;
			}
			if (b3 == true)
			{
				l3.visible = true;
				r3.visible = true;
			}
			if (b4 == true)
			{
				l4.visible = true;
				r4.visible = true;
			}
			if (b5 == true)
			{
				l5.visible = true;
				r5.visible = true;
			}
			if (b6 == true)
			{
				l6.visible = true;
				r6.visible = true;
			}
		
		}
		
		private function begin(e:TouchEvent):void
		{
			
			var btn:int = welcher_btn(e.stageX, e.stageY)
			// 800 480
			//if (e.stageX > 240 && e.stageY > 640)
			if (e.stageX > Main.breite / 2 && e.stageY > (Main.hoehe - Main.breite / 2))
			{
				
				letzte_pos_r = new Point(e.stageX, e.stageY);
				
				Main.char.HandRechts.vy += Player.fangGeschwindigkeit;
				r0.clicked();
				
				Player.fangRechts_buttonPress = true;
				Main.char.check_baelle();
				
				root.stage.addEventListener(TouchEvent.TOUCH_END, werfe_r);
				root.stage.addEventListener(TouchEvent.TOUCH_MOVE, move_r);
				
				if (Main.char.BallRechtsArray.length > plex_r && array_frei_r(e.stageX, e.stageY) == true && plex_r < Main.up_multiplex)
				{
					plex_r++;
					Main.multi_r.push(btn);
					markiereButton(e.stageX, e.stageY);
				}
				
				else if (btn == 2)
				{
					Main.multi_r.push(btn);
					markiereButton(e.stageX, e.stageY);
				}
				
			}
			if (e.stageX < Main.breite / 2 && e.stageY > (Main.hoehe - Main.breite / 2))
			{
				
				letzte_pos_l = new Point(e.stageX, e.stageY);
				
				Main.char.HandLinks.vy += Player.fangGeschwindigkeit;
				l0.clicked();
				
				Player.fangLinks_buttonPress = true;
				Main.char.check_baelle();
				
				root.stage.addEventListener(TouchEvent.TOUCH_END, werfe_l);
				root.stage.addEventListener(TouchEvent.TOUCH_MOVE, move_l);
				
				if (Main.char.BallLinksArray.length > plex_l && array_frei_l(e.stageX, e.stageY) == true && plex_l < Main.up_multiplex)
				{
					
					plex_l++;
					Main.multi_l.push(btn);
					markiereButton(e.stageX, e.stageY)
					
				}
				else if (btn == 2)
				{
					Main.multi_l.push(btn);
					markiereButton(e.stageX, e.stageY)
				}
			}
		
		}
		
		public function abstand(x1:int, x2:int, y1:int, y2:int):Number
		{
			return Math.sqrt(Math.pow((x2 - x1), 2) + Math.pow((y2 - y1), 2));
		}
		
		public function welcher_btn(stageX:Number, stageY:Number):int
		{
			var n:int = 0;
			var radius:int = 50;
			
			//if (stageY > 590)
			if (stageY > (Main.hoehe - Main.breite / 2))
			{
				
				if (stageX < Main.breite / 2)
				{
					
					if (abstand(l1.x, stageX, l1.y, stageY) < radius)
					{
						n = 1;
					}
					else if (abstand(l2.x, stageX, l2.y, stageY) < radius)
					{
						n = 2;
					}
					else if (abstand(l3.x, stageX, l3.y, stageY) < radius)
					{
						n = 3;
					}
					else if (abstand(l4.x, stageX, l4.y, stageY) < radius)
					{
						n = 4;
					}
					else if (abstand(l5.x, stageX, l5.y, stageY) < radius)
					{
						n = 5;
					}
					else if (abstand(l6.x, stageX, l6.y, stageY) < radius)
					{
						n = 6;
					}
				}
				else
				{
					if (abstand(r1.x, stageX, r1.y, stageY) < radius)
					{
						n = 1;
					}
					else if (abstand(r2.x, stageX, r2.y, stageY) < radius)
					{
						n = 2;
					}
					else if (abstand(r3.x, stageX, r3.y, stageY) < radius)
					{
						n = 3;
					}
					else if (abstand(r4.x, stageX, r4.y, stageY) < radius)
					{
						n = 4;
					}
					else if (abstand(r5.x, stageX, r5.y, stageY) < radius)
					{
						n = 5;
					}
					else if (abstand(r6.x, stageX, r6.y, stageY) < radius)
					{
						n = 6;
					}
				}
				
			}
			
			return n;
		}
		
		private function move_r(e:TouchEvent):void
		{
			if (e.stageX > Main.breite / 2)
			{
				var btn:int = welcher_btn(e.stageX, e.stageY);
				
				letzte_pos_r.x = e.stageX;
				letzte_pos_r.y = e.stageY;
				
				if ((btn == 2 || Main.char.BallRechtsArray.length > plex_r) && array_frei_r(e.stageX, e.stageY) == true && plex_r < Main.up_multiplex)
				{
					if (this["r" + btn].visible == true)
					{
						plex_r++;
						
						Main.multi_r.push(btn);
						markiereButton(e.stageX, e.stageY);
							//Main.char.vibriere(20);
					}
				}
				
			}
			
			e.updateAfterEvent();
		
		}
		
		private function move_l(e:TouchEvent):void
		{
			if (e.stageX < Main.breite / 2)
			{
				
				var btn:int = welcher_btn(e.stageX, e.stageY);
				
				letzte_pos_l.x = e.stageX;
				letzte_pos_l.y = e.stageY;
				
				if ((btn == 2 || Main.char.BallLinksArray.length > plex_l) && array_frei_l(e.stageX, e.stageY) == true && plex_l < Main.up_multiplex)
				{
					//guck ob der button beim charakter existiert
					if (this["r" + btn].visible == true)
					{
						plex_l++;
						
						Main.multi_l.push(btn);
						markiereButton(e.stageX, e.stageY);
							//Main.char.vibriere(20);
					}
					
				}
				
			}
			
			e.updateAfterEvent();
		}
		
		private function markiereButton(stageX:Number, stageY:Number):void
		{
			if (stageX > Main.breite / 2)
			{
				this["r" + welcher_btn(stageX, stageY)].clicked();
				
			}
			else
			{
				this["l" + welcher_btn(stageX, stageY)].clicked();
				
			}
		}
		
		private function array_frei_l(stageX:Number, stageY:Number):Boolean
		{
			var bool:Boolean = true;
			for (var i:int = 0; i < Main.multi_l.length; i++)
			{
				if (Main.multi_l[i] == welcher_btn(stageX, stageY))
				{
					bool = false;
				}
			}
			
			if (welcher_btn(stageX, stageY) == 0)
			{
				bool = false;
				
			}
			return bool;
		}
		
		private function array_frei_r(stageX:Number, stageY:Number):Boolean
		{
			var bool:Boolean = true;
			for (var i:int = 0; i < Main.multi_r.length; i++)
			{
				if (Main.multi_r[i] == welcher_btn(stageX, stageY))
				{
					bool = false;
					break;
				}
			}
			if (welcher_btn(stageX, stageY) == 0)
			{
				bool = false;
				
			}
			return bool;
		}
		
		public function werfe_r(e:TouchEvent):void
		
		{
			
			if (e.stageX > Main.breite / 2)
			{
				r0.unclicked();
				root.stage.removeEventListener(TouchEvent.TOUCH_END, werfe_r);
				root.stage.removeEventListener(TouchEvent.TOUCH_MOVE, move_r);
				plex_r = 0;
				
				if (Main.multi_r[1] == 2)
				{
					
					Main.multi_r[1] = Main.multi_r[0];
					Main.multi_r[0] = 2;
				}
				
				if (Main.multi_r.length > 0)
				{
					Main.char.checkAufgabenWurf(1, Main.multi_r);
				}
				
				while (Main.multi_r.length > 0)
				{
					this["r" + Main.multi_r[Main.multi_r.length - 1]].unclicked();
					
					Main.char.werfe(1, Main.multi_r[Main.multi_r.length - 1]);
					
					Main.multi_r.pop();
				}
			}
		
		}
		
		public function werfe_l(e:TouchEvent):void
		
		{
			
			if (e.stageX < Main.breite / 2)
			{
				l0.unclicked();
				root.stage.removeEventListener(TouchEvent.TOUCH_END, werfe_l);
				root.stage.removeEventListener(TouchEvent.TOUCH_MOVE, move_l);
				plex_l = 0;
				
				if (Main.multi_l[1] == 2)
				{
					
					Main.multi_l[1] = Main.multi_l[0];
					Main.multi_l[0] = 2;
					
				}
				
				Main.char.checkAufgabenWurf(0, Main.multi_l);
				
				while (Main.multi_l.length > 0)
				{
					
					this["l" + Main.multi_l[Main.multi_l.length - 1]].unclicked();
					
					Main.char.werfe(0, Main.multi_l[Main.multi_l.length - 1]);
					
					Main.multi_l.pop();
				}
			}
		
		}
	
	}

}