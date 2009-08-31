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
	public class DrawingTextEvent extends Event
	{
		//----------------------------------------------------------------------
		//  static properties
		//----------------------------------------------------------------------
		//------------------------------
		//  public static properties
		//------------------------------
		/**
		 * <p>テキスト入力のキーダウン時に送出されるイベント文字列を取得します。</p>
		 */
		public static const START_DRAWING:String = "startTextDrawing";
		
		/**
		 * <p>テキスト入力のキーアップ時に送出されるイベント文字列を取得します。</p>
		 */
		public static const STOP_DRAWING:String = "stopTextDrawing";
		
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		//------------------------------
		//  public properties
		//------------------------------
		private var _tool:ITool;
		/**
		 * <p>描画中のツールを取得します。</p>
		 */
		public function get tool():ITool
		{
			return _tool;
		}
		
		private var _charCode:uint;
		/**
		 * <p>入力された文字コードを取得します。</p>
		 */
		public function get charCode():uint
		{
			return _charCode;
		}
		
		private var _text:String;
		/*
		 * <p>入力されたターゲットに関するTextFieldのtextを取得します。</p>
		 */
		public function get text():String
		{
			return _text;
		}
		
		//----------------------------------------------------------------------
		//  methods
		//----------------------------------------------------------------------
		/**
		 * コンストラクタ
		 * @param	type
		 * @param	bubbles
		 * @param	cancelable
		 * @param	tool
		 * @param	charCode
		 * @param	text
		 */
		public function DrawingTextEvent(
			type:String, bubbles:Boolean = false, cancelable:Boolean = false,
			tool:ITool = null, charCode:uint = 0, text:String = null)
		{
			super(type, bubbles, cancelable);
			_tool = tool;
			_charCode = charCode;
			_text = text;
		} 
		//------------------------------
		//  override methods
		//------------------------------
		/**
		 * <p>DrawingTextEventの複製を返します。</p>
		 * @return
		 */
		override public function clone():Event 
		{ 
			return new DrawingTextEvent(type, bubbles, cancelable, _tool, _charCode, _text);
		} 
		
		/**
		 * <p>DrawingTextEventの文字列表記を返します。</p>
		 * @return
		 */
		override public function toString():String 
		{ 
			return formatToString("DrawingTextEvent", "type", "bubbles", "cancelable", "eventPhase", "tool", "charCode", "text"); 
		}	
	}
}