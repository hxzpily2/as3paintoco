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
package jp.wxd.as3paintoco.events 
{
	import flash.events.Event;
	import jp.wxd.as3paintoco.tools.ITool;
	
	/**
	 * <p>描画中に送出されるイベントです。</p>
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class DrawingEvent extends Event
	{
		//----------------------------------------------------------------------
		//  static properties
		//----------------------------------------------------------------------
		//------------------------------
		//  public static properties
		//------------------------------
		/**
		 * <p>描画の開始時に送出されるイベント文字列を取得します。</p>
		 */
		public static const START_DRAWING:String = "startDrawing";
		
		/**
		 * <p>描画中に送出されるイベント文字列を取得します。</p>
		 */
		public static const MOVE_DRAWING:String = "moveDrawing";
		
		/**
		 * <p>描画終了時に送出されるイベント文字列を取得します。</p>
		 */
		public static const STOP_DRAWING:String = "stopDrawing";
		
		//------------------------------
		//  public properties
		//------------------------------
		private var _tool:ITool;
		/**
		 * <p>描画中のIToolインスタンスを取得します。</p>
		 */
		public function get tool():ITool
		{
			return _tool;
		}
		
		private var _x:Number;
		/**
		 * <p>描画中のキャンバスのx座標を取得します。</p>
		 */
		public function get x():Number
		{
			return _x;
		}
		
		private var _y:Number;
		/**
		 * <p>描画中のキャンパスのy座標を取得します。</p>
		 */
		public function get y():Number
		{
			return _y;
		}
		
		//----------------------------------------------------------------------
		//  methods
		//----------------------------------------------------------------------
		//------------------------------
		//  override methods
		//------------------------------
		/**
		 * <p>DrawingEventの複製を返します。</p>
		 * @return
		 */
		override public function clone():Event 
		{ 
			return new DrawingEvent(type, bubbles, cancelable, _tool, _x, _y);
		} 
		
		/**
		 * <p>DrawingEventの文字列表記を返します。</p>
		 * @return
		 */
		override public function toString():String 
		{ 
			return formatToString("DrawingEvent", "type", "bubbles", "cancelable", "eventPhase", "tool", "x", "y"); 
		}
		
		//------------------------------
		//  public methods
		//------------------------------
		/**
		 * <p>新しいDrawingEventを作成します。</p>
		 * @param	type
		 * @param	bubbles
		 * @param	cancelable
		 * @param	tool
		 * @param	x
		 * @param	y
		 */
		public function DrawingEvent(
			type:String, bubbles:Boolean = false, cancelable:Boolean = false,
			tool:ITool = null, x:Number = 0, y:Number = 0)
		{
			super(type, bubbles, cancelable);
			_tool = tool;
			_x = x;
			_y = y;
		} 
	}
}