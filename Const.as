package  
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Fabian Hielscher
	 */
	public class Const extends MovieClip
	{
		var g:Number = 10;
		
		var spieler:int = 1;
		
		// Bildschirmgröße
		var breite:int = Main.breite;
		var hoehe:int = Main.hoehe;
		
		
		// Auge Koordinaten
		var augen_y:Number = hoehe / 400 * 223;
		var augen_abs:Number = breite / 14;
		
		
		
		
		
		
		
		
		
		
		
				// je größer, desto schneller fangen, desto mehr schwingen, desto größer hand_g
		// mit hand g ausgleichen
		private var hand_traegheit:Number = 0.02;
		public var a_fangen:Number = 0.02;
		
		
		public function Const() 
		{
			
		}
		
	}

}