package
{
	
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.*;
	import flash.ui.MultitouchInputMode;
	import flash.ui.Multitouch;
	import flash.system.Capabilities;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	
	/**
	 * ...
	 * @author Fabian Hielscher
	 */
	public class Main extends MovieClip
	{
		public static var ShowMe:Boolean = false;
		public static var synchronArray:Array = new Array();
		public static var aufgabe:Array = new Array();
		public static var aufgabeBallAnzahl:Array = new Array();
		public static var aufgabeGeschafft:Array = new Array();
		public static var tricksInsgesamt:Array = new Array();
		public static var tricksInFolge:Array = new Array();
		public static var aufgabeAktuell:int;
		public static var aktiveAufgabe:Aufgabe;
		public static var augeLinks:Auge;
		public static var augeRechts:Auge;
		
		public static var dpi:Number;
		public static var breite:Number;
		public static var hoehe:Number;
		
		public static var frameDropMultiplikator:Number = 1;
		public static var fps:Number = 30;
		
		public static var char:Player;
		
		public static var buttons:ButtonLeiste = new ButtonLeiste();
		public static var multi_l:Array = new Array();
		public static var multi_r:Array = new Array();
		
		// Upgrades
		public static var up_multiplex:int = 4; // 1 - 3
		public static var up_accuracy:Number = 8; // 0 - 10
		
		//public static var aufgabe:Aufgabe;
		
		public function Main():void
		{
			
			//stage.quality = "LOW";
			
			//SWFProfiler.init(stage, this);
			//SWFProfiler.start;
			trace("Capabilities.screenResolutionX = " + Capabilities.screenResolutionX);
			trace("Capabilities.screenResolutionY = " + Capabilities.screenResolutionY);
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			//stage.displayState = StageDisplayState.FULL_SCREEN; 
			breite = stage.stageWidth;
			hoehe = stage.stageHeight;

			trace("stage.stageWidth = " + stage.stageWidth);
			trace("stage.stageHeight = " + stage.stageHeight);
			trace("stage.fullScreenHeight = " + stage.fullScreenHeight);
			trace("stage.fullScreenWidth = " + stage.fullScreenWidth);
			//breite = 480;
			//hoehe = 800;
			//dpi = Capabilities.screenDPI;
			//stage.scaleMode = StageScaleMode.NO_SCALE;
		
			
			
			//breite = Capabilities.screenResolutionX;
			//hoehe = Capabilities.screenResolutionY;
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			loadData();
			
			stop();
			menu();
		
		}
		
		public function loadData():void
		{
			Player.player = 1;
			Player.wurfObjekt = 1;
			Player.ballAnzahl = 5;
			
			initAufgaben();
			aufgabeAktuell = 0;
		
		}
		
		private function menu():void
		{
			//gotoAndStop("spiel");
			gotoAndStop(20);
			start_game();
			var fpsDemo:FPSDemo = new FPSDemo();
			addChild(fpsDemo);
			fpsDemo.y += 400;
		
			// Menü Event Listener
			//btn_start_game.addEventListener(TouchEvent.TOUCH_TAP, btn_start_game_click);
		}
		
		private function btn_start_game_click(e:TouchEvent):void
		{
			// lösche Event Listener
			//btn_start_game.removeEventListener(TouchEvent.TOUCH_TAP, btn_start_game_click);
			
			gotoAndStop("spiel");
			
			// starte Spiel
			start_game();
		}
		
		private function start_game():void
		{
			
			// Buttons einfügen
			btn_einfügen();
			player_einfügen(Player.player, Player.wurfObjekt);
			
			aufgabe_einfuegen();
		}
		
		private function aufgabe_einfuegen():void
		{
			aktiveAufgabe = new Aufgabe(50, 100, aufgabeAktuell, false);
			
			addChild(aktiveAufgabe);
			char.resetAufgabe();
		
		}
		
		private function btn_einfügen():void
		{
			
			buttons = new ButtonLeiste();
			addChild(buttons);
			
			buttons.x = 0;
			buttons.y = 0;
			
			//trace(stage.stageWidth+"  "+buttons.width+"  "+stage.width+"  "+stage.fullScreenWidth+ "  "+dpi);
			//buttons.scaleX = breite / 480;
			//buttons.scaleY = hoehe / 800;
		}
		
		public function button1rlHandler(e:TouchEvent):void
		{
			char.werfe(1, 1);
		}
		
		public function button1lrHandler(e:TouchEvent):void
		{
			char.werfe(0, 1);
		}
		
		public function button2rlHandler(e:TouchEvent):void
		{
			char.werfe(1, 2);
		}
		
		public function button2lrHandler(e:TouchEvent):void
		{
			char.werfe(0, 2);
		}
		
		public function button3rlHandler(e:TouchEvent):void
		{
			char.werfe(1, 3);
		}
		
		public function button3lrHandler(e:TouchEvent):void
		{
			char.werfe(0, 3);
		}
		
		private function button4rrHandler(e:TouchEvent):void
		{
			char.werfe(1, 4);
		}
		
		private function button4llHandler(e:TouchEvent):void
		{
			char.werfe(0, 4);
		}
		
		private function button5rlHandler(e:TouchEvent):void
		{
			char.werfe(1, 5);
		}
		
		private function button5lrHandler(e:TouchEvent):void
		{
			char.werfe(0, 5);
		}
		
		private function button6rrHandler(e:TouchEvent):void
		{
			char.werfe(1, 6);
		}
		
		private function button6llHandler(e:TouchEvent):void
		{
			char.werfe(0, 6);
		}
		
		public function player_einfügen(player_number:int, wurfObjekt:int):void
		{
			
			
			
			augeLinks = new Auge();
			augeRechts = new Auge();
			char = new Player(player_number, wurfObjekt);
			stage.addChild(char);
			
			stage.addChild(augeLinks);
			stage.addChild(augeRechts);
			char.addEventListener(MouseEvent.MOUSE_DOWN, charKlick);
			
			char.x = breite / 2;
			char.y = hoehe * 0.6;
		
			//char.scaleY = 0.5;
			//char.scaleX = breite / 480;
			//char.scaleY = hoehe / 800;
		
		}
		
		private function charKlick(e:MouseEvent):void
		{
			//if (Player.player == 1)
			//{
			//char.init(2, 1);
			//}
			//else
			//{
			//char.init(1, 1);
			//}
		}
		
		public function player_löschen():void
		{
			stage.removeChild(char);
		
		}
		
		public function initAufgaben():void
		{
			
			// linke hälfte links, rechte hälfte rechts
			aufgabe[0] = [3, 0, 3, 0, 3, 0, 0, 3, 0, 3, 0, 3];
			aufgabeGeschafft[0] = 0;
			aufgabeBallAnzahl[0] = 3;
			
			aufgabe[1] = [[3,2], 0, [3,4], 0, [3,2], 0, [3,4], 0, 0, [3,2], 0, [3,4], 0, [3,2], 0,[3,4]];
			aufgabeGeschafft[0] = 0;
			aufgabeBallAnzahl[1] = 6;
				
			aufgabe[2] = [4, 0, 4, 0, 4, 0, 4, 0, 4, 0, 4, 0, 4, 0, 4, 0];
			aufgabeGeschafft[0] = 0;
			aufgabeBallAnzahl[2] = 4;

			aufgabe[3] = [4, 0, 4, 0, 4, 0, 4, 0, 0, 4, 0, 4, 0, 4, 0, 4];
			aufgabeGeschafft[0] = 0;
			aufgabeBallAnzahl[3] = 4;

			aufgabe[4] = [5, 0, 3, 0, 1, 0, 5, 0, 3, 0, 1, 0, 5, 0, 3, 0, 1, 0];
			aufgabeGeschafft[0] = 0;
			aufgabeBallAnzahl[4] = 3;

			aufgabe[5] = [[5,3],0,[5,3],0,0,[4,3],0,[4,3]];
			aufgabeGeschafft[0] = 0;
			aufgabeBallAnzahl[5] = 3;

			aufgabe[6] = [[3,4],0 ,[3,4] ,0 ,0 ,[3,4],0,[3,4] ];
			aufgabeGeschafft[0] = 0;
			aufgabeBallAnzahl[6] = 3;

			aufgabe[7] = [3, 0, 5,0,[3,5],0,0,5,0,3,0,[3,5] ];
			aufgabeGeschafft[0] = 0;
			aufgabeBallAnzahl[7] = 3;

			aufgabe[8] = [4, 0, 3, 0, 3, 0, 4, 0];
			aufgabeGeschafft[0] = 0;
			aufgabeBallAnzahl[8] = 3;
			
			aufgabe[9] = [5, 0, 5, 0,5,0,5,0 ,0, 5, 0, 5,0,5,0,5];
			aufgabeGeschafft[0] = 0;
			aufgabeBallAnzahl[9] = 3;

			aufgabe[10] = [6, 0, 6, 0, 6, 0,6,0, 0, 6, 0, 6, 0, 6,0,6];
			aufgabeGeschafft[0] = 0;
			aufgabeBallAnzahl[10] = 3;

			aufgabe[11] = [[6, 4], 0, [6, 4], 0, [6, 4], 0, 0, [6, 4], 0, [6, 4], 0, [6, 4]];
			aufgabeGeschafft[0] = 0;
			aufgabeBallAnzahl[11] = 3;

			aufgabe[12] = [[2, 4], 0, [2, 4], 0, [2, 4], 0, 0, [2, 4], 0, [2, 4], 0, [2, 4]];
			aufgabeGeschafft[0] = 0;
			aufgabeBallAnzahl[12] = 3;

			
			// standardmäßig ist ist jede aufgabe in normalposition
			
			var anzahlDerAufgaben:int = aufgabe.length;
			for (var i:int = 0; i < anzahlDerAufgaben; i++)
			{
				var anzahlDerWuerfe:int = aufgabe[i].length;
				synchronArray[i] = [];
				for (var j:int = 0; j < anzahlDerWuerfe; j++)
				{
					synchronArray[i].push(true);
				}
				
			}
			// ausnahmen also würfe in nicht standardposi
			synchronArray[1] = [false, 0, false, 0, false, 0, false, 0, 0, false, 0, false, 0, false, 0, false];
			synchronArray[2] = [true, 0, true, 0, true, 0, true, 0, false, 0, false, 0, false, 0, false, 0];
			
			machAusJedemWurfEinArray();
			
			//tricksInFolge
		}
		
		private function machAusJedemWurfEinArray():void
		{
			var a:Array;
			
			for (var i:int = 0; i < aufgabe.length; i++)
			{
				
				for (var j:int = 0; j < aufgabe[i].length; j++)
				{
					if (aufgabe[i][j] is Array)
					{
						aufgabe[i][j].sort();
					}
					else
					{
						a = new Array();
						a.push(aufgabe[i][j]);
						aufgabe[i][j]=a;
					}
				}
				
			}
		
		}
	
	}

}