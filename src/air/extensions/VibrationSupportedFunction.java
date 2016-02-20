/*ADOBE SYSTEMS INCORPORATED
Copyright 2011 Adobe Systems Incorporated
All Rights Reserved.

NOTICE:� Adobe permits you to use, modify, and distribute this file in accordance with the 
terms of the Adobe license agreement accompanying it.� If you have received this file from a 
source other than Adobe, then your use, modification, or distribution of it requires the prior 
written permission of Adobe.
 */

package air.extensions;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;

// Class VibrationSupportedFunction
//
// This class checks whether the device supports vibration.
//

public class VibrationSupportedFunction implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] passedArgs) {

		FREObject result=null;

		Log.i("VibrationSupportedFunction", "call");

		VibrationExtensionContext vibExtContext = (VibrationExtensionContext) context;

		try {

			if (vibExtContext.androidVibrator == null)

			{
				Log.i("VibrationSupportedFunction", "NOT supported");
				result = FREObject.newObject(false);
			}

			else

			{
				Log.i("VibrationSupportedFunction", "Supported");
				result=FREObject.newObject(true);
			}

		}

		catch(FREWrongThreadException e) {

			e.printStackTrace();
		}

		return result;
	}

}
