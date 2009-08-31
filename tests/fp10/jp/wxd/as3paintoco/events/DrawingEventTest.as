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
	public class DrawingEventTest 
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
		private var _eventList:Array = [DrawingEvent.MOVE_DRAWING, DrawingEvent.START_DRAWING, DrawingEvent.STOP_DRAWING];
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		before function setUp():void
		{
			_dispatcher = new EventDispatcher();
		}
		
		
		test function constructor():void
		{
			var event:DrawingEvent;
			for each (var eventName:String in _eventList)
			{
				event = new DrawingEvent(eventName);
				assertTrue(event is DrawingEvent, "check whether new method returns instance of 'DrawingEvent'.");
				event = new DrawingEvent(eventName, false);
				assertTrue(!event.bubbles, "check whether instance's property of 'bubbles' is false or not.");
				event = new DrawingEvent(eventName, true);
				assertTrue(event.bubbles, "check whether instance's property of 'bubbles' is true or not.");
				event = new DrawingEvent(eventName, false, false);
				assertTrue(!event.cancelable, "check whether instance's property of 'cancelable' is false or not.");
				event = new DrawingEvent(eventName, false, true);
				assertTrue(event.cancelable, "check whether instance's property of 'cancelable' is true or not.");
				
				var tool:PenTool = new PenTool();
				event = new DrawingEvent(eventName, false, false, tool);
				assertSame(tool, event.tool, "check whether instance's property of 'tool' is tool or not.");
				
				event = new DrawingEvent(eventName, false, false, tool, 10, 20);
				assertEquals(event.x, 10, "check whether instance's property of 'x' is 10 or not.");
				assertEquals(event.y, 20, "check whether instance's property of 'y' is 20 or not.");
			}
		}
		
		test function dispatch1():void
		{
			var firedEvent:DrawingEvent = new DrawingEvent(DrawingEvent.START_DRAWING);
			
			_dispatcher.addEventListener(DrawingEvent.START_DRAWING, async(function(event:DrawingEvent):void {
				assertSame(event, firedEvent, "check whether handler's parameter of event is dispached event or not.");
				assertSame(event.target, _dispatcher, "check whether handler's parameter of event has dispatcher instance named 'target' or not.");
			}, 1000));
			
			_dispatcher.dispatchEvent(firedEvent);
		}
		
		test function dispatch2():void
		{
			var firedEvent:DrawingEvent = new DrawingEvent(DrawingEvent.STOP_DRAWING);
			
			_dispatcher.addEventListener(DrawingEvent.STOP_DRAWING, async(function(event:DrawingEvent):void {
				assertSame(event, firedEvent, "check whether handler's parameter of event is dispached event or not.");
				assertSame(event.target, _dispatcher, "check whether handler's parameter of event has dispatcher instance named 'target' or not.");
			}, 1000));
			
			_dispatcher.dispatchEvent(firedEvent);
		}
		
		test function dispatch3():void
		{
			var firedEvent:DrawingEvent = new DrawingEvent(DrawingEvent.MOVE_DRAWING);
			
			_dispatcher.addEventListener(DrawingEvent.MOVE_DRAWING, async(function(event:DrawingEvent):void {
				assertSame(event, firedEvent, "check whether handler's parameter of event is dispached event or not.");
				assertSame(event.target, _dispatcher, "check whether handler's parameter of event has dispatcher instance named 'target' or not.");
			}, 1000));
			
			_dispatcher.dispatchEvent(firedEvent);
		}
	}
}