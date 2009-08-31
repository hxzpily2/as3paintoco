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
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import jp.wxd.as3paintoco.data.CanvasData;
	
	/**
	 * <p>Canvasクラスは画を描くためのキャンバスを表します。CanvasCoreのcanvasプロパティをDisplayObjectツリーへ登録して下さい。</p>
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class Canvas extends Sprite
	{
		//----------------------------------------------------------------------
		//  static properties
		//----------------------------------------------------------------------
		//------------------------------
		//  private static properties
		//------------------------------
		/**
		 * _mask index on DisplayObject Tree
		 */
		private static const MASK_INDEX:uint = 1;
		
		/**
		 * _base index on DisplayObject Tree
		 */
		private static const BASE_INDEX:uint = 0;
		
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		//------------------------------
		//  public properties
		//------------------------------
		private var _background:DisplayObject;
		/**
		 * <p>キャンバスの背景を表すDisplayObjectインスタンスを設定または取得します。</p>
		 */
		public function get background():DisplayObject
		{
			return _background;
		}
		/** @private */
		public function set background(value:DisplayObject):void
		{
			if (_background && _base.contains(_background))
				_base.removeChild(_background);
			
			_background = value;
			_background.x = (_canvasData.canvasWidth - _background.width) / 2;
			_background.y = (_canvasData.canvasHeight - _background.height) / 2;
				
			_base.addChildAt(_background, 0);
		}

		private var _canvasMask:Shape;
		/**
		 * <p>キャンバスの背景をマスクするShapeインスタンスを取得します。</p>
		 */
		private function get canvasMask():Shape
		{
			return _canvasMask;
		}
		
		private var _base:Sprite;
		/**
		 * <p>キャンバスの背景とマスクのコンテナーとなるSpriteを取得します。</p>
		 */
		public function get base():Sprite
		{
			return _base;
		}
		
		//------------------------------
		//  private properties
		//------------------------------
		/**
		 * canvas data
		 */
		private var _canvasData:CanvasData;
			
		/**
		 * layers which is container for ILayers
		 */
		private var _layers:Layers;	
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		/**
		 * <p>新しいCanvasインスタンスを作成します。</p>
		 * @param canvasData	CanvasDataインスタンス
		 */
		public function Canvas(canvasData:CanvasData) 
		{
			_canvasData = canvasData;
			_canvasData.addEventListener(Event.CHANGE, _canvasData_changeHandler);
			initialize();
		}
		
		/**
		 * <p>キャンバスを初期化します。</p>
		 */
		public function initialize():void
		{
			createBase();
			createMask();
			
			_background = new Bitmap(new BitmapData(_canvasData.canvasWidth, _canvasData.canvasHeight, true, 0));
			_layers = new Layers();
			
			_base.addChild(_background);
			_base.addChild(_layers);
			
			var canvasParent:DisplayObjectContainer = parent;
			if (canvasParent)
			{
				var canvasIndex:int = canvasParent.getChildIndex(this);
				canvasParent.removeChild(this);
				canvasParent.addChildAt(this, canvasIndex);
			}
		}

		//------------------------------
		//  private method
		//------------------------------
		/**
		 * activate mouse event
		 */
		private function activate():void
		{
			mouseChildren = true;
			mouseEnabled = true;
		}
		
		/**
		 * deactivate mouse event
		 */
		private function deactivate():void
		{
			mouseChildren = false;
			mouseEnabled = false;
		}
		
		/**
		 * create base
		 */
		private function createBase():void
		{
			if (_base && contains(_base)) removeChild(_base);
			_base = new Sprite();
			addChildAt(_base, BASE_INDEX);
		}
		
		/**
		 * create mask
		 */
		private function createMask():void
		{
			if (_canvasMask && contains(_canvasMask)) removeChild(_canvasMask);
			_canvasMask = new Shape();
			_canvasMask.graphics.beginFill(0, 0.0); // fill transparent color
			_canvasMask.graphics.drawRect(0, 0, _canvasData.canvasWidth, _canvasData.canvasHeight);
			addChildAt(_canvasMask, MASK_INDEX);
			mask = _canvasMask;
		}
		
		//----------------------------------------------------------------------
		//  event handler
		//----------------------------------------------------------------------
		//------------------------------
		//  private event handler
		//------------------------------
		/**
		 * handler of Event.CHANGE
		 *  dispatched from _canvasData
		 * @param event
		 */
		private function _canvasData_changeHandler(event:DataEvent):void
		{
			if (_canvasData.activeLayer is Layer) _layers.add(_canvasData.activeLayer);
			
			if (_canvasData.isActive) activate();
			else deactivate();
		}
	}
}