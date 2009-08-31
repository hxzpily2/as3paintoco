package jp.wxd.as3paintoco.data 
{
	import jp.wxd.as3paintoco.display.Layer;
	import jp.wxd.as3paintoco.tools.ITool;
	import jp.wxd.as3paintoco.tools.PenTool;
	import org.libspark.as3unit.after;
	import org.libspark.as3unit.assert.*;
	import org.libspark.as3unit.before;
	import org.libspark.as3unit.test;
	import org.libspark.as3unit.test_expected;
	
	/**
	 * ...
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class CanvasDataTest 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		test_expected static const nullArgumentError:Class = ArgumentError;
		test_expected static const lackArgumentError1:Class = ArgumentError;
		test_expected static const lackArgumentError2:Class = ArgumentError;
		test_expected static const lackArgumentError3:Class = ArgumentError;
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		test function constructor():void
		{
			var canvasData:CanvasData = new CanvasData( { canvasWidth:100, canvasHeight:80 } );
			assertEquals(canvasData.canvasWidth, 100, "check whether instance's property of 'canvasWidth' is 100 or not.");
			assertEquals(canvasData.canvasHeight, 80, "check whether instance's property of 'canvasHeight' is 80 or not.");
		}
		
		test function nullArgumentError():void
		{
			var canvasData:CanvasData = new CanvasData(null);
		}
		
		test function lackArgumentError1():void
		{
			var canvasData:CanvasData = new CanvasData({});
		}
		
		test function lackArgumentError2():void
		{
			var canvasData:CanvasData = new CanvasData({canvasWidth:100});
		}
		
		test function lackArgumentError3():void
		{
			var canvasData:CanvasData = new CanvasData({canvasHeight:80});
		}
		
		test function initialize():void
		{
			var canvasData:CanvasData = new CanvasData( { canvasWidth:100, canvasHeight:80 } );
			canvasData.initialize( { isActive:true, canvasWidth:50, canvasHeight:40 } );
			assertEquals(canvasData.isActive, true, "check whether instance's property of 'isActive' is true or not.");
			assertEquals(canvasData.canvasWidth, 50, "check whether instance's property of 'canvasWidth' is 50 or not.");
			assertEquals(canvasData.canvasHeight, 40, "check whether instance's property of 'canvasHeight' is 40 or not.");
			canvasData.initialize( { isActivate:false } );
			assertEquals(canvasData.isActive, false, "check whether instance's property of 'isActive' is false or not.");
		}
		
		test function properties():void
		{
			var canvasData:CanvasData = new CanvasData( { canvasWidth:100, canvasHeight:80 } );
			
			assertEquals(canvasData.activeLayer, null, "check whether instance's property of 'activeLayer' is null or not.");
			var layer:Layer = new Layer(100, 80);
			canvasData.activeLayer = layer;
			assertEquals(canvasData.activeLayer, layer, "check whether instance's property of 'activeLayer' is instance of Layer or not.");
			
			assertEquals(canvasData.activeTool, null, "check whether instance's property of 'activeTool' is null or not.");
			var tool:ITool = new PenTool();
			canvasData.activeTool = tool;
			assertEquals(canvasData.activeTool, tool, "check whether instance's property of 'activeTool' is instance of ITool or not.");
			
			assertEquals(canvasData.canvasHeight, 80, "check whether instance's property of 'canvasHeight' is 80 or not.");
			canvasData.canvasHeight = 160;
			assertEquals(canvasData.canvasHeight, 160, "check whether instance's property of 'canvasHeight' is 160 or not.");
			
			assertEquals(canvasData.canvasWidth, 100, "check whether instance's property of 'canvasWidth' is 100 or not.");
			canvasData.canvasWidth = 200;
			assertEquals(canvasData.canvasWidth, 200, "check whether instance's property of 'canvasWidth' is 200 or not.");
			
			assertEquals(canvasData.isActive, false, "check whether instance's property of 'isActive' is false or not.");
			canvasData.isActive = true;
			assertEquals(canvasData.isActive, true, "check whether instance's property of 'isActive' is true or not.");
		}
	}
}