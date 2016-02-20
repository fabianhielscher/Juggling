package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Fabian Hielscher
	 */
	public class Aufgabe extends MovieClip
	{
		
		//var mc_aufgabe:MovieClip; 
		//public static var neueAufgabe:Boolean = true;
		public static var synchron:Boolean = false;
		public var id:int;
		
		
		//public static var aktuelleAufgabe:int = 0;
		//public static var aktuellesZeitintervall:int = 0;
		//public static var go:Boolean = false;
		var wurfButtonArray:Array;
		var abstand:int;
		
		public function Aufgabe(cord_x:int, cord_y:int, level:int, vollversion:Boolean):void
		{
			id = level;
			
			unmark();
			this.x = cord_x;
			this.y = cord_y;
			abstand = 15;
			
			// show aufgabe
			showTask(id);
			
			mc_time.visible = false;
			voll.visible = false;
			
			if (vollversion)
			{
				//hideTimeLeiste();
				this.addEventListener(MouseEvent.CLICK, clicked);
				this.addEventListener(Event.ENTER_FRAME, loop);
				voll.visible = true
				
				voll.txt_level.text = level + 1;
				
			}
			else
			{
				mc_time.visible = true;
				this.addEventListener(Event.ENTER_FRAME, checkChange);
			}
		
		}
		
		private function hideTimeLeiste():void
		{
			
			mc_time.visible = false;
		
		}
		
		private function clicked(e:MouseEvent):void
		{
			Main.aufgabeAktuell = id;
			Main.char.initAufgabenArray();
		
		}
		
		public function mark():void
		{
			markiert.visible = true;
		
		}
		
		public function unmark():void
		{
			markiert.visible = false;
		}
		
		private function loop(e:Event):void
		{
			checkObAktiv();
			var posi:Number = Math.abs(this.x + ShowAufgabe.pos);
			
			if (posi > 150)
			{
				if (posi > 185)
				{
					
					this.visible = false;
				}
				else
				{
					this.visible = true;
					// wert zwischen 150 und 185
					posi -= 150;
					// 0 (alpha 1) - 35 (alpha 0)
					this.alpha = 1 - posi / 35;
				}
			}
			else
			{
				this.visible = true;
				this.alpha = 1;
			}
		}
		
		private function checkObAktiv():void
		{
			if (id == Main.aufgabeAktuell)
			{
				mark();
			}
			else
			{
				unmark();
			}
		}
		
		//private function checkNeueAufgabe(e:Event):void
		//{
		//if (neueAufgabe == true)
		//{
		//neueAufgabe = false;
		//aktuellesZeitintervall = 0;
		//checkSynchron();
		//showAufgabe(0.4, 65, 50, 50);
		//
		//}
		//}
		
		//public function checkSynchron(aktuelleAufgabe:int):Boolean
		//{
		//if (aufgabe[aktuelleAufgabe][1] == 0 && aufgabe[aktuelleAufgabe][1 + (aufgabe[aktuelleAufgabe].length) / 2] == 0)
		//{
		//return true;
		//}
		//else
		//{
		//return false;
		//}
		//}
		
		//}
		
		// Bälle haben eine durchmesser von 80 und ursprung links unten
		
		//public static function checkZeitintervall():void
		//{
		
		// überprüfe ob noch bälle im zeitintervall befinden, wenn ja verkackt
		
		//if (wurfButtonArray[aktuellesZeitintervall] != null)
		//{
		//
		//if (wurfButtonArray[aktuellesZeitintervall].deleated == false)
		//{
		//reset();
		//}
		//
		//}
		//if (wurfButtonArray[aktuellesZeitintervall + (aufgabe[aktuelleAufgabe].length / 2)] != null)
		//{
		//
		//if (wurfButtonArray[aktuellesZeitintervall + (aufgabe[aktuelleAufgabe].length / 2)].deleated == false)
		//{
		//reset();
		//}
		//
		//}
		//if (aktuellesZeitintervall == (aufgabe[aktuelleAufgabe].length / 2) - 1)
		//{
		
		//aktuelleAufgabe++;
		//reset();
		//}
		//
		//}
		
		//public static function checkWurf(hand:int, wurfzahl:int, handLinksNormal:Boolean, handRechtsNormal:Boolean):void
		//{
		//
		// setze den eigenen ball
		//
		// linke Hand
		//if (hand == 0 && wurfzahl == aufgabe[aktuelleAufgabe][aktuellesZeitintervall] && wurfButtonArray[aktuellesZeitintervall].currentFrame < 100 && handLinksNormal == synchronArray[aktuelleAufgabe][aktuellesZeitintervall])
		//{
		//go = true;
		//wurfButtonArray[aktuellesZeitintervall].deleate();
		//
		//}
		//
		// rechte Hand
		//
		//else if (hand == 1 && wurfzahl == aufgabe[aktuelleAufgabe][aktuellesZeitintervall + (aufgabe[aktuelleAufgabe].length / 2)] && wurfButtonArray[aktuellesZeitintervall + (aufgabe[aktuelleAufgabe].length / 2)].currentFrame < 100 && handRechtsNormal == synchronArray[aktuelleAufgabe][aktuellesZeitintervall + (aufgabe[aktuelleAufgabe].length / 2)])
		//{
		//
		//go = true;
		//wurfButtonArray[aktuellesZeitintervall + (aufgabe[aktuelleAufgabe].length / 2)].deleate();
		//}
		//else
		//{
		//if (go == true)
		//{
		//reset();
		//}
		//}
		//
		//}
		
		//static public function reset():void
		//{
		//
		//Player.frame = -1;
		//go = false;
		//aktuellesZeitintervall = 0;
		//
		//for (var i:int = 0; i < aufgabe[aktuelleAufgabe].length; i++)
		//{
		//if (wurfButtonArray[i] != null)
		//{
		//if (wurfButtonArray[i].currentFrame < 100)
		//{
		// spielt die deleate animation ab
		//wurfButtonArray[i].deleate();
		//
		//}
		//}
		//
		//}
		//
		//}
		
		private function showTask(level:int):void
		{
			
			wurfButtonArray = new Array();
			
			for (var i:int = 0; i < Main.aufgabe[level].length; i++)
			{
				// wenn ein ball nach aufgabe existiert
				if (Main.aufgabe[level][i][0] != 0)
				{
					
					var versatz:int = 0;
					if (Main.aufgabe[level][i][1] != null)
					{
						
						versatz = -5;
					}
					
					
					fuegeButtonEin(Main.aufgabe[level][i][0],i,wurfButtonArray.length,level,versatz);
					
					if (Main.aufgabe[level][i][1] != null)
					{
						fuegeButtonEin(Main.aufgabe[level][i][1],i,wurfButtonArray.length,level,-versatz);
						
					}
					
				}
				
			}
		}
		
		public function fuegeButtonEin(wurfzahl:int,intervall:int,arrayLaenge:int,level:int,versatz:int):void
		{
			trace("füge btuunon ein mit versatz  "+versatz);
			wurfButtonArray[arrayLaenge] = new WurfButton();
			addChild(wurfButtonArray[arrayLaenge]);
			wurfButtonArray[arrayLaenge].setX(versatz);
			
			wurfButtonArray[arrayLaenge].init(wurfzahl);
			// wenn nach aufgabenstellung die handposi falschrum ist switche das aussehen vom Button
			if (Main.synchronArray[level][wurfzahl] == false)
			{
				
				wurfButtonArray[arrayLaenge].switchPosi();
			}
			
			// wenn ein ball mit links geworfen wird
			if (intervall < (Main.aufgabe[level].length / 2))
			{
				
				wurfButtonArray[arrayLaenge].y = abstand * intervall;
				wurfButtonArray[arrayLaenge].x += -12.5;
				
			}
			else
				// wenn ein ball mit rechts geworfen wird
			{
	
				wurfButtonArray[arrayLaenge].y = abstand * (intervall - (Main.aufgabe[level].length / 2));
				wurfButtonArray[arrayLaenge].x += 12.5;
			}
			
			wurfButtonArray[arrayLaenge].scaleX = 0.2;
			wurfButtonArray[arrayLaenge].scaleY = 0.2;
		}
		
		private function checkChange(e:Event):void
		{
			if (Main.aufgabeAktuell != id)
			{
				
				remove();
				id = Main.aufgabeAktuell;
				showTask(id);
			}
		}
		
		private function remove():void
		{
			
			for (var i:int = 0; i < wurfButtonArray.length; i++)
			{
				if (wurfButtonArray[i] != 0)
				{
					
					removeChild(wurfButtonArray[i]);
					
				}
				
			}
			
		}
	}
}