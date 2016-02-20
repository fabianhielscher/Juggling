package
{
	import com.adobe.nativeExtensions.Vibration;
	
	//import com.adobe.nativeExtenseions.Vibration
	/**
	 * ...
	 * @author Fabian Hielscher
	 */
	public class Vibration
	{
		public function Vibration()
		{
		
			var vibe:Vibration;
			if (Vibration.isSupported)
			{
				vibe = new Vibration();
				vibe.vibrate(2000);
			}
		}
	}
}