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
package jp.wxd.core.command 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * <p>QueueableMethodCommandクラスは、キューイング可能なコマンドクラスです。</p>
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class QueueableMethodCommand extends MethodCommand implements IQueueableCommand
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		//------------------------------
		//  protected properties
		//------------------------------
		/**
		 * EventDispatcher
		 */
		protected var _dispatcher:EventDispatcher;
		
		//----------------------------------------------------------------------
		//  methods
		//----------------------------------------------------------------------
		//------------------------------
		//  override methods
		//------------------------------
		/**
		 * <p>コマンドを実行します。</p>
		 */
		override public function execute():void
		{
			super.execute();
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		//------------------------------
		//  public methods
		//------------------------------
		/**
		 * <p>新しいQueueableMethodCommandを作成します。</p>
		 * @param	scope
		 * @param	method
		 * @param	parameter
		 */
		public function QueueableMethodCommand(scope:*, method:Function, parameter:* = null) 
		{
			super(scope, method, parameter);
			_dispatcher = new EventDispatcher();
		}
		
		/**
		 * Registers an event listener object with an EventDispatcher object so that the listener receives notification of an event.
		 * @param	type
		 * @param	listener
		 * @param	useCapture
		 * @param	priority
		 * @param	useWeakReference
		 */
		public function addEventListener(type:String, 
			listener:Function, useCapture:Boolean = false, priority:int = 0,
			useWeakReference:Boolean = false):void
		{
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		/**
		 * Dispatches an event into the event flow.
		 * @param	event
		 * @return
		 */
		public function dispatchEvent(event:Event):Boolean
		{
			return _dispatcher.dispatchEvent(event);
		}
		
		/**
		 * Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
		 * @param	type
		 * @return
		 */
		public function hasEventListener(type:String):Boolean
		{
			return _dispatcher.hasEventListener(type);
		}
		
		/**
		 * Removes a listener from the EventDispatcher object.
		 * @param	type
		 * @param	listener
		 * @param	useCapture
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
		{
			_dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		/**
		 * Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type.
		 * @param	type
		 * @return
		 */
		public function willTrigger(type:String):Boolean
		{
			return _dispatcher.willTrigger(type);
		}
	}
}