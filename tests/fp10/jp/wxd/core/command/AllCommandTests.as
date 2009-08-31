package jp.wxd.core.command 
{
	import org.libspark.as3unit.runners.Suite;
	
	/**
	 * ...
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class AllCommandTests 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		public static const RunWith:Class = Suite;
		public static const SuiteClasses:Array = [
			CommandsTest, CommandsQueueTest, MethodCommandTest,
			QueueableMethodCommandTest, CommandStackTest
		];
	}
}