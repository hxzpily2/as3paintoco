package jp.wxd.as3paintoco.display 
{
	import flash.display.Shape;
	import jp.wxd.as3paintoco.data.CanvasData;
	import org.libspark.as3unit.after;
	import org.libspark.as3unit.assert.*;
	import org.libspark.as3unit.before;
	import org.libspark.as3unit.test;
	import org.libspark.as3unit.test_expected;
	
	/**
	 * ...
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class CanvasTest 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		/**
		 * canvas width
		 */
		private static const CANVAS_WIDTH:Number = 400;
		
		/**
		 * canvas height
		 */
		private static const CANVAS_HEIGHT:Number = 300;
		
		/**
		 * Canvas instance
		 */
		private var _canvas:Canvas;
		
		/**
		 * CanvasData instance
		 */
		private var _canvasData:CanvasData;
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		before function setUp():void
		{
			_canvasData = new CanvasData({canvasWidth:CANVAS_WIDTH, canvasHeight:CANVAS_HEIGHT});
			_canvas = new Canvas(_canvasData); 
		}
		
		test function constructor():void
		{
			assertTrue(_canvas is Canvas, "check whether new method returns instance of 'Canvas'.");
		}
		
		test function initialize():void
		{
			_canvas.initialize();
			var layers:Layers = Layers(_canvas.base.getChildAt(1));
			assertTrue(layers is Layers, "check whether _canvas.base.getChildAt(1) is Layers.");
			assertEquals(layers.numChildren, 0, "check whether layers.numChildren is 0.");
		}
		
		test function lessBackground():void
		{
			var w:Number = CANVAS_WIDTH - 100;
			var h:Number = CANVAS_HEIGHT - 100;
			
			var background:Shape = new Shape();
			background.graphics.drawRect(0, 0, w, h);
			_canvas.background = background;
			assertEquals(_canvas.background.x, (CANVAS_WIDTH - w) / 2);
			assertEquals(_canvas.background.y, (CANVAS_HEIGHT - h) / 2);
		}
		
		test function horizontalOverBackground():void
		{
			var w:Number = CANVAS_WIDTH + 100;
			var h:Number = CANVAS_HEIGHT - 100;
			
			var background:Shape = new Shape();
			background.graphics.drawRect(0, 0, w, h);
			_canvas.background = background;
			assertEquals(_canvas.background.x, (CANVAS_WIDTH - w) / 2);
			assertEquals(_canvas.background.y, (CANVAS_HEIGHT - h) / 2);
		}
		
		test function verticalOverBackground():void
		{
			var w:Number = CANVAS_WIDTH - 100;
			var h:Number = CANVAS_HEIGHT + 100;
			
			var background:Shape = new Shape();
			background.graphics.drawRect(0, 0, w, h);
			_canvas.background = background;
			assertEquals(_canvas.background.x, (CANVAS_WIDTH - w) / 2);
			assertEquals(_canvas.background.y, (CANVAS_HEIGHT - h) / 2);
		}
		
		test function overBackground():void
		{
			var w:Number = CANVAS_WIDTH + 100;
			var h:Number = CANVAS_HEIGHT + 100;
			
			var background:Shape = new Shape();
			background.graphics.drawRect(0, 0, w, h);
			_canvas.background = background;
			assertEquals(_canvas.background.x, (CANVAS_WIDTH - w) / 2);
			assertEquals(_canvas.background.y, (CANVAS_HEIGHT - h) / 2);
		}
	}
}