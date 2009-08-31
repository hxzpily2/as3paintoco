package jp.wxd 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import org.libspark.as3unit.runner.AS3UnitCore;
	
	/**
	 * as3Drawing RunTests
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class RunTests extends Sprite
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		private static var _stage:Stage;
		/** stage instance */
		public static function get stage():Stage
		{
			return _stage;
		}
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		/**
		 * constructor
		 */
		public function RunTests() 
		{
			_stage = stage;
			AS3UnitCore.main(AllTests);
		}	
	}	
}