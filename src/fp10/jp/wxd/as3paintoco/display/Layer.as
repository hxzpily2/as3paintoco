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
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * <p>キャンバス内のレイヤーを表すクラスです。</p>
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class Layer extends Sprite
	{
		//----------------------------------------------------------------------
		//  static properties
		//----------------------------------------------------------------------
		//------------------------------
		//  private static properties
		//------------------------------
		/**
		 * <p>表示オブジェクト上にない状態でのレイヤーのインデックス</p>
		 */
		private static const DEFAULT_INDEX:int = -1;
		
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		//------------------------------
		//  public properties
		//------------------------------
		private var _index:int;
		/**
		 * <p>レイヤーのインデックスを表します</p>
		 */
		public function get index():int
		{
			return _index;
		}
		
		//----------------------------------------------------------------------
		//  methods
		//----------------------------------------------------------------------
		//------------------------------
		//  public methods
		//------------------------------
		/**
		 * <p>新しいLayerインスタンスを作成します。</p>
		 * @param	w
		 * @param	h
		 */
		public function Layer(w:Number, h:Number) 
		{
			if (w <= 0 || h <= 0) throw(new ArgumentError("Layer must be more 0 x 0."));
			graphics.beginFill(0, 0.0);
			graphics.drawRect(0, 0, w, h);
			
			_index = DEFAULT_INDEX;
			addEventListener(Event.ADDED, addedHandler);
		}
		
		/**
		 * <p>レイヤーの後処理を行います。
		 * 具体的にはイベントリスナーの解除と自身を表示オブジェクトリストから削除します。</p>
		 */
		public function destructor():void
		{
			removeEventListener(Event.ADDED, addedHandler);
			removeEventListener(Event.REMOVED, removedHandler);
			if (parent) parent.removeChild(this);
			_index = DEFAULT_INDEX;
		}

		//----------------------------------------------------------------------
		//  event handler
		//----------------------------------------------------------------------
		//------------------------------
		//  private event handler
		//------------------------------
		/**
		 * handler of Event.ADDED
		 *  dispatched from this.
		 * @param	event
		 */
		private function addedHandler(event:Event):void
		{
			if (event.target != this) return;
			removeEventListener(Event.ADDED, addedHandler);
			addEventListener(Event.REMOVED, removedHandler);
			_index = parent.getChildIndex(this);
		}
		
		/**
		 * handler of Event.REMOVED
		 *  dispatched from this.
		 * @param	event
		 */
		private function removedHandler(event:Event):void
		{
			if (event.target != this) return;
			removeEventListener(Event.REMOVED, removedHandler);
			addEventListener(Event.ADDED, addedHandler);
			_index = DEFAULT_INDEX;
		}
	}
}