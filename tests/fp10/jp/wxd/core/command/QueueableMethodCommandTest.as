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
	public class QueueableMethodCommandTest 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		/**
		 * command
		 */
		private var _command:QueueableMethodCommand;
		
		/**
		 * string stack
		 */
		private var _stack:Array = [];
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		test function constructor():void
		{
			_command = new QueueableMethodCommand(null, pushStack, "test");
			assertTrue(_command is QueueableMethodCommand, "check whether new method returns instance of 'QueueableMethodCommand'.");
			_command.addEventListener(Event.COMPLETE, async(function(event:Event):void {
				assertEquals(_stack.length, 1, "check whether length of '_stack' is '1' or not.");
				assertEquals(_stack[0], "test", "check whether contents of '_stack[0]' is 'test' or not.");
			}, 1000));
			_command.execute();
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