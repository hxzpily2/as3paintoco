package jp.wxd.as3paintoco.display 
{
	import flash.events.Event;
	import org.libspark.as3unit.after;
	import org.libspark.as3unit.assert.*;
	import org.libspark.as3unit.before;
	import org.libspark.as3unit.test;
	import org.libspark.as3unit.test_expected;
	
	/**
	 * ...
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class LayersTest 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		/**
		 * layers instance
		 */
		private var _layers:Layers;
		
		/**
		 * layer instance
		 */
		private var _layer:Layer;
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		test function constructor():void
		{
			var layers:Layers = new Layers();
			assertTrue(layers is Layers, "check whether new method returns instance of 'Layers'.");
		}
		
		before function setUp():void
		{
			_layer = new Layer(10, 10);
			_layers = new Layers();
		}
		
		test function add():void
		{
			_layers.addEventListener(Event.ADDED, async(function(event:Event):void {
				assertTrue(true, "check whether add method complete.");
			}, 1000));
			_layers.add(_layer);
		}
		
		test function remove():void
		{
			_layers.addEventListener(Event.REMOVED, async(function(event:Event):void {
				assertTrue(true, "check whether remove method complete.");
			}, 1000));
			_layers.add(_layer);
			_layers.remove(_layer);
		}
	}
}