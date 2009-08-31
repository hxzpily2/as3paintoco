package jp.wxd.as3paintoco.command 
{
	import flash.events.Event;
	import jp.wxd.core.command.Commands;
	import org.libspark.as3unit.after;
	import org.libspark.as3unit.assert.*;
	import org.libspark.as3unit.before;
	import org.libspark.as3unit.test;
	import org.libspark.as3unit.test_expected;
	
	/**
	 * ReplayQueue Test
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class ReplayQueueTest 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		/**
		 * string stack
		 */
		private var _stack:Array = [];
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		test function constructor():void
		{
			var replayQueue:ReplayQueue = new ReplayQueue();
			assertTrue(replayQueue is ReplayQueue, "new ReplayQueue");
		}
		
		test function serialTrace():void
		{
			var replayQueue:ReplayQueue = new ReplayQueue();
			replayQueue.push(
				new Commands(
					new ReplayCommand(null, pushStack, "trace1")
				)
			);
			replayQueue.push(
				new Commands(
					new ReplayCommand(null, pushStack, "trace2")
				)
			);
			replayQueue.push(
				new Commands(
					new ReplayCommand(null, pushStack, "trace3")
				)
			);
			replayQueue.addEventListener(Event.COMPLETE, async(function(event:Event):void {
				assertTrue(_stack.length == 3, "check whether length of '_stack' is '3' or not.");
				assertEquals(_stack[0], "trace1", "check whether contents of '_stack[0]' is 'trace1' or not.");
				assertEquals(_stack[1], "trace2", "check whether contents of '_stack[1]' is 'trace2' or not.");
				assertEquals(_stack[2], "trace3", "check whether contents of '_stack[2]' is 'trace3' or not.");
			}, 1000));
			replayQueue.replay();
		}
		
		/**
		 * push stack
		 */
		private function pushStack(message:String):void
		{
			_stack.push(message);
		}
	}
}