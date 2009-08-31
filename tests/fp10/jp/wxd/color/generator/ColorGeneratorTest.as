package jp.wxd.color.generator 
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
	public class ColorGeneratorTest 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		/**
		 * web safe colors
		 */
		private const WEB_SAFE_COLORS:uint = 216;
		
		test_expected static const zeroArgumentError:Class = ArgumentError;
		test_expected static const maxArgumentError:Class = ArgumentError;
		
		test function zeroArgumentError():void
		{
			var colorGenerator:ColorGenerator = new ColorGenerator(0);
		}
		
		test function maxArgumentError():void
		{
			var colorGenerator:ColorGenerator;
			colorGenerator = new ColorGenerator(0x100);
			colorGenerator = new ColorGenerator(0xFFFF);
		}
		
		test function constructor():void
		{
			var colorGenerator:ColorGenerator = new ColorGenerator(ColorGenerator.WEB_SAFE_COLOR);
			assertTrue(colorGenerator is ColorGenerator, "check whether new method returns instance of 'CommandStack'.");
		}
		
		test function webSafeColors():void
		{
			var colorGenerator:ColorGenerator = new ColorGenerator(ColorGenerator.WEB_SAFE_COLOR);
			assertEquals(colorGenerator.count, WEB_SAFE_COLORS, "check whether instance's property of 'count' is '" + WEB_SAFE_COLORS + "' or not");	
		}
		
		test function colorsStructure():void
		{
			var colorGenerator:ColorGenerator = new ColorGenerator(ColorGenerator.WEB_SAFE_COLOR);
			var colors:Array = colorGenerator.colors;
			
			assertTrue(colors is Array, "check whether colors is Array or not");
			for (var i:uint = 0; i < colors.length; i++)
			{
				assertTrue(colors[i] is Array, "check whether colors[" + i + "] is Array or not");
				for (var j:uint = 0; j < colors[i].length; j++)
				{
					assertTrue(colors[i][j] is Array, "check whether colors[" + i + "][" + j + "] is Array or not");
					for (var k:uint = 0; k < colors[i][j].length; k++)
					{
						assertTrue(colors[i][j][k] is uint, "check whether colors[" + i + "][" + j + "][" + k + "] is uint or not");
					}
				}
			}
		}

	}
}