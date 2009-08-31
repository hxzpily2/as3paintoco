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
package jp.wxd.as3paintoco.display 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	/**
	 * <p>描画のワンストローク分を表すDisplayObjectです。</p>
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class Stroke extends Sprite
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		//------------------------------
		//  private properties
		//------------------------------
		/** 表示オブジェクトの境界線を表すShapeです */
		private var _boundsShape:Shape;
		
		//----------------------------------------------------------------------
		//  methods
		//----------------------------------------------------------------------
		//------------------------------
		//  public methods
		//------------------------------
		/**
		 * <p>新しいStrokeインスタンスを作成します。</p>
		 * @param	bitmapData
		 */
		public function Stroke(bitmapData:BitmapData = null) 
		{
			setBitmapData(bitmapData);
		}
		
		/**
		 * <p境界線を描写します。</p>
		 * @param	color
		 */
		public function drawRectangle(color:uint = 0xFF0000):void
		{
			eraseRectangle();
			// 色味を反転させる
			filters = filters.concat([new ColorMatrixFilter([-1,  0,  0, 0, 255, 0, -1,  0, 0, 255, 0,  0, -1, 0, 255, 0,  0,  0, 255, 0])]);
			
			var rectangle:Rectangle = getBounds(this);
			_boundsShape = new Shape();
			_boundsShape.graphics.lineStyle(1, color);
			_boundsShape.graphics.drawRect(rectangle.x, rectangle.y, rectangle.width, rectangle.height);
			addChild(_boundsShape);
		}
		
		/**
		 * <p>境界線を削除します。</p>
		 */
		public function eraseRectangle():void
		{
			if (_boundsShape && contains(_boundsShape))
			{
				removeChild(_boundsShape);
				filters = filters.slice(0, filters.length - 2);
			}
		}
		
		/**
		 * <p>現在のStrokeの見た目を複製したクローンを返します。</p>
		 * @param	stroke
		 */
		public function clone():Stroke
		{
			var bitmapData:BitmapData = getBitmapData();
			var stroke:Stroke = new Stroke(bitmapData);
			stroke.transform = transform;
			return stroke;
		}
		
		/**
		 * <p>現在のStrokeに含まれる描写をBitmapDataに変換して返します。</p>
		 * @return
		 */
		public function getBitmapData():BitmapData
		{
			if (!width || !height) return null;
			var rect:Rectangle = getBounds(this);
			var bitmapData:BitmapData = new BitmapData(rect.width, rect.height, true, 0);
			bitmapData.draw(this, new Matrix(1, 0, 0, 1, -rect.left, -rect.top), null, null, null, false);
			return bitmapData;
		}
		
		/**
		 * <p>指定したBitmapDataでstrokeを塗ります</p>
		 */
		public function setBitmapData(bitmapData:BitmapData):void
		{
			if (bitmapData == null) return;
			
			var children:int = numChildren;
			for (var i:uint = 0; i < children; i++)
			{
				removeChildAt(0);
			}
			addChild(new Bitmap(bitmapData, PixelSnapping.NEVER, true));
		}
		
		/**
		 * <p>getRoundsの結果left, topがマイナス値である場合
		 * childrenの各座標を調整します。</p>
		 */
		public function adjustChildren():void
		{
			var rect:Rectangle = getBounds(this);
			if (rect.left >= 0 && rect.top >= 0) return;
			
			var children:int = numChildren;
			var child:DisplayObject;
			for (var i:uint = 0; i < children; i++)
			{
				child = getChildAt(i);
				child.x -= rect.left;
				child.y -= rect.top;
			}
			x += rect.left;
			y += rect.top;
		}
	}
}