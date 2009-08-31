package jp.wxd.core.command 
{
	/**
	 * for test
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	class RedoableCommand implements IRedoableCommand
	{
		private var _angle:Number;
		public function get angle():Number
		{
			return _angle;
		}
		
		public function RedoableCommand():void
		{
			_angle = 0;
		}
		
		public function execute():void
		{
			_angle++;
		}
		
		public function undo():void
		{
			_angle--;
		}
		
		public function redo():void
		{
			execute();
		}
	}
}