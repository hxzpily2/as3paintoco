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
	public class DrawingTextEventTest 
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
		private var _eventList:Array = [DrawingTextEvent.START_DRAWING, DrawingTextEvent.STOP_DRAWING];
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		before function setUp():void
		{
			_dispatcher = new EventDispatcher();
		}
		
		
		test function constructor():void
		{
			var event:DrawingTextEvent;
			for each (var eventName:String in _eventList)
			{
				event = new DrawingTextEvent(eventName);
				assertTrue(event is DrawingTextEvent, "check whether new method returns instance of 'DrawingTextEvent'.");
				event = new DrawingTextEvent(eventName, false);
				assertTrue(!event.bubbles, "check whether instance's property of 'bubbles' is false or not");
				event = new DrawingTextEvent(eventName, true);
				assertTrue(event.bubbles, "check whether instance's property of 'bubbles' is true or not");
				event = new DrawingTextEvent(eventName, false, false);
				assertTrue(!event.cancelable, "check whether instance's property of 'cancelable' is false or not");
				event = new DrawingTextEvent(eventName, false, true);
				assertTrue(event.cancelable, "check whether instance's property of 'cancelable' is true or not");
				
				var tool:PenTool = new PenTool();
				event = new DrawingTextEvent(eventName, false, false, tool);
				assertSame(tool, event.tool, "check whether instance's property of 'tool' is tool or not.");
				
				event = new DrawingTextEvent(eventName, false, false, tool, 2, "test");
				assertEquals(event.charCode, 2, "check whether instance's property of 'charCode' is 10 or not");
				assertEquals(event.text, "test", "check whether instance's property of 'text' is 'test' or not");
			}
		}
		
		test function dispatch1():void
		{
			var firedEvent:DrawingTextEvent = new DrawingTextEvent(DrawingTextEvent.START_DRAWING);
			
			_dispatcher.addEventListener(DrawingTextEvent.START_DRAWING, async(function(event:DrawingTextEvent):void {
				assertSame(event, firedEvent, "check whether handler's parameter of event is dispached event or not.");
				assertSame(event.target, _dispatcher, "check whether handler's parameter of event has dispatcher instance named 'target' or not.");
			}, 1000));
			
			_dispatcher.dispatchEvent(firedEvent);
		}
		
		test function dispatch2():void
		{
			var firedEvent:DrawingTextEvent = new DrawingTextEvent(DrawingTextEvent.STOP_DRAWING);
			
			_dispatcher.addEventListener(DrawingTextEvent.STOP_DRAWING, async(function(event:DrawingTextEvent):void {
				assertSame(event, firedEvent, "check whether handler's parameter of event is dispached event or not.");
				assertSame(event.target, _dispatcher, "check whether handler's parameter of event has dispatcher instance named 'target' or not.");
			}, 1000));
			
			_dispatcher.dispatchEvent(firedEvent);
		}
		
	}
}