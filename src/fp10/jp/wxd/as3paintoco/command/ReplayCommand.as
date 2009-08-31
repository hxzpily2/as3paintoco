/*
Licensed under the MIT License

Copyright (c) 2009 naoto koshikawa

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

http://wxd.jp/as3paintoco/
*/
package jp.wxd.as3paintoco.command 
{
	import flash.utils.getTimer;
	import jp.wxd.core.command.QueueableMethodCommand;
	
	/**
	 * <p>ReplayCommandクラスは、ReplayCommandsクラスに登録するクラスです。描画の１つ１つの処理を表すコマンドです。</p>
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class ReplayCommand extends QueueableMethodCommand
	{
		//----------------------------------------------------------------------
		//  static properties
		//----------------------------------------------------------------------	
		//------------------------------
		//  private static properties
		//------------------------------
		/**
		 * previouse getTimer()'s value.
		 */
		private static var _prevTime:Number;
		
		//----------------------------------------------------------------------
		//  static methods
		//----------------------------------------------------------------------
		//------------------------------
		//  static initializer
		//------------------------------
		{
			ReplayCommand._prevTime = getTimer();
		}
		//------------------------------
		//  public static methods
		//------------------------------
		/**
		 * <p>コマンドの間隔感知タイマーを初期化します。</p>
		 */
		public static function init():void
		{
			_prevTime = getTimer();
		}
		
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		//------------------------------
		//  public properties
		//------------------------------
		private var _interval:Number;
		/**
		 * <p>前のコマンド登録時からこのコマンド登録時までに経過した時間(msec)を取得します。</p>
		 */
		public function get interval():Number
		{
			return _interval;
		}
		
		//----------------------------------------------------------------------
		//  methods
		//----------------------------------------------------------------------
		//------------------------------
		//  public methods
		//------------------------------
		/**
		 * constructor
		 */
		public function ReplayCommand(scope:*, method:Function, parameter:* = null)
		{
			_interval = getTimer() - ReplayCommand._prevTime;
			ReplayCommand._prevTime = getTimer();
			super(scope, method, parameter);
		}
	}
}