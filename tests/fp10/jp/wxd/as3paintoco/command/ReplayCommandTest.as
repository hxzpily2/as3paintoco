package jp.wxd.as3paintoco.command 
{
	import org.libspark.as3unit.after;
	import org.libspark.as3unit.assert.*;
	import org.libspark.as3unit.before;
	import org.libspark.as3unit.test;
	import org.libspark.as3unit.test_expected;
	
	/**
	 * ReplayCommand Test
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class ReplayCommandTest 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		test function constructor():void
		{
			var replayComamnd:ReplayCommand = new ReplayCommand(null, trace, "ReplayCommmandTest.constructor");
			assertTrue(replayComamnd is ReplayCommand, "new ReplayCommand");
		}
	}
}