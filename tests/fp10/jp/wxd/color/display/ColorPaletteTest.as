package jp.wxd.color.display 
{
	import org.libspark.as3unit.after;
	import org.libspark.as3unit.assert.*;
	import org.libspark.as3unit.before;
	import org.libspark.as3unit.test;
	import org.libspark.as3unit.test_expected;
	
	/**
	 * ...
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class ColorPaletteTest 
	{
		test function constructor():void
		{
			var colorPalette:ColorPalette = new ColorPalette();
			assertTrue(colorPalette is ColorPalette, "check whether new method returns instance of 'ColorPalette'.");
		}
	}
}