package jp.wxd 
{
	import jp.wxd.as3paintoco.AllAs3drawingTests;
	import jp.wxd.color.AllColorTests;
	import jp.wxd.core.command.AllCommandTests;
	import org.libspark.as3unit.runners.Suite;
	
	/**
	 * ...
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class AllTests 
	{
		public static const RunWith:Class = Suite;
		public static const SuiteClasses:Array = [
			AllCommandTests, AllAs3drawingTests,
			AllColorTests
		];
	}
}