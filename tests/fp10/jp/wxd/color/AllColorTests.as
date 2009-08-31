package jp.wxd.color 
{
	import jp.wxd.color.display.ColorPaletteTest;
	import jp.wxd.color.generator.ColorGeneratorTest;
	import org.libspark.as3unit.runners.Suite;
	
	/**
	 * ...
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class AllColorTests 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		public static const RunWith:Class = Suite;
		public static const SuiteClasses:Array = [
			ColorGeneratorTest, ColorPaletteTest
		];
	}
	
}