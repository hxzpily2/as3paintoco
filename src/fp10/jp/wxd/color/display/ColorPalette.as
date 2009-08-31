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
package jp.wxd.color.display 
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import jp.wxd.color.generator.ColorGenerator
	
	/**
	 * <p>ColorPaletteクラスは、RGBカラーパレットを生成するクラスです。</p>
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class ColorPalette extends Sprite
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		//------------------------------
		//  public properties
		//------------------------------
		private var _bitmapData:BitmapData;
		/** 
		 * <p>
		 * 参照用 bitmapData<br />
		 * カラーピッカーとして利用する場合にはColorPaletteにMouseEventのリスナーを登録し<br />
		 * ハンドラ内でBitmapData::getPixelやBitmapData::getPixel32を用いて<br />
		 * パレット内の色を参照して下さい。
		 * </p>
		 */
		public function get bitmapData():BitmapData
		{
			return _bitmapData;
		}
		
		//----------------------------------------------------------------------
		//  methods
		//----------------------------------------------------------------------
		/**
		 * <p>新しいColorPalletインスタンスを作成します。</p>
		 * @param	colorStep	パレットの色ステップを指定します。0x33でweb safe colorが生成されます。
		 * @param	cellSize	パレットのセルのサイズを指定します。
		 * @param	cellMargin	パレットのセル同士のマージンを指定します。
		 * @param	colmunCount	パレットの１区画分の塊を横方向にいくつ配置するかを指定します。
		 */
		public function ColorPalette(colorStep:uint = ColorGenerator.WEB_SAFE_COLOR, cellSize:uint = 10, cellMargin:Number = 0, columnCount:uint = 2) 
		{
			var generator:ColorGenerator = new ColorGenerator(colorStep);
			var colors:Array = generator.colors;
			var count:uint = generator.eachCount;
			var colorList:Array = [];
			var container:Sprite = new Sprite();
			container.graphics.drawRect(
					0, 
					0, 
					count * (cellSize + cellMargin) * columnCount - cellMargin, 
					count * (cellSize + cellMargin) * count / columnCount - cellMargin
			);
			addChild(container);
			
			for (var r:uint = 0; r < count; r++)
			{
				for (var g:uint = 0; g < count; g++)
				{
					for (var b:uint = 0; b < count; b++)
					{
						var cellX:uint = r * (cellSize + cellMargin) * count 
								+ g * (cellSize + cellMargin) 
								- Math.floor(r / columnCount) * (cellSize + cellMargin) * count * columnCount;
						var cellY:uint = Math.floor(r / columnCount) * (cellSize + cellMargin) * count 
								+ b * (cellSize + cellMargin);
						var cell:Shape = new Shape();
						var cellGraphics:Graphics = cell.graphics;
						cellGraphics.beginFill(colors[r][g][b], 1.0);
						cellGraphics.drawRect(0, 0, cellSize, cellSize);
						cell.x = cellX;
						cell.y = cellY;
						colorList.push(container.addChild(cell));
					}
				}
			}
			_bitmapData = new BitmapData(width, height, true, 0);
			_bitmapData.draw(this);
		}
	}
}