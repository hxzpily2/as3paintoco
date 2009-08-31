package jp.wxd.as3paintoco.tools 
{
	import flash.display.Sprite;
	import jp.wxd.as3paintoco.display.Stroke;
	import org.libspark.as3unit.after;
	import org.libspark.as3unit.assert.*;
	import org.libspark.as3unit.before;
	import org.libspark.as3unit.test;
	import org.libspark.as3unit.test_expected;
	
	/**
	 * ...
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class SelectToolTest 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		/**
		 * ITool instance
		 */
		private var _tool:ITool;
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		before function setUp():void
		{
			_tool = new SelectTool();
		}
		
		test function constructor():void
		{
			assertTrue(_tool is SelectTool, "check whether new method returns instance of 'SelectTool'.");
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
			
			assertFalse(_tool.isDrawable, "check whether SelectTool is not drawable or drawable");
		}
	}
}