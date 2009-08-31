package jp.wxd.as3paintoco.display 
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import org.libspark.as3unit.after;
	import org.libspark.as3unit.assert.*;
	import org.libspark.as3unit.before;
	import org.libspark.as3unit.test;
	import org.libspark.as3unit.test_expected;
	
	/**
	 * ...
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class StrokeTest 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		/**
		 * Stroke isntance
		 */
		private var _stroke:Stroke;
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		before function setUp():void
		{
			var bitmapData:BitmapData = new BitmapData(2, 2);
			bitmapData.setPixel(0, 0, 0x000000);
			bitmapData.setPixel(1, 1, 0x000000);
			_stroke = new Stroke(bitmapData);
		}
		
		test function constructor1():void
		{
			var stroke:Stroke = new Stroke();
			assertTrue(stroke is Stroke, "check whether new method returns instance of 'Stroke'.");
		}
		
		test function constructor2():void
		{
			assertTrue(_stroke is Stroke, "check whether new method returns instance of 'Stroke'.");
		}
		
		test function clone():void
		{
			var cloened:Stroke = _stroke.clone();
			assertNotSame(_stroke, cloened, "check whether clone method returns different Stroke or not.");
		}
		
		test function adjustChildren():void
		{
			var shape:Shape = new Shape();
			shape.graphics.beginFill(0xFF00000);
			shape.graphics.drawRect( -10, -10, 20, 20);
			_stroke.addChild(shape);
			
			assertEquals(_stroke.getBounds(_stroke), new Rectangle(-10, -10, 20, 20));
			_stroke.adjustChildren();
			assertEquals(_stroke.getBounds(_stroke), new Rectangle(0, 0, 20, 20));
		}
	}
}