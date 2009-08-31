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
	import jp.wxd.as3paintoco.display.Stroke;
	
	/**
	 * Base Tool implements ITool
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class BaseTool implements ITool
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		//------------------------------
		//  getter/setter
		//------------------------------
		protected var _cursor:DisplayObject;
		/**
		 * ツールを使用している際にマウスカーソルに追尾するカーソルを設定します
		 */
		public function get cursor():DisplayObject
		{
			return _cursor;
		}
		/** @private */
		public function set cursor(value:DisplayObject):void
		{
			_cursor = value;
		}
		
		protected var _stroke:Stroke;
		/**
		 * ツールが対象とするStrokeを表します。
		 */
		public function get stroke():Stroke
		{
			return _stroke;;
		}
		/** @private */
		public function set stroke(value:Stroke):void
		{
			_stroke = value;
		}
		
		/**
		 * ツールが描写ツールであるかどうかを表します
		 */
		public function get isDrawable():Boolean
		{
			return true;
		}
		
		/**
		 * ツールのオプションを設定します。
		 */
		protected var _options:Object = {};
		public function get options():Object
		{
			return _options;
		}
		/** @private */
		public function set options(value:Object):void
		{
		}
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		/**
		 * constructor
		 */
		public function BaseTool() 
		{
			if (Object(this).constructor == BaseTool)
				throw(new Error("you can't create instance of AbstractClass."));
			configure();
		}
		
		/**
		 * ツールが使用可能となった場合に呼び出されます。
		 * ツールを使用する度に初期化を行う場合、このメソッドを利用します。
		 */
		public function activate():void
		{
		}
		
		/**
		 * ツールがロードされた際に一度だけ呼び出されます。(IToolを実装したクラスのコンストラクタ内から呼び出します)
		 * 一度だけ初期化を行う際にはこのメソッドを利用します。
		 */
		public function configure():void
		{
			_options = {};
		}
		
		/**
		 * ツールが使用不可となった場合に呼び出されます。
		 * ツール使用後の後処理などを行う場合、このメソッドを利用します。
		 */
		public function deactivate():void
		{
		}
		
		/**
		 * KeyをDownした際に呼び出されます。
		 * @param	charCode	KeyをDownした際の対象キーの文字コードを表します。
		 * @param	text	KeyUpにより変更となったtextがあれば指定します。
		 */
		public function keyDown(charCode:uint, text:String = null):void
		{
		}
		
		/**
		 * KeyをUpした際に呼び出されます。
		 * @param	charCode	KeyをUpした際の対象キーの文字コードを表します。
		 * @param	text	KeyUpにより変更となったtextがあれば指定します。
		 */
		public function keyUp(charCode:uint, text:String = null):void
		{
			
		}
		
		/**
		 * MouseをDoubleClickした際に呼び出されます。
		 * @param	x	マウスをダブルクリックした際のキャンパス上のx座標を表します。
		 * @param	y	マウスをダブルクリックした際のキャンパス上のy座標を表します。
		 */
		public function mouseDoubleClick(x:Number, y:Number):void
		{
			
		}

		/**
		 * MouseをDownした際に呼び出されます。
		 * @param	x	マウスをダウンした際のキャンパス上のx座標を表します。
		 * @param	y	マウスをダウンした際のキャンパス上のy座標を表します。
		 */
		public function mouseDown(x:Number, y:Number):void
		{
		}
		
		/**
		 * MouseをMoveした際に呼び出されます。
		 * @param	x	マウスをダブルクリックした際のキャンパス上のx座標を表します。
		 * @param	y	マウスをダブルクリックした際のキャンパス上のy座標を表します。
		 */
		public function mouseMove(x:Number, y:Number):void
		{
		}

		/**
		 * MouseをUpした際に呼び出されます。
		 * @param	x	マウスをダブルクリックした際のキャンパス上のx座標を表します。
		 * @param	y	マウスをダブルクリックした際のキャンパス上のy座標を表します。
		 */
		public function mouseUp(x:Number, y:Number):void
		{
		}
		
		/**
		 * MouseによるFocus切り替えをした際に呼び出されます。
		 */
		public function mouseFocusChange():void
		{
		}
	}
}