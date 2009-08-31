package jp.wxd.as3paintoco.events 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import jp.wxd.as3paintoco.tools.PenTool;
	import org.libspark.as3unit.after;
	import org.libspark.as3unit.assert.*;
	import org.libspark.as3unit.before;
	import org.libspark.as3unit.test;
	
	/**
	 * ...
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class DrawingFocusChangeTest 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		/**
		 * dispatcher
		 */
		private var _dispatcher:EventDispatcher;
		
		/**
		 * event list
		 */
		private var _eventList:Array = [DrawingFocusChange.MOUSE_FOCUS_CHANGE];
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		before function setUp():void
		{
			_dispatcher = new EventDispatcher();
		}
		
		
		test function constructor():void
		{
			var event:DrawingFocusChange;
			for each (var eventName:String in _eventList)
			{
				event = new DrawingFocusChange(eventName);
				assertTrue(event is DrawingFocusChange, "check whether new method returns instance of 'DrawingEvent'.");
				event = new DrawingFocusChange(eventName, false);
				assertTrue(!event.bubbles, "check whether instance's property of 'bubbles' is false or not.");
				event = new DrawingFocusChange(eventName, true);
				assertTrue(event.bubbles, "check whether instance's property of 'bubbles' is true or not.");
				event = new DrawingFocusChange(eventName, false, false);
				assertTrue(!event.cancelable, "check whether instance's property of 'cancelable' is false or not.");
				event = new DrawingFocusChange(eventName, false, true);
				assertTrue(event.cancelable, "check whether instance's property of 'cancelable' is true or not.");
				
				var tool:PenTool = new PenTool();
				event = new DrawingFocusChange(eventName, false, false, tool);
				assertSame(tool, event.tool, "check whether instance's property of 'tool' is tool or not.");
			}
		}
		
		test function dispatch1():void
		{
			var firedEvent:DrawingFocusChange = new DrawingFocusChange(DrawingFocusChange.MOUSE_FOCUS_CHANGE);
			
			_dispatcher.addEventListener(DrawingFocusChange.MOUSE_FOCUS_CHANGE, async(function(event:DrawingFocusChange):void {
				assertSame(event, firedEvent, "check whether handler's parameter of event is dispached event or not.");
				assertSame(event.target, _dispatcher, "check whether handler's parameter of event has dispatcher instance named 'target' or not.");
			}, 1000));
			
			_dispatcher.dispatchEvent(firedEvent);
		}
	}
}