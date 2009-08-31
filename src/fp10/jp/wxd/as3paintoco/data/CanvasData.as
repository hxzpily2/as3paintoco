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
package jp.wxd.as3paintoco.data 
{
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import jp.wxd.as3paintoco.display.Layer;
	import jp.wxd.as3paintoco.tools.ITool;
	
	/**
	 * <p>CanvasDataは、キャンバスのデータモデルの役割を担います。
	 * ライブラリ利用者が直接このクラスを参照する必要はありません。</p>
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class CanvasData extends EventDispatcher
	{
		//----------------------------------------------------------------------
		//  static properties
		//----------------------------------------------------------------------
		//------------------------------
		//  public static properties
		//------------------------------
		/**
		 * minimum size of canvas size
		 */
		public static const CANVAS_SIZE_MIN:Number = 10;
		
		/**
		 * maximum size of canvas size
		 */
		public static const CANVAS_SIZE_MAX:Number = 8192;
		
		/**
		 * maximum size of canvas pixels
		 */
		public static const CANVAS_PIXELS_MAX:Number = 16777216;
		
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		//------------------------------
		//  public properties
		//------------------------------
		private var _isActive:Boolean;
		/**
		 * <p>キャンバスがユーザイベントを受け取るか受け取らないかを設定または取得します。</p>
		 */
		public function get isActive():Boolean
		{
			return _isActive;
		}
		/** @private */
		public function set isActive(value:Boolean):void
		{
			_isActive = value;
			dispatchEvent(new DataEvent(Event.CHANGE, false, false));
		}
		
		private var _activeTool:ITool;
		/**
		 * <p>現在選択されているIToolを設定または取得します。</p>
		 */
		public function get activeTool():ITool
		{
			return _activeTool;
		}
		/** @private */
		public function set activeTool(value:ITool):void
		{
			_activeTool = value;
		}
		
		private var _activeLayer:Layer;
		/**
		 * <p>現在選択されているLayerを設定または取得します。</p>
		 */
		public function get activeLayer():Layer
		{
			return _activeLayer;
		}
		/** @private */
		public function set activeLayer(value:Layer):void
		{
			_activeLayer = value;
			dispatchEvent(new DataEvent(Event.CHANGE, false, false));
		}
		
		private var _canvasWidth:Number = 0;
		/**
		 * <p>キャンバスの幅を設定または取得します。</p>
		 * @return
		 */
		public function get canvasWidth():Number
		{
			return _canvasWidth;
		}
		/** @private */
		public function set canvasWidth(value:Number):void
		{
			if (value < CanvasData.CANVAS_SIZE_MIN) throw(new Error("minimum canvas width is " + CanvasData.CANVAS_SIZE_MIN));
			if (_canvasHeight != 0 && CanvasData.CANVAS_PIXELS_MAX < value * _canvasHeight)
				throw(new Error("maximum canvas pixel size is " + CanvasData.CANVAS_PIXELS_MAX));
			else if (CanvasData.CANVAS_SIZE_MAX < value)
				throw(new Error("maximum canvas width is " + CanvasData.CANVAS_SIZE_MAX));
			
			_canvasWidth = value;
		}
		
		private var _canvasHeight:Number = 0;
		/**
		 * <p>キャンバスの高さを設定または取得します。</p>
		 * @return
		 */
		public function get canvasHeight():Number
		{
			return _canvasHeight;
		}
		/** @private */
		public function set canvasHeight(value:Number):void
		{
			if (value < CanvasData.CANVAS_SIZE_MIN) throw(new Error("minimum canvas height is " + CanvasData.CANVAS_SIZE_MIN));
			if (_canvasWidth != 0 && CanvasData.CANVAS_PIXELS_MAX < value * _canvasWidth)
				throw(new Error("maximum canvas pixel size is " + CanvasData.CANVAS_PIXELS_MAX));
			else if (CanvasData.CANVAS_SIZE_MAX < value)
				throw(new Error("maximum canvas height is " + CanvasData.CANVAS_SIZE_MAX));
				
			_canvasHeight = value;
		}
		
		//----------------------------------------------------------------------
		//  methods
		//----------------------------------------------------------------------
		//------------------------------
		//  public methods
		//------------------------------
		/**
		 * <p>新しいCanvasDataインスタンスを作成します。</p>
		 */
		public function CanvasData(param:Object) 
		{
			if (!param || !param.canvasWidth || !param.canvasHeight)
				throw(new ArgumentError("CanvasData constructor expects parameter of Object which has canvasWidth and canvasHeight."));	
			initialize(param);
		}
		
		/**
		 * <p>キャンバスデータを初期化します。</p>
		 */
		public function initialize(param:Object):void
		{
			if (param && param.isActive is Boolean) isActive = param.isActive;
			else _isActive = false;
			
			if (param && param.canvasWidth is Number) canvasWidth = param.canvasWidth;
			else _canvasWidth = 0;
			
			if (param && param.canvasHeight is Number) canvasHeight = param.canvasHeight;
			else _canvasHeight = 0;

		}
	}
}