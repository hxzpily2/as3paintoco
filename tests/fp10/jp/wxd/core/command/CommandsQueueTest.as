package jp.wxd.core.command 
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
	public class CommandsQueueTest 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		/**
		 * CommandsQueue instance
		 */
		private var _commandsQueue:CommandsQueue;
		
		/**
		 * string stack
		 */
		private var _stack:Array = [];
		
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		
		test function serialTrace():void
		{
			_commandsQueue = new CommandsQueue();
			_commandsQueue.push(
				new Commands(
					new QueueableMethodCommand(null, pushStack, "trace1")
				)
			);
			_commandsQueue.push(
				new Commands(
					function() { pushStack("trace2-1") },
					new QueueableMethodCommand(null, pushStack, "trace2-2"),
					new QueueableMethodCommand(null, pushStack, "trace2-3")
				)
			);
			_commandsQueue.push(
				new Commands(
					function() { pushStack("trace3-1") },
					new QueueableMethodCommand(null, pushStack, "trace3-2"),
					new QueueableMethodCommand(null, pushStack, "trace3-3"),
					new QueueableMethodCommand(null, pushStack, "trace3-4")
				)
			);
			_commandsQueue.push(
				new Commands(
					new QueueableMethodCommand(null, pushStack, "trace4-1"),
					new QueueableMethodCommand(null, pushStack, "trace4-2")
				)
			);
			_commandsQueue.addEventListener(Event.COMPLETE, async(function(event:Event):void {
				assertTrue(_stack.length == 10, "check queue count");
				assertEquals(_stack[0], "trace1", "check queue contents 1");
				assertEquals(_stack[1], "trace2-1", "check queue contents 2-1");
				assertEquals(_stack[2], "trace2-2", "check queue contents 2-2");
				assertEquals(_stack[3], "trace2-3", "check queue contents 2-3");
				assertEquals(_stack[4], "trace3-1", "check queue contents 3-1");
				assertEquals(_stack[5], "trace3-2", "check queue contents 3-2");
				assertEquals(_stack[6], "trace3-3", "check queue contents 3-3");
				assertEquals(_stack[7], "trace3-4", "check queue contents 3-4");
				assertEquals(_stack[8], "trace4-1", "check queue contents 4-1");
				assertEquals(_stack[9], "trace4-2", "check queue contents 4-2");
			}, 1000));
			_commandsQueue.execute();
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