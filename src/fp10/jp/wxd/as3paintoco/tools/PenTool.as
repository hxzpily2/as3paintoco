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
	 * 標準的なペンツールです。
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 * @version 0.0.3
	 */
	public class PenTool extends BaseTool implements ITool
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		/**
		 * ペンで描写するシェイプを表します。
		 */
		protected var _displayObject:Shape;
		
		/**
		 * ペンで描写するシェイプのGraphicsを表します。
		 */
		protected var _graphics:Graphics;
		
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
		
		override public function set options(value:Object):void
		{
			if (value && value.thickness is Number) _options.thickness = value.thickness;
			if (value && value.color is uint) _options.color = value.color;
			if (value && value.alpha is Number) _options.alpha = value.alpha;
			if (value && value.pixelHinting is Boolean) _options.pixelHinting = value.pixelHinting;
			if (value && value.scaleMode is String) _options.scaleMode = value.scaleMode;
			if (value && value.caps is String) _options.caps = value.caps;
			if (value && value.joints is String) _options.joints = value.joints;
			if (value && value.miterLimit is Number) _options.miterLimit = value.miterLimit;
			if (value && value.filters is Array) _options.filters = value.filters;
		}
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		/**
		 * constructor
		 */
		public function PenTool() 
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
				thickness:3,
				color:0x000000,
				alpha: 1.0,
				pixelHinting: true,
				scaleMode: LineScaleMode.NORMAL,
				caps: CapsStyle.ROUND,
				joints: JointStyle.ROUND,
				miterLimit: 3,
				filters:[]
			};
		}
		
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
			_stroke.filters = _options.filters;
			
			_graphics = _displayObject.graphics;
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
		}
		
		/**
		 * MouseをMoveした際に呼び出されます。
		 * @param	x	マウスをダブルクリックした際のキャンパス上のx座標を表します。
		 * @param	y	マウスをダブルクリックした際のキャンパス上のy座標を表します。
		 */
		override public function mouseMove(x:Number, y:Number):void
		{
			if (!_displayObject) return;
			_graphics.lineTo(x - _stroke.x, y - _stroke.y);
		}

		/**
		 * MouseをUpした際に呼び出されます。
		 * @param	x	マウスをダブルクリックした際のキャンパス上のx座標を表します。
		 * @param	y	マウスをダブルクリックした際のキャンパス上のy座標を表します。
		 */
		override public function mouseUp(x:Number, y:Number):void
		{
			if (!_displayObject) return;
			
			if (!_displayObject.width && !_displayObject.height)
			{
				_graphics.clear();
				_stroke.x = x;
				_stroke.y = y;
				_graphics.beginFill(_options.color);
				_graphics.drawCircle(0, 0, _options.thickness/2);
			}
			else
			{
				mouseMove(x, y);
			}
			// 最後にdisplayObjectの左上を_strokeの左上にあわせる！
			_stroke.adjustChildren();
		}
	}
}