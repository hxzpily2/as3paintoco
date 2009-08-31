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
	 * <p>描画中にフォーカスが変更された際に送出されるイベントです。</p>
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class DrawingFocusChange extends Event 
	{
		//----------------------------------------------------------------------
		//  static properties
		//----------------------------------------------------------------------
		//------------------------------
		//  static properties
		//------------------------------
		/**
		 * <p>マウスのフォーカス変更時に送出されるイベント文字列を取得します。</p>
		 */
		public static const MOUSE_FOCUS_CHANGE:String = "drawingMouseFocusChange"
		
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
		
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		//------------------------------
		//  override methods
		//------------------------------
		/**
		 * ｓ
		 * @return
		 */
		public override function clone():Event 
		{ 
			return new DrawingFocusChange(type, bubbles, cancelable, _tool);
		} 
		
		/**
		 * <p>DrawingFocusChangeの文字列表記を返します。</p>
		 * @return
		 */
		public override function toString():String 
		{ 
			return formatToString("DrawingFocusChange", "type", "bubbles", "cancelable", "eventPhase", "tool"); 
		}
		
		//----------------------------------------------------------------------
		//  methods
		//----------------------------------------------------------------------
		//------------------------------
		//  public methods
		//------------------------------
		/**
		 * <p>新しいDrawingFocusChangeを作成します。</p>
		 * @param	type
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function DrawingFocusChange(type:String, bubbles:Boolean = false, cancelable:Boolean = false,
			tool:ITool = null) 
		{ 
			super(type, bubbles, cancelable);
			_tool = tool;
		} 
		

	}
}