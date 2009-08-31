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
	 * すでに描写したDrawingObjectの位置を変更するツールです。
	 * @author	Copyright (C) naoto koshikawa <naoto5959[at]gmail.com>
	 * @version 0.0.3
	 */
	public class SelectTool extends BaseTool implements ITool
	{
		/**
		 * ツールが描写ツールであるかどうかを表します
		 */
		override public function get isDrawable():Boolean
		{
			return false;
		}
		
		/**
		 * 1つ前のxの値
		 */
		private var _prevX:Number;
		
		/**
		 * 1つ前のyの値
		 */
		private var _prevY:Number;
			
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		/**
		 * constructor
		 */
		public function SelectTool() 
		{
			super();
		}
	
		/**
		 * MouseをDownした際に呼び出されます。
		 * @param	x	マウスをダウンした際のキャンパス上のx座標を表します。
		 * @param	y	マウスをダウンした際のキャンパス上のy座標を表します。
		 */
		override public function mouseDown(x:Number, y:Number):void
		{
			if (!_stroke) return;
			_stroke.drawRectangle();
			_prevX = x;
			_prevY = y;
		}
		
		/**
		 * MouseをMoveした際に呼び出されます。
		 * @param	x	マウスをダブルクリックした際のキャンパス上のx座標を表します。
		 * @param	y	マウスをダブルクリックした際のキャンパス上のy座標を表します。
		 */
		override public function mouseMove(x:Number, y:Number):void
		{
			if (!_stroke) return;
			// _stroke.startDrag(); // mouse出動かすとは限らないのでdragはだめ
			_stroke.x += (x - _prevX);
			_stroke.y += (y - _prevY);
			_prevX = x;
			_prevY = y;
		}

		/**
		 * MouseをUpした際に呼び出されます。
		 * @param	x	マウスをダブルクリックした際のキャンパス上のx座標を表します。
		 * @param	y	マウスをダブルクリックした際のキャンパス上のy座標を表します。
		 */
		override public function mouseUp(x:Number, y:Number):void
		{
			if (!_stroke) return;
			//_stroke.stopDrag();
			_stroke.eraseRectangle();
		}
	}
}