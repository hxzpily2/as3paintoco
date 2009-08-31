package jp.wxd.as3paintoco.tools 
{
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
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
	public class PenToolTest 
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
			_tool = new PenTool();
		}
		
		test function constructor():void
		{
			assertTrue(_tool is PenTool, "check whether new method returns instance of 'PenTool'.");
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
			var options:Object = {
				thickness:5,
				color:0x333333,
				alpha: 0.8,
				pixelHinting: false,
				scaleMode: LineScaleMode.HORIZONTAL,
				caps: CapsStyle.SQUARE,
				joints: JointStyle.BEVEL,
				miterLimit: 5,
				filters:[]
			};
			_tool.options = options;
			assertEquals(_tool.options.thickness, options.thickness, "check whether _tool.options can hold thickness option");
			assertEquals(_tool.options.color, options.color, "check whether _tool.options can hold color option");
			assertEquals(_tool.options.alpha, options.alpha, "check whether _tool.options can hold alpha option");
			assertEquals(_tool.options.pixelHinting, options.pixelHinting, "check whether _tool.options can hold pixelHinting option");
			assertEquals(_tool.options.scaleMode, options.scaleMode, "check whether _tool.options can hold scaleMode option");
			assertEquals(_tool.options.caps, options.caps, "check whether _tool.options can hold caps option");
			assertEquals(_tool.options.joints, options.joints, "check whether _tool.options can hold joints option");
			assertEquals(_tool.options.filters, options.filters, "check whether _tool.options can hold filters option");
		}
		
		test function draw():void
		{
			var options:Object = { thickness:2, color:0xFF0000 };
			_tool.options = options;
			
			var stroke:Stroke = new Stroke();
			_tool.stroke = stroke;
			
			assertEquals(_tool.stroke.getBounds(
				_tool.stroke), new Rectangle(0, 0, 0, 0),"check whether _tool.stroke.getBounds is correct");
			_tool.mouseDown(0, 0);
			assertEquals(_tool.stroke.getBounds(
				_tool.stroke), new Rectangle(0, 0, 0, 0),"check whether _tool.stroke.getBounds is correct after excuting mouseDown");
			_tool.mouseMove(3, 1);
			assertEquals(_tool.stroke.getBounds(
				_tool.stroke), new Rectangle(-options.thickness / 2, -options.thickness / 2, options.thickness + 3, options.thickness + 1),
				"check whether _tool.stroke.getBounds is correct after excuting mouseMove");
			_tool.mouseUp(3, 4);
			assertEquals(_tool.stroke.getBounds(
				_tool.stroke), new Rectangle(0, 0, options.thickness + 3, options.thickness + 1 + 3),
				"check whether _tool.stroke.getBounds is correct after excuting mouseUp");
		}
	}
}