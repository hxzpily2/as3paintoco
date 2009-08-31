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
	public class CommandsTest 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		/**
		 * Commands instance
		 */
		private var _commands:Commands;
		
		/**
		 * for Error test 1
		 */
		test_expected static const commandsTestError1:Class = ArgumentError;
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		
		test function commandsTestError1():void
		{
			_commands = new Commands(1);
		}
		
		test function constructor1():void
		{
			_commands = new Commands(new QueueableMethodCommand(null, trace, "hoge"));
			assertTrue(_commands is Commands, "check whether new method returns instance of 'Commands' or not.");
			assertEquals(_commands.content.length, 1, "check content.length is 1 or not.");
		}
		
		test function constructor2():void
		{
			_commands = new Commands(new QueueableMethodCommand(null, trace, "hoge"), new QueueableMethodCommand(null, trace, "fugo"));
			assertTrue(_commands is Commands, "check whether new method returns instance of 'Commands' or not.");
			assertEquals(_commands.content.length, 2, "check content.length is 2 or not.");
		}
		
	}
}