package jp.wxd.as3paintoco.command 
{
	import jp.wxd.as3paintoco.display.Layer;
	import jp.wxd.as3paintoco.display.Stroke;
	import jp.wxd.as3paintoco.tools.PenTool;
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
	public class MouseDownCommandTest 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		/**
		 * stroke
		 */
		private var _stroke:Stroke;
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		before function setUp():void
		{	
			var layer:Layer = new Layer(100, 100);
			RunTests.stage.addChild(layer);
			layer.addChild(_stroke = new Stroke());
		}
		
		test function constructor():void
		{
			var mouseDownCommand = new MouseDownCommand(new PenTool(), 10, 10, _stroke);
			assertTrue(mouseDownCommand is MouseDownCommand, "check whether new method returns instance of 'MouseDownCommand'.");
		}
		
		test function execute():void
		{
			var mouseDownCommand = new MouseDownCommand(new PenTool(), 10, 10, _stroke);
			mouseDownCommand.execute();
		}
		
		test function undo():void
		{
			var mouseDownCommand = new MouseDownCommand(new PenTool(), 10, 10, _stroke);
			mouseDownCommand.execute();
			mouseDownCommand.undo();
		}
		
		test function redo():void
		{
			var mouseDownCommand = new MouseDownCommand(new PenTool(), 10, 10, _stroke);
			mouseDownCommand.execute();
			mouseDownCommand.redo();
		}
	}
}