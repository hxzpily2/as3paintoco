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
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import jp.wxd.as3paintoco.display.Stroke;
	/**
	 * 標準的なラインツールです。
	 * @author	Copyright (C) naoto koshikawa <naoto5959[at]gmail.com>
	 * @version 0.0.3
	 */
	public class LineTool extends PenTool implements ITool
	{
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		/**
		 * constructor
		 */
		public function LineTool() 
		{
			super();
		}

		//------------------------------
		//  override method
		//------------------------------
		/**
		 * MouseをDownした際に呼び出されます。
		 * @param	x	マウスをダウンした際のキャンパス上のx座標を表します。
		 * @param	y	マウスをダウンした際のキャンパス上のy座標を表します。
		 */
		override public function mouseDown(x:Number, y:Number):void
		{
			_stroke.addChildAt(_displayObject = new Shape(), 0);
			_stroke.x = x;
			_stroke.y = y;
			_displayObject.filters = _options.filters;
			_graphics = _displayObject.graphics;
		}
		
		/**
		 * MouseをMoveした際に呼び出されます。
		 * @param	x	マウスをダブルクリックした際のキャンパス上のx座標を表します。
		 * @param	y	マウスをダブルクリックした際のキャンパス上のy座標を表します。
		 */
		override public function mouseMove(x:Number, y:Number):void
		{
			if (!_displayObject) return;
			_graphics.clear();
			_graphics.lineStyle(
				_options.thickness,
				_options.color,
				_options.alpha,
				_options.pixelHinting,
				_options.scaleMode,
				_options.caps,
				_options.joints,
				_options.miterLimit
			);
			_graphics.moveTo(0, 0);
			_graphics.lineTo(x - _stroke.x, y - _stroke.y);
		}
	}
}