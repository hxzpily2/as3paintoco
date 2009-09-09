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
package jp.wxd.as3paintoco.tools 
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.FocusEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import jp.wxd.as3paintoco.display.Stroke;
	/**
	 * 標準的なテキストツールです。
	 * @author	Copyright (C) naoto koshikawa <naoto5959[at]gmail.com>
	 */
	public class TextTool extends BaseTool implements ITool
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		/**
		 * 新たに作成するテキストフィールドを表します。
		 */
		private var _displayObject:TextField;
		
		//------------------------------
		//  getter/setter
		//------------------------------
		/**
		 * ツールが描写ツールであるかどうかを表します
		 */
		override public function get isDrawable():Boolean
		{
			return true;
		}
		
		/** @private */
		override public function set options(value:Object):void
		{
			if (value && value.font is String) _options.font = value.font;
			if (value && value.size is Number) _options.size = value.size;
			if (value && value.color is uint) _options.color = value.color;
			if (value && value.stage && value.stage is Stage) _options.stage = value.stage;
			if (value && value.filters is Array) _options.filters = value.filters;
		}
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		/**
		 * constructor
		 */
		public function TextTool() 
		{
			super();
		}
		
		/**
		 * ツールがロードされた際に一度だけ呼び出されます。(IToolを実装したクラスのコンストラクタ内から呼び出します)
		 * 一度だけ初期化を行う際にはこのメソッドを利用します。
		 */
		override public function configure():void
		{
			_options = {
				font:"_ゴシック",
				size:12,
				color:0x000000,
				width:null,
				height:null,
				maxChars:30,
				multiline:true,
				filters:[]
			};
		}
		
		/**
		 * KeyをUpした際に呼び出されます。
		 * @param	charCode	KeyをUpした際の対象キーの文字コードを表します。
		 * @param	text	KeyUpにより変更となったtextがあれば指定します。
		 */
		override public function keyUp(charCode:uint, text:String = null):void
		{
			_displayObject.text = text;
		}

		/**
		 * MouseをDownした際に呼び出されます。
		 * @param	x	マウスをダウンした際のキャンパス上のx座標を表します。
		 * @param	y	マウスをダウンした際のキャンパス上のy座標を表します。
		 */
		override public function mouseDown(x:Number, y:Number):void
		{
			var format:TextFormat = new TextFormat(_options.font, _options.size, _options.color, false, false, false, "", "", TextFormatAlign.LEFT, 0, 0, 0, 0);
			_stroke.addChildAt(_displayObject = new TextField(), 0);
			_stroke.x = x;
			_stroke.y = y;
			
			_displayObject.defaultTextFormat = format;
			_displayObject.type = TextFieldType.INPUT;
			_displayObject.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, displayObject_MouseFocusChangeHandler);
			
			_displayObject.maxChars = _options.maxChars;
			_displayObject.multiline = _options.multiline;
			_displayObject.autoSize = TextFieldAutoSize.LEFT;
			_displayObject.selectable = true;
		}

		/**
		 * MouseをUpした際に呼び出されます。
		 * @param	x	マウスをダブルクリックした際のキャンパス上のx座標を表します。
		 * @param	y	マウスをダブルクリックした際のキャンパス上のy座標を表します。
		 */
		override public function mouseUp(x:Number, y:Number):void
		{
			if (_options.stage) _options.stage.focus = _displayObject;
		}
		
		/**
		 * MouseによるFocus切り替えをした際に呼び出されます。
		 */
		override public function mouseFocusChange():void
		{
			_displayObject.type = TextFieldType.DYNAMIC;
			_displayObject.selectable = false;
			_displayObject.mouseEnabled = false;
			_displayObject.filters = _options.filters;
			if (_options.stage) _options.stage.focus = _options.stage;
			
		}
		
		//----------------------------------------------------------------------
		//  event handler
		//----------------------------------------------------------------------
		private function displayObject_MouseFocusChangeHandler(event:FocusEvent):void
		{
			_displayObject.removeEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, displayObject_MouseFocusChangeHandler);
			mouseFocusChange();
		}
	}
}