package jp.wxd.core.command 
{
	import org.libspark.as3unit.after;
	import org.libspark.as3unit.assert.*;
	import org.libspark.as3unit.before;
	import org.libspark.as3unit.test;
	import org.libspark.as3unit.test_expected;
	
	/**
	 * ...
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class MethodCommandTest 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		/**
		 * MethodCommand
		 */
		private var _command:MethodCommand;
		
		/**
		 * string stack
		 */
		private var _stack:Array = [];
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		test function constructor1():void
		{
			var closure:Function = function(message:String)
			{
				return message;
			};
			_command = new MethodCommand(this, closure, "closure");
			assertTrue(_command is MethodCommand, "check whether new method returns instance of 'MethodCommand'.");
		}
		
		test function constructor2():void
		{
			_command = new MethodCommand(null, pushStack, "instance method");
			assertTrue(_command is MethodCommand, "check whether new method returns instance of 'MethodCommand'.");
		}
		
		test function passClosure():void
		{
			var closure:Function = function(message:String)
			{
				return message;
			};
			_command = new MethodCommand(this, closure, "closure");
			_command.execute();
			assertEquals(_command.result, "closure", "check whether executes closure method or not");
		}
		
		test function passInstanceMethod():void
		{
			_command = new MethodCommand(null, pushStack, "instance method");
			_command.execute();
			assertEquals(_command.result, true, "check whether executes instance method or not");
			assertEquals(_stack.length, 1, "check whether length of '_stack' is '1' or not.");
		}
		
		/**
		 * push stack
		 * @param	message
		 */
		private function pushStack(message:String):Boolean
		{
			_stack.push(message);
			return true;
		}
	}
}