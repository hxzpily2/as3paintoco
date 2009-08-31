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
package jp.wxd.color.generator 
{
	/**
	 * <p>ColorGeneratorクラスは、色情報を生成するクラスです。</p>
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class ColorGenerator 
	{
		//----------------------------------------------------------------------
		//  static properties
		//----------------------------------------------------------------------
		//------------------------------
		//  public static properties
		//------------------------------
		/**
		 * <p>WEB SAFEとなる色情報のステップを取得します。</p>
		 */
		public static const WEB_SAFE_COLOR:uint = 0x33;
		
		//------------------------------
		//  private static properties
		//------------------------------
		/**
		 * rgb element max
		 */
		private static const RGB_ELEMENT_MAX:uint = 0xFF;
		
		//------------------------------
		//  public properties
		//------------------------------
		private var _colors:Array;
		/**
		 * <p>作成されたカラー情報の配列を取得します。</p>
		 */
		public function get colors():Array
		{
			return _colors;
		}
		
		private var _eachCount:uint;
		/**
		 * <p>RGBの各要素の数を取得します。</p>
		 */
		public function get eachCount():uint
		{
			return _eachCount;
		}
		
		private var _count:uint;
		/**
		 * <p>作成した全色数を取得します。</p>
		 */
		public function get count():uint
		{
			return _count;
		}
		
		/**
		 * element step
		 */
		private var _step:uint;
		
		
		
		//----------------------------------------------------------------------
		//  methods
		//----------------------------------------------------------------------
		//------------------------------
		//  public methods
		//------------------------------
		/**
		 * <p>新しいColorGeneratorインスタンスを作成します。</p>
		 * @param	step	step generated colors
		 */
		public function ColorGenerator(step:uint = ColorGenerator.WEB_SAFE_COLOR) 
		{
			if (step == 0) throw(ArgumentError("arguments error"));
			if (RGB_ELEMENT_MAX < step) throw(ArgumentError("arguments error"));
			if (RGB_ELEMENT_MAX % step != 0) throw(ArgumentError("arguments error"));
			
			_step = step;
			_eachCount = RGB_ELEMENT_MAX / _step + 1;
			_count = _eachCount * _eachCount * _eachCount; // R colors *  G colors * B colors
			generate();
		}
		
		//------------------------------
		//  private methods
		//------------------------------
		/** 
		 * generate colors
		 */
		private function generate():void
		{
			_colors = [];
			for (var r:uint = 0; r < _eachCount; r++)
			{
				_colors[r] = [];
				for (var g:uint = 0; g < _eachCount; g++)
				{
					_colors[r][g] = [];
					for (var b:uint = 0; b < _eachCount; b++)
					{
						_colors[r][g][b] = _step * r << 16 | _step * g << 8 | _step * b;
					}
				}
			}
		}
	}
}