package jp.wxd.as3paintoco.tools 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import jp.wxd.as3paintoco.display.Stroke;
	import jp.wxd.RunTests;
	import org.libspark.as3unit.after;
	import org.libspark.as3unit.assert.*;
	import org.libspark.as3unit.before;
	import org.libspark.as3unit.test;
	import org.libspark.as3unit.test_expected;
	
	/**
	 * ...
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class TextToolTest 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		/** PenTool instance */
		private static var _tool:TextTool;
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		before function setUp():void
		{
			_tool = new TextTool();
		}
		
		test function constructor():void
		{
			assertTrue(_tool is TextTool, "check whether new method returns instance of 'TextTool'.");
		}
		
		test function properties():void
		{
			var cursor:Sprite = new Sprite();
			cursor.graphics.beginFill(0x000000);
			cursor.graphics.drawCircle(0, 0, 10);
			_tool.cursor = cursor;
			assertEquals(_tool.cursor, cursor, "check whether instance's property of 'cursor' is instance of Sprite or not.");
			
			var stroke:Stroke = new Stroke();
			_tool.stroke = stroke;
			assertEquals(_tool.stroke, stroke, "check whether instance's property of 'stroke' is instance of Stroke or not.");
			
			assertTrue(_tool.isDrawable, "check whether PenTool is drawable or not");
		}
		
		test function options():void
		{
			var options:Object = { font:"_等幅", size:20, color:0xFF0000, stage:RunTests.stage };
			_tool.options = options;
			assertEquals(_tool.options.font, options.font, "check whether _tool.options can hold font option");
			assertEquals(_tool.options.size, options.size, "check whether _tool.options can hold size option");
			assertEquals(_tool.options.color, options.color, "check whether _tool.options can hold color option");
			assertEquals(_tool.options.stage, options.stage, "check whether _tool.options can hold stage option");
		}
	}
}