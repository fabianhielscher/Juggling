package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import com.adobe.nativeExtensions.Vibration;
	
	/**
	 * ...
	 * @author Fabian Hielscher
	 */
	public class Player extends Sprite
	{
		
		public static var trickCounter:int;
		public static var aktuellerAufgabenArrayLinks:Array;
		public static var aktuellerAufgabenArrayRechts:Array;
		public static var aktuellerPreviewArray:Array;
		public var trickAktiv:Boolean = false;
		public var punkt:Shape;
		public static var fadeAnimationZeit:int = 20;
		public static var frame:int;
		public static var previewStartFrame:int = 30;
		public static var previewFrame:int;
		public static var previewIntervall:int;
		
		public var screenData:BitmapData;
		public var screen:Bitmap;
		
		public static var fangRechts_buttonPress:Boolean = false;
		public static var fangLinks_buttonPress:Boolean = false;
		
		public var vibrationOn = true;
		
		// Charakter Attribute
		
		public static var player:int;
		public static var wurfObjekt:int;
		
		public static var intervall:int = 0; // in welchem intervall der aufgabe, fängt bei 0 an
		public static var zeitIntervall:Number; // anzahl der frames für ein zeitintervall
		public static var ballSprite:BitmapData;
		public static var charSprite:BitmapData;
		public static var fangGeschwindigkeit:Number; // wenn fangknopf gedrückt wird, ausschlag der hand
		public static var wurfGeschwindigkeit:Number; // wenn geworfen wird, ausschlag der hand
		public var max_fangAbstand:int; // abstand zwischen ball und hand
		public var handRadius:Number;
		public var handAbstand:Number;
		public var handBeschleunigung_x:Number;
		public var handBeschleunigung_y:Number;
		public var handDaempfung_x:Number;
		public var handDaempfung_y:Number;
		public var max_handGeschwindigkeit_x:Number;
		public var max_handGeschwindigkeit_y:Number;
		
		public var realFrameTimeLastFrame:Number = 0;
		public var realFrameTime:Number = 0;
		
		public static var augenRadius:Number;
		public static var augenBegrenzung:Number;
		
		//var AugeLinks = new Augen_Punkt();
		//var AugeRechts = new Augen_Punkt();
		
		// Wurfgeschwindigkeiten
		public var w1x:Number;
		public var w1y:Number;
		public var w2x:Number;
		public var w2y:Number;
		public var w3x:Number;
		public var w3y:Number;
		public var w4x:Number;
		public var w4y:Number;
		public var w5x:Number;
		public var w5y:Number;
		
		public var vx:Number;
		public var vy:Number;
		
		public var radiusShape:Shape;
		public var flugbahn:Flugbahn;
		
		public static var ballSpawnHight:int = 500;
		
		// Geringste Entfernung zum Ball
		
		public var links:int;
		public var abs:Number;
		
		// Ball Anzahl
		public static var ballAnzahl:int;
		
		// Ball Arrays
		
		public static var BallLuftArray:Array = new Array();
		public var BallLinksArray:Array = new Array();
		public var BallRechtsArray:Array = new Array();
		
		public var HandLinks:Hand;
		public var HandRechts:Hand;
		
		// Zeit
		public var fps:int = 30;
		public var verschiebung:Number;
		
		//public static var eigenerWurfButton:WurfButton = new WurfButton();
		public var ballResetMethode:int = 0; // 0 - normal    1 - bälle fallen
		public static var autoCatch:Boolean = false;
		public static var kannAufgabeBeenden:Boolean;
		public static var augenAbstand:int;
		public static var augenY:Number;
		
		public function Player(p:int, w:int):void
		{
			
			//this.cacheAsBitmap = true;
			initCharBitmap();
			loadCharSprite(p);
			
			// Character Eigenschaften
			initChar(p);
			initWurfobject(w);
			
			// Bälle verteilen
			baelle_verteilen(ballAnzahl);
			
			// lade ball
			loadBallSprite(w);
			
			// Enter Frame
			
			addEventListener(Event.ENTER_FRAME, loop);
		
		}
		
		public function setScale(n:Number):void
		{
			this.scaleX = n;
			this.scaleY = n;
		}
		
		private function initCharBitmap():void
		{
			
			screenData = new BitmapData(512, 400, true, 0xFF0000);
			screen = new Bitmap(screenData);
			
			// bitmap zentrieren
			screen.x -= 256;
			screen.y -= 256;
			
			addChild(screen);
		}
		
		
		public function vibriere(zeit:int):void
		{
			if (vibrationOn)
			{
				if (Vibration.isSupported) {
					trace("VIBE");
					var vibe:Vibration;
					vibe = new Vibration();
					vibe.vibrate(zeit);
				}
			}
		}
		
		public function loadCharSprite(n:int):void
		{
			if (n == 1)
			{
				charSprite = new SpritePanda();
			}
			else if (n == 2)
			{
				charSprite = new SpritePirat();
			}
			
			else if (n == 3)
			{
				charSprite = new SpriteMongo();
			}
			else if (n == 4)
			{
				charSprite = new SpritePanda();
			}else if (n == 5)
			{
				charSprite = new SpritePanda();
			}
			
			else
			{
				trace("unbekanntes Wurfobject");
			}
			showCharacter();
		}
		
		public function loadBallSprite(n:int):void
		{
			if (n == 1)
			{
				
				ballSprite = new SpriteKeule();
			}
			else if (n == 2)
			{
				ballSprite = new SpriteSchwert();
			}
			else
			{
				trace("unbekanntes Wurfobject");
			}
		}
		
		private function loop(e:Event):void
		{
			if (realFrameTimeLastFrame == 0) {
				realFrameTime = 1000/fps; // framezeit in milisekunden 33,333 ms
			}else {
				realFrameTime = new Date().getTime()-realFrameTimeLastFrame;
			}
			Main.frameDropMultiplikator = ( 1 + ((realFrameTime - 1000/Main.fps) / (1000 / Main.fps)));
			realFrameTimeLastFrame = new Date().getTime();
				
				
				
			
			hand_bewegen();
			ball_hand_folgen();
			check_baelle();
			check_preview_aktiv();
			
			if (trickAktiv)
			{
				
				Main.aktiveAufgabe.mc_time.y += 15 / zeitIntervall;
				if (frame == (zeitIntervall))
				{
					// wir befinden uns im nächsten Intervall
					frame = 0;
					
					intervall++;
					
					// im vorignen intervall
					//check nur wenn das intervall existiert
					if ((intervall - 1) < aktuellerAufgabenArrayLinks.length && (intervall - 1) < aktuellerAufgabenArrayRechts.length)
					{
						checkObWurfVergessen(intervall - 1);
					}
				}
				frame++;
				
			}
			if (kannAufgabeBeenden)
			{
				if (BallLuftArray.length == 0)
				{
					trace(" ");
					trace(trickCounter + " mal geschafft!");
					resetAufgabe();
				}
			}
		}
		
		public function check_preview_aktiv():void
		{
			if (Main.ShowMe == true)
			{
				
				// preview beginnt
				autoCatch = true;
				resetPreview();
				addEventListener(Event.ENTER_FRAME, loopPreview);
				
			}
		}
		
		private function loopPreview(e:Event):void
		{
			if (previewFrame == zeitIntervall)
			{
				//werfe was in diesem zeitintervall ist
				
				var wurfAusAufgabe_l:Array = new Array();
				var wurfAusAufgabe_r:Array = new Array();
				wurfAusAufgabe_l = Main.aufgabe[Main.aufgabeAktuell][previewIntervall];
				wurfAusAufgabe_r = Main.aufgabe[Main.aufgabeAktuell][previewIntervall + (Main.aufgabe[Main.aufgabeAktuell].length) / 2];
				
				//trace("WURF L " + wurfAusAufgabe_l);
				//trace("WURF R " + wurfAusAufgabe_r);
				
				
				if (wurfAusAufgabe_l[0] != 0)
				{
					checkAufgabenWurf(0, wurfAusAufgabe_l);
					
					if (wurfAusAufgabe_l.length == 2)
					{
						werfe(0, wurfAusAufgabe_l[1]);
					}
					werfe(0, wurfAusAufgabe_l[0]);
					
				}
				
				if (wurfAusAufgabe_r[0] != 0)
				{
					
					checkAufgabenWurf(1, wurfAusAufgabe_r);
					
					if (wurfAusAufgabe_r.length == 2)
					{
						werfe(1, wurfAusAufgabe_r[1]);
					}
					werfe(1, wurfAusAufgabe_r[0]);
					
				}
				
				previewIntervall++;
				previewFrame -= zeitIntervall;
				
				if (previewIntervall == Main.aufgabe[Main.aufgabeAktuell].length / 2)
				{
					removeEventListener(Event.ENTER_FRAME, loopPreview);
					autoCatch = false;
					trace("Preview AUSGEFÜHRT");
					
				}
				
			}
			
			previewFrame++;
		}
		
		private function resetPreview():void
		{
			
			Main.ShowMe = false;
			previewFrame = -20;
			previewIntervall = 0;
			reset_balls();
		}
		
		public function checkObWurfVergessen(n:int):void
		{
			// check ob in diesem intervall ein wurf fehlt
			// vergessen also resettet wird die aufgabe wenn der array auch existiert, damit man die aufgabe nach einem durchlauf beenden kann
			trace(" ");
			trace("check ob wurf vergessen  im intervall " + n);
			trace("aufgabenarray L " + aktuellerAufgabenArrayLinks);
			trace("aufgabenarray R " + aktuellerAufgabenArrayRechts);
			
			if ((aktuellerAufgabenArrayLinks[n] != 0 && (n < aktuellerAufgabenArrayLinks.length)) || ((aktuellerAufgabenArrayRechts[n] != 0) && (n < aktuellerAufgabenArrayRechts.length)))
			{
				trace("ja vergessen");
				resetAufgabe();
			}
			else
			{
				// wenn die aufgabe erfüllt ist
				
				if ((n + 1) % (Main.aufgabe[Main.aufgabeAktuell].length / 2) == 0)
				{
					resetZeitAnzeige();
					trace("trickcounter " + trickCounter);
					trickCounter++;
					trickAktiv = false;
					kannAufgabeBeenden = true;
				}
			}
			trace(" ");
		}
		
		public function resetZeitAnzeige():void
		{
			
			Main.aktiveAufgabe.mc_time.y = 0;
		}
		
		public function resetAufgabe():void
		{
			trace(" ");
			trace(" ");
			trace("reset aufgabe");
			initAufgabenArray();
			
			frame = 0;
			intervall = 0;
			
			resetZeitAnzeige();
			kannAufgabeBeenden = false;
			trickAktiv = false;
			trickCounter = 0;
			

		}
		
		public function initAufgabenArray():void
		{
			
			aktuellerAufgabenArrayLinks = new Array();
			aktuellerAufgabenArrayRechts = new Array();
			
			aktuellerAufgabenArrayLinks = getKopierterArray(aktuellerAufgabenArrayLinks, 0);
			aktuellerAufgabenArrayRechts = getKopierterArray(aktuellerAufgabenArrayRechts, Main.aufgabe[Main.aufgabeAktuell].length / 2);
		
			
			//aktuellerAufgabenArrayLinks = Main.aufgabe[Main.aufgabeAktuell].concat();
			//aktuellerAufgabenArrayRechts = Main.aufgabe[Main.aufgabeAktuell].concat();
			//trace("init aufgabenarray fertig L " + aktuellerAufgabenArrayLinks);
			//trace("init aufgabenarray fertig R " + aktuellerAufgabenArrayRechts);
		}
		
		private function initPreviewArray():void
		{
			
			aktuellerPreviewArray = new Array();
			aktuellerPreviewArray = Main.aufgabe[Main.aufgabeAktuell].concat();
		
		}
		
		private function hand_bewegen():void
		{
			
			HandLinks.move(BallLuftArray);
			HandRechts.move(BallLuftArray);
		}
		
		private function abstand(a:Object, b:Object):Number
		{
			var cx:Number = a.x - b.x;
			var cy:Number = a.y - b.y;
			return Math.sqrt((cx * cx) + (cy * cy));
		}
		
		public function check_baelle():void
		{
			
			for (var i:int = (BallLuftArray.length - 1); i >= 0; i--)
			{
				//trace("abstand ist " + abstand(BallLuftArray[i], HandLinks));
				if (BallLuftArray[i].y > 600)
				{
					
					reset_balls();
					
					//info();
					break;
					
				}
				else
				{
					var neuerFangAbstand:Number = max_fangAbstand;
					if (autoCatch) {
						neuerFangAbstand *= 0.5;
					}
					
					
					// check ob ball linke hand berührt
					if (abstand(BallLuftArray[i], HandLinks) < neuerFangAbstand && BallLuftArray[i].rechtsWirdFangen == false && (fangLinks_buttonPress == true || autoCatch == true) && BallLuftArray[i].vy > 0)
					{
						
						vibriere(30);
						HandLinks.vy += BallLuftArray[i].vy * 0.8;
						HandLinks.vx += BallLuftArray[i].vx * 0.2;
						
						BallLinksArray.push(BallLuftArray[i]);
						BallLuftArray.splice(i, 1);
						BallLinksArray[BallLinksArray.length - 1].init();
						BallLinksArray[BallLinksArray.length - 1].setSprite();
						
					}
					// check ob ball rechte hand berührt
					
					else if (abstand(BallLuftArray[i], HandRechts) < neuerFangAbstand && BallLuftArray[i].rechtsWirdFangen == true && (fangRechts_buttonPress == true || autoCatch == true) && BallLuftArray[i].vy > 0)
					{
						
						vibriere(30);
						HandRechts.vy += BallLuftArray[i].vy * 0.8;
						HandRechts.vx += BallLuftArray[i].vx * 0.2;
						
						BallRechtsArray.push(BallLuftArray[i]);
						BallLuftArray.splice(i, 1);
						BallRechtsArray[BallRechtsArray.length - 1].init();
						BallRechtsArray[BallRechtsArray.length - 1].setSprite();
					}
					
				}
				
					// check kollision
					//for (var j:int = i + 1; j < BallLuftArray.length; j++)
					//{
					//
					//if (BallLuftArray[i].hitTestObject(BallLuftArray[j]) && i != j && BallLuftArray[i].zeit > 10 && BallLuftArray[j].zeit > 5)
					//{
					//hit(i, j);
					//
					// berechne neue landung
					// für den 1. ball
					//var B:Number = BallLuftArray[i].y;
					//var H:Number = Main.char.y;
					//var c:Number = 2 * B / Ball.g - 2 * H / Ball.g;
					//BallLuftArray[i].zeit_end = -BallLuftArray[i].vy / Ball.g + Math.sqrt(((vy * vy) / (Ball.g * Ball.g)) - c);
					//BallLuftArray[i].x_end = BallLuftArray[i].x + BallLuftArray[i].zeit_end * BallLuftArray[i].vx;
					//BallLuftArray[i].zeit = 0;
					//
					// für den 2. ball
					//B = BallLuftArray[j].y;
					//c = 2 * B / Ball.g - 2 * H / Ball.g;
					//BallLuftArray[j].zeit_end = -BallLuftArray[j].vy / Ball.g + Math.sqrt(((vy * vy) / (Ball.g * Ball.g)) - c);
					//BallLuftArray[j].x_end = BallLuftArray[j].x + BallLuftArray[j].zeit_end * BallLuftArray[j].vx;
					//BallLuftArray[j].zeit = 0;
					//
					// trace("i bis end: " + BallLuftArray[i].zeit_end);
					// trace("i x end: " + BallLuftArray[i].x_end);
					// trace("j bis end: " + BallLuftArray[j].zeit_end);
					// trace("j x end: " + BallLuftArray[j].x_end);
					//}
					//}
				
			}
			fangLinks_buttonPress = false;
			fangRechts_buttonPress = false;
		
		}
		
		public function reset_balls():void
		{
			delete_balls();
			
			if (ballResetMethode == 0)
			{
				baelle_verteilen(ballAnzahl);
				
			}
			else if (ballResetMethode == 1)
			{
				var gerade:int = 2;
				var zaehler:int = zeitIntervall * ballAnzahl;
				
				addEventListener(Event.ENTER_FRAME, function bla()
					{
						zaehler--;
						
						if ((zaehler % zeitIntervall) == 0)
						{
							if (gerade % 2 == 0)
							{
								
								neuer_ball(BallLuftArray, HandRechts.fange_x, HandRechts.y - Player.ballSpawnHight);
								BallLuftArray[(BallLuftArray.length - 1)].einblenden();
								BallLuftArray[BallLuftArray.length - 1].rechtsWirdFangen = true;
								
							}
							else
							{
								neuer_ball(BallLuftArray, HandLinks.fange_x, HandLinks.y - Player.ballSpawnHight);
								BallLuftArray[(BallLuftArray.length - 1)].einblenden();
								BallLuftArray[BallLuftArray.length - 1].rechtsWirdFangen = false;
								
							}
							
							BallLuftArray[(BallLuftArray.length - 1)].ball_in_hand = false;
							BallLuftArray[(BallLuftArray.length - 1)].berechneFangzeit();
							gerade++;
							
						}
						if (zaehler == 0)
						{
							removeEventListener(Event.ENTER_FRAME, bla);
						}
					
					});
			}
		
		}
		
		private function hit(i:int, j:int):void
		{
			// trace("HIT");
			// auseinander, damit bälle sich nicht mehr berühen
			//while (BallLuftArray[i].hitTestObject(BallLuftArray[j]))
			//{
			//BallLuftArray[i].x -= (BallLuftArray[i].vx / 20);
			//BallLuftArray[i].y -= (BallLuftArray[i].vy / 20);
			//BallLuftArray[j].x -= (BallLuftArray[j].vx / 20);
			//BallLuftArray[j].y -= (BallLuftArray[j].vy / 20);
			//}
			//var dx:Number = BallLuftArray[i].x - BallLuftArray[j].x;
			//var dy:Number = BallLuftArray[i].y - BallLuftArray[j].y;
			//var phi:Number = Math.atan(dy / dx); //find the collision angle
			//
			//var term:Number = Math.PI / 180; //degree->radian
			//
			//find out the magnitude of the velocities of the two balls
			//var v1i:Number = Math.sqrt(BallLuftArray[i].vx * BallLuftArray[i].vx + BallLuftArray[i].vy * BallLuftArray[i].vy);
			//var v2i:Number = Math.sqrt(BallLuftArray[j].vx * BallLuftArray[j].vx + BallLuftArray[j].vy * BallLuftArray[j].vy);
			//
			//find out the angle of the velocity vector
			//var ang1:Number = findAnAngle(BallLuftArray[i].vx, BallLuftArray[i].vy) * term;
			//var ang2:Number = findAnAngle(BallLuftArray[j].vx, BallLuftArray[j].vy) * term;
			//
			//find the velocities in the new coordinate system
			//var v1xr:Number = v1i * Math.cos(ang1 - phi);
			//var v1yr:Number = v1i * Math.sin(ang1 - phi);
			//var v2xr:Number = v2i * Math.cos(ang2 - phi);
			//var v2yr:Number = v2i * Math.sin(ang2 - phi);
			//
			//find the final velocities in the normal reference frame
			//the x velocities will obey the rules for a 1-D collision
			//var v1fxr:Number = v2xr;
			//var v2fxr:Number = v1xr;
			//the y velocities will not be changed
			//var v1fyr:Number = v1yr;
			//var v2fyr:Number = v2yr;
			//
			//convert back to the standard x,y coordinates
			//BallLuftArray[i].vx = Math.cos(phi) * v1fxr + Math.cos(phi + Math.PI / 2) * v1fyr;
			//BallLuftArray[i].vy = Math.sin(phi) * v1fxr + Math.sin(phi + Math.PI / 2) * v1fyr;
			//BallLuftArray[j].vx = Math.cos(phi) * v2fxr + Math.cos(phi + Math.PI / 2) * v2fyr;
			//BallLuftArray[j].vy = Math.sin(phi) * v2fxr + Math.sin(phi + Math.PI / 2) * v2fyr;
		
		}
		
		public function findAnAngle(xthing:Number, ything:Number):Number
		{
			//very basic angle finder..returns value in degrees  
			var term:Number = Math.PI / 180 //degree->radian
			var t:Number;
			if (xthing < 0)
			{
				t = 180 + Math.atan(ything / xthing) / term;
			}
			else if (xthing > 0 && ything >= 0)
			{
				t = Math.atan(ything / xthing) / term;
			}
			else if (xthing > 0 && ything < 0)
			{
				t = 360 + Math.atan(ything / xthing) / term;
			}
			else if (xthing == 0 && ything == 0)
			{
				t = 0;
			}
			else if (xthing == 0 && ything >= 0)
			{
				t = 90;
			}
			else
			{
				t = 270;
			}
			
			return t;
		}
		
		public function delete_balls():void
		{
			
			while (BallLuftArray.length > 0)
			{
				nimm_ball_ersten_ball(BallLuftArray);
			}
			
			while (BallRechtsArray.length > 0)
			{
				nimm_ball_ersten_ball(BallRechtsArray);
			}
			
			while (BallLinksArray.length > 0)
			{
				nimm_ball_ersten_ball(BallLinksArray);
			}
		
		}
		
		public function showInfo():void
		{
			setScale(0.5);
			showRadius();
			showFlugbahn();
		
		}
		
		public function unShowInfo():void
		{
			unShowRadius();
		}
		
		public function fadeOut():void
		{
			fadeAnimationZeit = 10;
			addEventListener(Event.ENTER_FRAME, showInfoFade);
		}
		
		private function showInfoFade(e:Event):void
		{
			fadeAnimationZeit--;
			if (fadeAnimationZeit <= 0)
			{
				
				removeEventListener(Event.ENTER_FRAME, showInfoFade);
				
			}
			else
			{
				this.alpha = (fadeAnimationZeit / 10);
				
			}
		}
		
		public function initWurfobject(w:int):void
		{
			loadBallSprite(w);
		}
		
		public function initChar(p:int):void
		{
			
			player = p;
			loadCharSprite(p);
			
			var MAX_handradius:Number = Main.breite / 8;
			var MAX_handabstand:Number = Main.breite / 4;
			// fangzeit je kleiner desto später wird gefangen
			if (p == 1)
			{
				
				// kann mit 6 Bällen
				
				max_fangAbstand = 75; // abstand hand ball ob gefangen wird
				zeitIntervall = 20;
				handBeschleunigung_x = 1.5;
				handBeschleunigung_y = 1.5;
				handDaempfung_x = 0.8;
				handDaempfung_y = 0.8
				handRadius = MAX_handradius * 0.8;
				handAbstand = MAX_handabstand * 0.8;
				max_handGeschwindigkeit_x = 30;
				max_handGeschwindigkeit_y = 30;
				augenRadius = 13;
				augenAbstand = 35;
				augenY = 658;
				augenBegrenzung = -6.5;
				fangGeschwindigkeit = 3; // wei schnell hand beim fangen ausschlägt in y-richtung
				wurfGeschwindigkeit = 6; // wei schnell hand beim werfen ausschlägt in y-richtung
				Ball.g = 1.3;
				ballAnzahl = 2;
				
				//Buttons
				Main.buttons.initButtons(false, false, true, true, false, false);
				
					//max_wurfhoehe = 500;
			}
			else if (p == 2)
			{
				
				max_fangAbstand = 75;
				zeitIntervall = 20;
				handBeschleunigung_x = 2;
				handBeschleunigung_y = 2;
				handDaempfung_x = 0.85;
				handDaempfung_y = 0.85;
				handRadius = MAX_handradius * 0.9;
				handAbstand = MAX_handabstand * 0.5;
				max_handGeschwindigkeit_x = 65;
				max_handGeschwindigkeit_y = 30;
				augenRadius = 15;
				augenAbstand = 15;
				augenY = 658;
				augenBegrenzung = -30;
				fangGeschwindigkeit = 15;
				Ball.g = 0.8;
				ballAnzahl = 3;
				
				Main.buttons.initButtons(true, true, true, true, false, false);
			}
			else if (p == 3)
			{
				// Mongo
				max_fangAbstand = 75;
				zeitIntervall = 16;
				handBeschleunigung_x = 1.2;
				handBeschleunigung_y = 1.2;
				handDaempfung_x = 0.88;
				handDaempfung_y = 0.88;
				handRadius = MAX_handradius * 0.8;
				handAbstand = MAX_handabstand * 0.9;
				max_handGeschwindigkeit_x = 65;
				max_handGeschwindigkeit_y = 40;
				augenRadius = 22;
				//augenAbstand = 45;
				augenAbstand = 45;
				augenY = 675;
				augenBegrenzung = -60;
				fangGeschwindigkeit = 15;
				Ball.g = 0.7;
				
				Main.buttons.initButtons(false, true, true, false, true, false);
			}
			else if (p == 4)
			{
				
				max_fangAbstand = 75;
				zeitIntervall = 12;
				handBeschleunigung_x = 2;
				handBeschleunigung_y = 2;
				handDaempfung_x = 0.85;
				handDaempfung_y = 0.85;
				handRadius = MAX_handradius * 0.7;
				handAbstand = MAX_handabstand * 0.7;
				max_handGeschwindigkeit_x = 65;
				max_handGeschwindigkeit_y = 30;
				augenRadius = 15;
				augenAbstand = 15;
				augenBegrenzung = -30;
				fangGeschwindigkeit = 15;
				Ball.g = 1.2;
				
				Main.buttons.initButtons(false, true, false, true, false, true);
			}
			else if (p == 5)
			{
				
				max_fangAbstand = 75;
				zeitIntervall = 12;
				handBeschleunigung_x = 2;
				handBeschleunigung_y = 2;
				handDaempfung_x = 0.85;
				handDaempfung_y = 0.85;
				handRadius = MAX_handradius * 0.9;
				handAbstand = MAX_handabstand * 0.9;
				max_handGeschwindigkeit_x = 65;
				max_handGeschwindigkeit_y = 30;
				augenRadius = 15;
				augenAbstand = 15;
				augenBegrenzung = -30;
				fangGeschwindigkeit = 15;
				Ball.g = 1.2;
				
				Main.buttons.initButtons(true, true, true, true, true, true);
			}
			max_fangAbstand = 100;
			
			if (HandLinks)
			{
				removeChild(HandLinks);
				removeChild(HandRechts);
			}
			
			HandLinks = new Hand(player, -handAbstand, -handRadius, zeitIntervall, handBeschleunigung_x, handBeschleunigung_y, handDaempfung_x, handDaempfung_y, max_handGeschwindigkeit_x, max_handGeschwindigkeit_y);
			HandRechts = new Hand(player, handAbstand, handRadius, zeitIntervall, handBeschleunigung_x, handBeschleunigung_y, handDaempfung_x, handDaempfung_y, max_handGeschwindigkeit_x, max_handGeschwindigkeit_y);
			HandLinks.Links = true;
			HandRechts.Rechts = true;
			
			addChild(HandLinks);
			addChild(HandRechts);
			
			if (this.scaleX < 1)
			{
				unShowRadius();
				showInfo();
			}
			
			
			// Auge
			
		
			//Main.augeLinks.x = -augenAbstand+Main.breite/2;
			Main.augeLinks.x = -augenAbstand+Main.breite/2;
			Main.augeRechts.x = augenAbstand+Main.breite/2; 	
			Main.augeLinks.y = augenY;
			Main.augeRechts.y = augenY; 
		
			
			// Bälle
			
			reset_balls();
			
			
		}
		
		public function showCharacter():void
		{
			screenData.copyPixels(charSprite, new Rectangle(0, 0, 512, 512), new Point(0, 0));
		}
		
		public function nimm_ball_ersten_ball(a:Array):void
		{
			
			if (a.length > 0)
			{
				
				a[0].deleate();
				a.splice(0, 1);
				
			}
			else
			{
				trace("konnte ball nicht poppen");
			}
		
		}
		
		private function neuer_ball(array:Array, x:Number, y:Number):void
		{
			
			var newBallbla:Ball = new Ball(x, y);
			addChild(newBallbla);
			array.push(newBallbla);
		
		}
		
		private function baelle_verteilen(n:int):void
		{
			
			while (n > 0)
			{
				
				if (BallLinksArray.length >= BallRechtsArray.length)
				{
					neuer_ball(BallRechtsArray, HandRechts.x, HandRechts.y);
					BallRechtsArray[(BallRechtsArray.length - 1)].einblenden();
				}
				else
				{
					neuer_ball(BallLinksArray, HandLinks.x, HandLinks.y);
					BallLinksArray[(BallLinksArray.length - 1)].einblenden();
				}
				n--;
			}
		
		}
		
		private function ball_hand_folgen():void
		{
			// Rechte Hand folgen
			if (BallRechtsArray.length > 0)
			{
				for (var i:int = 0; i < BallRechtsArray.length; i++)
				{
					BallRechtsArray[i].x = HandRechts.x;
					BallRechtsArray[i].y = HandRechts.y;
					
					BallRechtsArray[i].ballVariation = 0 + 3 * (BallRechtsArray.length - 1 - i) / Player.ballAnzahl;
					
				}
			}
			// Linke Hand folgen
			if (BallLinksArray.length > 0)
			{
				for (var k:int = 0; k < BallLinksArray.length; k++)
				{
					BallLinksArray[k].x = HandLinks.x;
					BallLinksArray[k].y = HandLinks.y;
					
					BallLinksArray[k].ballVariation = 0 + 3 * k / Player.ballAnzahl;
					
				}
			}
		
		}
		
		public function info():void
		{
			trace("Bälle links " + BallLinksArray.length);
			trace("Bälle rechts " + BallRechtsArray.length);
			trace("Bälle luft " + BallLuftArray.length);
		
		}
		
		public function showFlugbahn():void
		{
			// rechte hand
			flugbahn = new Flugbahn(zeitIntervall);
			addChild(flugbahn);
			
			if (Main.buttons.r1.visible == true)
			{
				flugbahn.berechneFlugKoords(handAbstand - handRadius, - handAbstand - handRadius, 1);
			}
			if (Main.buttons.r2.visible == true)
			{
				
			}
			if (Main.buttons.r3.visible == true)
			{
				flugbahn.berechneFlugKoords(handAbstand - handRadius, - handAbstand - handRadius, 3);
			}
			if (Main.buttons.r4.visible == true)
			{
				flugbahn.berechneFlugKoords(handAbstand - handRadius, handAbstand + handRadius, 4);
			}
			if (Main.buttons.r5.visible == true)
			{
				flugbahn.berechneFlugKoords(handAbstand - handRadius, -handAbstand - handRadius, 5);
			}
			if (Main.buttons.r6.visible == true)
			{
				flugbahn.berechneFlugKoords(handAbstand - handRadius, handAbstand + handRadius, 6);
			}
			
			// linke hand
			
			if (Main.buttons.l1.visible == true)
			{
				flugbahn.berechneFlugKoords(-handAbstand + handRadius, handAbstand + handRadius, 1);
			}
			if (Main.buttons.l2.visible == true)
			{
				
			}
			if (Main.buttons.l3.visible == true)
			{
				flugbahn.berechneFlugKoords(-handAbstand + handRadius, handAbstand + handRadius, 3);
			}
			if (Main.buttons.l4.visible == true)
			{
				flugbahn.berechneFlugKoords(-handAbstand + handRadius, -handAbstand - handRadius, 4);
			}
			if (Main.buttons.l5.visible == true)
			{
				flugbahn.berechneFlugKoords(-handAbstand + handRadius, handAbstand + handRadius, 5);
			}
			if (Main.buttons.l6.visible == true)
			{
				flugbahn.berechneFlugKoords(-handAbstand + handRadius, -handAbstand - handRadius, 6);
			}
			flugbahn.showFlugKoords();
		}
		
		public function showRadius():void
		{
			
			radiusShape = new Shape();
			radiusShape.graphics.lineStyle(1, 0x000000);
			radiusShape.graphics.drawCircle(handAbstand, 0, handRadius);
			radiusShape.graphics.drawCircle(-handAbstand, 0, handRadius);
			addChild(radiusShape);
		
		}
		
		public function unShowRadius():void
		{
			trace("unshow");
			trace(radiusShape);
			if (radiusShape!=null)
			{
				trace("unshow radius");
				removeChild(radiusShape);
				radiusShape = null;
			}
			
			if (flugbahn!=null)
			{
				trace("unshow flugbahn");
				removeChild(flugbahn);
				flugbahn = null;
				
			}
		
		}
		
		public function werfe(hand:int, wurfzahl:int):void
		{
			
			vibriere(30);
			
			// wechsle posi button unten
			if (wurfzahl == 2)
			{
				
				if (hand == 0)
				{
					HandLinks.wechsel();
					
					Main.buttons.l1.switchPosi();
					Main.buttons.l2.switchPosi();
					Main.buttons.l3.switchPosi();
					Main.buttons.l4.switchPosi();
					Main.buttons.l5.switchPosi();
					Main.buttons.l6.switchPosi();
				}
				else
				{
					HandRechts.wechsel();
					
					Main.buttons.r1.switchPosi();
					Main.buttons.r2.switchPosi();
					Main.buttons.r3.switchPosi();
					Main.buttons.r4.switchPosi();
					Main.buttons.r5.switchPosi();
					Main.buttons.r6.switchPosi();
				}
			}
			else
			{
				
				var werfeLinks:Boolean = false;
				// meint damit links hand links oder rechte hand links
				var fangeLinks:Boolean = false;
				// meint damit links hand links oder rechte hand links
				var ungeaderWurf:Boolean = false;
				if (wurfzahl % 2 == 1)
				{
					ungeaderWurf = true;
				}
				
				if (hand == 0)
				{
					
					if (ungeaderWurf)
					{
						// rechte hand fängt
						if (HandRechts.normal == true)
						{
							fangeLinks = false;
						}
						else
						{
							fangeLinks = true
						}
					}
					else
					{
						// linke hand fängt
						
						if (HandLinks.normal == true)
						{
							fangeLinks = true;
						}
						else
						{
							fangeLinks = false
						}
					}
					if (HandLinks.normal == false)
					{
						werfeLinks = true;
						
					}
					
				}
				else
				{
					
					// rechte hand wirft
					
					if (ungeaderWurf)
					{
						// linke hand fängt
						if (HandLinks.normal == true)
						{
							fangeLinks = true;
						}
						else
						{
							fangeLinks = false
						}
					}
					else
					{
						// rechte hand fängt
						if (HandRechts.normal == true)
						{
							fangeLinks = false;
						}
						else
						{
							fangeLinks = true
						}
					}
					if (HandRechts.normal == false)
					{
						
					}
					else
					{
						werfeLinks = true;
					}
				}
				
				var fangZeit:Number = zeitIntervall * wurfzahl - zeitIntervall; // anzahl der frames der fangzeit
				
				// wenn die aufgabe synchronwerfen ist dann haben ungerade wurfzahlen mehr fangzeit
				//if (((wurfzahl % 2) == 1) && Aufgabe.synchron == true)
				//{
				//fangZeit += zeitIntervall;
				//}
				
				vy = fangZeit * (-1) * Ball.g / 2;
				
				var max_wurfhoehe:Number = vy * vy / 2 * Ball.g;
				var rechnung_abstand:Number;
				
				if (wurfzahl % 2 == 1)
				{
					// ungerade
					
					if (hand == 0)
					{
						rechnung_abstand = HandRechts.fange_x - HandLinks.werfe_x;
					}
					else
					{
						rechnung_abstand = HandLinks.fange_x - HandRechts.werfe_x;
					}
					
				}
				else
				{
					// gerade
					if (hand == 0)
					{
						rechnung_abstand = HandLinks.fange_x - HandLinks.werfe_x;
					}
					else
					{
						rechnung_abstand = HandRechts.fange_x - HandRechts.werfe_x;
					}
				}
				
				// einer Wurf kompromiss
				if (fangZeit == 0)
				{
					
					fangZeit += zeitIntervall / 4;
					if (hand == 0)
					{
						rechnung_abstand = HandRechts.werfe_x - HandLinks.werfe_x;
					}
					else
					{
						rechnung_abstand = HandLinks.werfe_x - HandRechts.werfe_x;
					}
					
					vy = fangZeit * (-2) * Ball.g / 2;
					vy = 1;
				}
				
				// wie leicht, bei 1.0 schwer, da bis zum rand geworfen wird
				rechnung_abstand *= 0.95;
				
				vx = rechnung_abstand / fangZeit;
				vx *= (1 + (10 - Main.up_accuracy) * 4 / 100 * (Math.random() - 0.5));
				vy *= (1 + (10 - Main.up_accuracy) * 4 / 100 * (Math.random() - 0.5));
				
				if ((BallRechtsArray.length > 0) && (hand == 1))
				{
					
					BallLuftArray.push(BallRechtsArray[0]);
					BallRechtsArray.splice(0, 1);
					BallLuftArray[(BallLuftArray.length - 1)].ball_in_hand = false;
					BallLuftArray[(BallLuftArray.length - 1)].setSpeed(vx, vy);
					BallLuftArray[(BallLuftArray.length - 1)].berechneFangzeit();
					HandRechts.vy -= Player.wurfGeschwindigkeit;
					
					// keule spiegeln
					if (vx <= 0)
					{
						//BallLuftArray[(BallLuftArray.length - 1)].flipBitmapData();
					}
					
					// welche hand soll fangen
					if (wurfzahl == 2 || wurfzahl == 4 || wurfzahl == 6)
					{
						BallLuftArray[BallLuftArray.length - 1].rechtsWirdFangen = true;
						
					}
					else
					{
						BallLuftArray[BallLuftArray.length - 1].rechtsWirdFangen = false;
						
					}
				}
				else if ((BallLinksArray.length > 0) && (hand == 0))
				{
					
					BallLuftArray.push(BallLinksArray[0]);
					BallLinksArray.splice(0, 1);
					BallLuftArray[(BallLuftArray.length - 1)].ball_in_hand = false;
					BallLuftArray[(BallLuftArray.length - 1)].setSpeed(vx, vy);
					BallLuftArray[(BallLuftArray.length - 1)].berechneFangzeit();
					
					HandLinks.vy -= Player.wurfGeschwindigkeit;
					
					// keule spiegeln
					if (vx > 0)
					{
						//BallLuftArray[(BallLuftArray.length - 1)].flipBitmapData();
					}
					// welche hand soll fangen
					if (wurfzahl == 2 || wurfzahl == 4 || wurfzahl == 6)
					{
						BallLuftArray[BallLuftArray.length - 1].rechtsWirdFangen = false;
						
					}
					else
					{
						
						BallLuftArray[BallLuftArray.length - 1].rechtsWirdFangen = true;
						
					}
					
				}
				
				var mirror:Boolean = false;
				var fall:int; // fall 1 L-L    fall 2 L-R eine drehung      fall 3 R-L   zwei drehungen     fall 4  L-R drei drehungen
				if (werfeLinks == true && fangeLinks == true)
				{
					fall = 1;
					if (wurfzahl == 3)
					{
						BallLuftArray[BallLuftArray.length - 1].multiLoop = 1;
					}
					else if (wurfzahl == 4)
					{
						BallLuftArray[BallLuftArray.length - 1].multiLoop = 2;
					}
					else if (wurfzahl == 5)
					{
						BallLuftArray[BallLuftArray.length - 1].multiLoop = 3;
					}
					
				}
				else if (werfeLinks == false && fangeLinks == false)
				{
					// switch
					mirror = true;
					fall = 1;
					
					if (wurfzahl == 3)
					{
						BallLuftArray[BallLuftArray.length - 1].multiLoop = 1;
					}
					else if (wurfzahl == 4)
					{
						BallLuftArray[BallLuftArray.length - 1].multiLoop = 2;
					}
					else if (wurfzahl == 5)
					{
						BallLuftArray[BallLuftArray.length - 1].multiLoop = 3;
					}
					
				}
				
				else if (werfeLinks == true && fangeLinks == false)
				{
					
					if (wurfzahl == 3)
					{
						fall = 2;
					}
					else if (wurfzahl == 4)
					{
						fall = 3;
						mirror = true;
					}
					else if (wurfzahl == 5)
					{
						fall = 3;
						mirror = true;
						
					}
					else if (wurfzahl == 6)
					{
						fall = 4;
					}
					
				}
				
				else if (werfeLinks == false && fangeLinks == true)
				{
					if (wurfzahl == 3)
					{
						fall = 2;
						mirror = true;
					}
					else if (wurfzahl == 4)
					{
						fall = 3;
						
					}
					else if (wurfzahl == 5)
					{
						fall = 3;
					}
					else if (wurfzahl == 6)
					{
						fall = 4;
						mirror = true;
					}
				}
				
				if (mirror)
				{
					//trace("mirror");
					BallLuftArray[BallLuftArray.length - 1].flipBitmapData();
				}
				
				if (fall == 1)
				{
					BallLuftArray[BallLuftArray.length - 1].animationStart = 60;
					BallLuftArray[BallLuftArray.length - 1].animationEnde = 120;
				}
				else if (fall == 2)
				{
					BallLuftArray[BallLuftArray.length - 1].animationStart = 120;
					BallLuftArray[BallLuftArray.length - 1].animationEnde = 170;
				}
				else if (fall == 3)
				{
					BallLuftArray[BallLuftArray.length - 1].animationStart = 170;
					BallLuftArray[BallLuftArray.length - 1].animationEnde = 220;
				}
				else if (fall == 4)
				{
					BallLuftArray[BallLuftArray.length - 1].animationStart = 220;
					BallLuftArray[BallLuftArray.length - 1].animationEnde = 300;
				}
				
			}
		
		}
		
		public function checkAufgabenWurf(hand:int, wurfArray:Array):void
		{
			// check ob der wurf auch der nächste in der aufgabe ist
			// aufgabenwurf ist der jetztige wurf, entweder [3] oder [3,4]
			//trace(" ");
			//trace("check wurf mit hand " + hand + "  mit array " + wurfArray + " im intervall " + intervall);
			wurfArray = wurfArray.sort();
			var geschafft:Boolean = false;
			var aktuellerAufgabenWurf:Array = new Array();
			
			if (hand == 0)
				
			{
				// linke hand
				
				if (getNextWurfPositionImArrayLinks() == -1)
				{
					
					// keinen neuen wurf gefunden, aufgabe kopieren und hinten ranhängen
					trace("keinen neuen wurf gefunden");
					aktuellerAufgabenArrayLinks = getKopierterArray(aktuellerAufgabenArrayLinks, 0);
					aktuellerAufgabenArrayRechts = getKopierterArray(aktuellerAufgabenArrayRechts, Main.aufgabe[Main.aufgabeAktuell].length / 2);
					trace("neuer Array ist " + aktuellerAufgabenArrayLinks);
					
				}
				
				aktuellerAufgabenWurf = aktuellerAufgabenArrayLinks[getNextWurfPositionImArrayLinks()];
				
			}
			else
			{
				
				// rechte hand
				
				if (getNextWurfPositionImArrayRechts() == -1)
				{
					
					// keinen neuen wurf gefunden, aufgabe kopieren und hinten ranhängen
					trace("keinen neuen wurf gefunden");
					aktuellerAufgabenArrayLinks = getKopierterArray(aktuellerAufgabenArrayLinks, 0);
					aktuellerAufgabenArrayRechts = getKopierterArray(aktuellerAufgabenArrayRechts, Main.aufgabe[Main.aufgabeAktuell].length / 2);
					
					trace("neuer Array ist " + aktuellerAufgabenArrayRechts);
					
				}
				
				aktuellerAufgabenWurf = aktuellerAufgabenArrayRechts[getNextWurfPositionImArrayRechts()];
				
			}
			
			aktuellerAufgabenWurf.sort();
			if (aktuellerAufgabenWurf.length == wurfArray.length)
			{
				// aufgabe und wurf sind gleich lang, check jetzt ob jeder wurf gleich ist
				
				geschafft = true;
				for (var i:int = 0; i < aktuellerAufgabenWurf.length; i++)
				{
					if (aktuellerAufgabenWurf[i] != wurfArray[i])
					{
						geschafft = false;
					}
				}
				
			}
			
			if (geschafft)
			{
				trace(" ");
				trace("wurf wird markiert");
				trickAktiv = true;
				
				// wurf geschafft, wird auf 0 gesetzt
				if (hand == 0)
				{
					// linke hand
					
					checkWieZeitigGeworfenWurde(frame, int(getNextWurfPositionImArrayLinks() * zeitIntervall));
					aktuellerAufgabenArrayLinks[getNextWurfPositionImArrayLinks()] = [0];
					
				}
				else
				{
					// rechte hand	
					
					checkWieZeitigGeworfenWurde(frame, int(getNextWurfPositionImArrayRechts() * zeitIntervall));
					aktuellerAufgabenArrayRechts[getNextWurfPositionImArrayRechts()] = [0];
				}
				
				trace("nach dem löschen array Links: " + aktuellerAufgabenArrayLinks);
				trace("nach dem löschen array Rechts: " + aktuellerAufgabenArrayRechts);
				trace(" ");
			}
		
		}
		
		public function getKopierterArray(array:Array, startFrame:int):Array
		{
			//trace(" ");
			//trace("startframe ist "+startFrame);
			var lang:int = array.length
			for (var i:int = 0; i < Main.aufgabe[Main.aufgabeAktuell].length / 2; i++)
			{
				array[lang + i] = Main.aufgabe[Main.aufgabeAktuell][startFrame + i]
					//trace("kopiere aus intervall " + (i+startFrame));
					//trace("array " + array);
				
			}
			
			return array;
		}
		
		public function checkWieZeitigGeworfenWurde(frameIst:int, frameSoll:int):void
		{
			trace("frameIst - frameSoll");
			trace(frameIst - frameSoll);
			trace(" ");
		}
		
		public function getNextWurfPositionImArrayLinks():int
		{
			var returnerInt:int = -1;
			
			for (var i:int = 0; i < aktuellerAufgabenArrayLinks.length; i++)
			{
				if (aktuellerAufgabenArrayLinks[i][0] != 0)
				{
					
					returnerInt = i;
					break;
				}
			}
			trace("gefunden " + aktuellerAufgabenArrayLinks[i] + " im intervall " + i);
			return returnerInt;
		
		}
		
		public function getNextWurfPositionImArrayRechts():int
		{
			var returner:int = -1;
			
			for (var i:int = 0; i < aktuellerAufgabenArrayRechts.length; i++)
			{
				if (aktuellerAufgabenArrayRechts[i][0] != 0)
				{
					
					returner = i;
					break;
				}
			}
			trace("gefunden " + aktuellerAufgabenArrayRechts[i] + " im intervall " + i);
			return returner;
		
		}
		
	
	
	}

}