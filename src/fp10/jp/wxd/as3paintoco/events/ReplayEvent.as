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
package jp.wxd.as3paintoco.events 
{
	import flash.events.Event;
	
	/**
	 * <p>Replay開始時、終了時に送出されるイベントです。</p>
	 * @author naoto koshikawa
	 */
	public class ReplayEvent extends Event 
	{
		//----------------------------------------------------------------------
		//  static properties
		//----------------------------------------------------------------------
		//------------------------------
		//  public static properties
		//------------------------------
		/**
		 * <p>Replayの開始時に送出されるイベント文字列を取得します。</p>
		 */
		public static const START_REPLAY:String = "startReplay";
		
		/**
		 * <p>Rplay終了時に送出されるイベント文字列を取得します。</p>
		 */
		public static const END_REPLAY:String = "endReplay";
		
		//----------------------------------------------------------------------
		//  methods
		//----------------------------------------------------------------------
		//------------------------------
		//  override methods
		//------------------------------
		/**
		 * <p>ReplayEventの複製を返します。</p>
		 * @return
		 */
		public override function clone():Event 
		{ 
			return new ReplayEvent(type, bubbles, cancelable);
		} 
		
		/**
		 * <p>DrawingEventの文字列表記を返します。</p>
		 * @return
		 */
		override public function toString():String 
		{ 
			return formatToString("ReplayEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		//------------------------------
		//  public methods
		//------------------------------
		/**
		 * <p>新しいDrawingEventを作成します。</p>
		 * @param	type
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function ReplayEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		}
	}
}