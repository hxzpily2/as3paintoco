package jp.wxd.as3paintoco.core 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import jp.wxd.as3paintoco.core.CanvasCore;
	import jp.wxd.as3paintoco.data.CanvasData;
	import jp.wxd.as3paintoco.display.Canvas;
	import jp.wxd.as3paintoco.tools.PenTool;
	import jp.wxd.core.command.CommandStack;
	import org.libspark.as3unit.after;
	import org.libspark.as3unit.assert.*;
	import org.libspark.as3unit.before;
	import org.libspark.as3unit.test;
	import org.libspark.as3unit.test_expected;

	/**
	 * Canvas Test
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class CanvasCoreTest 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		/** Canvas width */
		private static const CANVAS_WIDTH:Number = 300;
		
		/** Canvas height */
		private static const CANVAS_HEIGHT:Number = 200;
		
		/** Canvas instance */
		private static var _canvasCore:CanvasCore;
		
		test_expected static const canvasError1:Class = Error;
		test_expected static const canvasError2:Class = Error;
		test_expected static const canvasError3:Class = Error;
		test_expected static const canvasError4:Class = Error;
		test_expected static const canvasError5:Class = Error;
		test_expected static const canvasError6:Class = Error;
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		before function setUp():void
		{
			_canvasCore = new CanvasCore(CANVAS_WIDTH, CANVAS_HEIGHT);
		}
		
		test function constructor():void
		{
			assertTrue(_canvasCore is CanvasCore, 
				"check whether new CanvasCore(" + CANVAS_WIDTH + "," 
				+ CANVAS_HEIGHT + ") returns CanvasCore Object or not"
			);
		}
		
		test function canvasError1():void
		{
			_canvasCore = new CanvasCore(0, 0);
		}
		
		test function canvasError2():void
		{
			_canvasCore = new CanvasCore(0, 10);
		}
		
		test function canvasError3():void
		{
			_canvasCore = new CanvasCore(10, 0);
		}
		
		test function canvasError4():void
		{
			_canvasCore = new CanvasCore(CanvasData.CANVAS_SIZE_MAX + 1, 10);
		}
		
		test function canvasError5():void
		{
			_canvasCore = new CanvasCore(10, CanvasData.CANVAS_SIZE_MAX + 1);
		}
		
		test function canvasError6():void
		{
			_canvasCore = new CanvasCore(CanvasData.CANVAS_SIZE_MAX, CanvasData.CANVAS_SIZE_MAX);
		}
		
		test function properties():void
		{
			var canvas:Canvas = _canvasCore.canvas;
			assertTrue(canvas is Canvas, "check whether instances' property of 'canvas' is instance of Canvas or not.");
			
			var stack:CommandStack = _canvasCore.stack;
			assertTrue(stack is CommandStack, "check whether instances' property of 'canvas' is instance of CommandStack or not.");
		}
		
		test function applyTool():void
		{
			_canvasCore.applyTool(new PenTool());
		}
	}
}