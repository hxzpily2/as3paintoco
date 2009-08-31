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
	public class CommandStackTest 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		/**
		 * command
		 */
		private var _commandStack:CommandStack;
		
		/**
		 * string stack
		 */
		private var _stack:Array = [];
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		test function constructor():void
		{
			_commandStack = new CommandStack();
			assertTrue(_commandStack is CommandStack, "check whether new method returns instance of 'CommandStack'.");
			assertFalse(_commandStack.hasNext, "check whether empty instance's property of hasNext indicate false or not.");
			assertFalse(_commandStack.hasPrevious, "check whether empty instance's property of hasPrevious indicate false or not.");
		}
		
		test function passPrevious():void
		{
			var methodCommand:RedoableCommand = new RedoableCommand();
			_commandStack = new CommandStack();
			_commandStack.push(methodCommand);
			assertFalse(_commandStack.hasNext, "check whether instance after executing 'push', property of hasNext is false or not.");
			assertTrue(_commandStack.hasPrevious, "check whether instance after executing 'push', property of hasPrevious is true or not.");
			assertSame(_commandStack.previous, methodCommand, "check whether instance's property of 'previous' is instance of 'RedoableCommand' pushed previously.");
			assertTrue(_commandStack.hasNext, "check whether instance after executing 'previous', property of hasNext is true or not.");
			assertFalse(_commandStack.hasPrevious, "check whether instance after executing 'previous', property of hasPrevious is false or not.");
		}
		
		test function passNext():void
		{
			var command1:RedoableCommand = new RedoableCommand();
			var command2:RedoableCommand = new RedoableCommand();
			_commandStack = new CommandStack();
			command1.execute();
			_commandStack.push(command1);
			command2.execute();
			_commandStack.push(command2);
			assertFalse(_commandStack.hasNext, "check whether instance after executing 'push', property of hasNext is false or not.");
			assertTrue(_commandStack.hasPrevious, "check whether instance after executing 'push', property of hasPrevious is true or not.");
			assertSame(_commandStack.previous, command2, "check whether instance's property of 'previous' is instance of 'RedoableCommand' pushed previously.");
			assertSame(_commandStack.previous, command1, "check whether instance's property of 'previous' is instance of 'RedoableCommand' pushed previously.");
			assertSame(_commandStack.next, command1, "check whether instance's property of 'next' is instance of 'RedoableCommand' pushed previously.");
			assertTrue(_commandStack.hasPrevious, "check whether instance after executing 'next', property of hasPrevious is true or not.");
			assertTrue(_commandStack.hasNext, "check whether instance after executing 'next', property of hasNext is true or not.");
		}
	}
}