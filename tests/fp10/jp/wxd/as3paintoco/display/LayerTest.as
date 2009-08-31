package jp.wxd.as3paintoco.display 
{
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
	public class LayerTest 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		test_expected static const zeroArgumentError:Class = ArgumentError;
		test_expected static const negativeArgumentError:Class = ArgumentError;
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		test function constructor():void
		{
			var layer:Layer = new Layer(10, 10);
			assertTrue(layer is Layer, "check whether new method returns instance of 'Layer'.");
			assertEquals(layer.index, -1, "check whether default index is -1.");
		}
		
		test function zeroArgumentError():void
		{
			var layer:Layer = new Layer(0, 0);
		}
		
		test function negativeArgumentError():void
		{
			var layer:Layer = new Layer(-10, -10);
		}
		
		test function addChild():void
		{
			var layer:Layer = new Layer(10, 10);
			RunTests.stage.addChild(layer);
			assertTrue(0 < layer.index, "check whether instance's property of 'index' is positive integer.");
		}
		
		test function removeChild():void
		{
			var layer:Layer = new Layer(10, 10);
			RunTests.stage.addChild(layer);
			RunTests.stage.removeChild(layer);
			assertEquals(layer.index, -1, "check whether instance's property of 'index' is negative integer.");
		}
		
		test function destructor():void
		{
			var layer:Layer = new Layer(10, 10);
			RunTests.stage.addChild(layer);
			layer.destructor();
			assertEquals(layer.index, -1, "check whether instance's property of 'index' is negative integer.");
		}
	}
}