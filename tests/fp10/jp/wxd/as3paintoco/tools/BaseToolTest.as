package jp.wxd.as3paintoco.tools 
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
	public class BaseToolTest 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		test_expected static const abstractError:Class = Error;
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		test function abstractError():void
		{
			new BaseTool();
		}
	}
}