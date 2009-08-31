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
package jp.wxd.as3paintoco.command 
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import jp.wxd.core.command.Commands;
	import jp.wxd.core.command.CommandsQueue;
	
	/**
	 * <p>ReplayCommandsクラスは画の描画をリプレイするクラスです。</p>
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class ReplayQueue extends CommandsQueue
	{
		//----------------------------------------------------------------------
		//  static properties
		//----------------------------------------------------------------------
		//------------------------------
		//  private static properties
		//------------------------------
		/**
		 * default max interval
		 */
		private static const DEFAULT_MAX_INTERVAL:Number = 1000 * 5;
		
		/**
		 * maximum interval
		 */
		private static const MAX_INTERVAL:Number = 1000 * 60;
		
		/**
		 * minimum interval
		 */
		private static const MIN_INTERVAL:Number = 1;
		
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		//------------------------------
		//  public properties
		//------------------------------
		private var _maxInterval:Number;
		/**
		 * <p>リプレイする際の感覚の最大感覚を取得または設定します。</p>
		 */
		public function get maxInterval():Number
		{
			return _maxInterval;
		}
		/** @private */
		public function set maxInterval(value:Number):void
		{
			if (MAX_INTERVAL < value) value = MAX_INTERVAL;
			if (value < MIN_INTERVAL) value = MIN_INTERVAL;
			_maxInterval = value;
		}
		
		//------------------------------
		//  private properties
		//------------------------------
		/**
		 * excute Timer
		 */
		private var _nextTimer:Timer;
		
		/**
		 * replay speed rate.
		 */
		private var _speedRate:Number = 1.0;
		
		/**
		 * commands done
		 */
		private var _doneCommands:Array;
		
		//----------------------------------------------------------------------
		//  methods
		//----------------------------------------------------------------------
		//------------------------------
		//  override method
		//------------------------------
		/**
		 * execute current command
		 */
		override public function execute():void
		{
			if (_queue.length == 0)
			{
				_running = false;
				_queue = _doneCommands.concat();
				_doneCommands = [];
				ReplayCommand.init();
				dispatchEvent(new Event(Event.COMPLETE));
				return;
			}
			_running = true;
			_currentCommands = _queue[0];
			_currentCommand = _currentCommands.content[0];
			_currentCommand.addEventListener(Event.COMPLETE, _currentCommand_Completehandler);
			
			var interval:Number = ReplayCommand(_currentCommand).interval / _speedRate;
			if (_maxInterval < interval) interval = _maxInterval;
			if (interval < MIN_INTERVAL) interval = MIN_INTERVAL;
			_nextTimer = new Timer(interval, 1);
			_nextTimer.addEventListener(TimerEvent.TIMER_COMPLETE, _nextTimer_handleTimerComplete);
			_nextTimer.start();
		}
		
		/**
		 * next command
		 */
		override protected function next():void
		{
			_doneCommands.push(_queue[0]);
			super.next();
		}
		
		/**
		 * push commands
		 * @param	commands
		 */
		override public function push(commands:Commands):void
		{
			if (commands.content.length != 1)
				throw(new Error("commands length must be 1."));
			if (!(commands.content[0] is ReplayCommand))
				throw(new Error("commands.content[0] must be ReplayCommand"));
			super.push(commands);
		}
		
		/**
		 * insert command
		 */
		override public function insert(commands:Commands):void
		{
			throw(new Error("ReplayQueue.insert is invalid method."));
		}
		
		//------------------------------
		//  public methods
		//------------------------------
		/**
		 * <p>新しいReplayQueueインスタンスを作成します。</p>
		 */
		public function ReplayQueue() 
		{
			super();
			_maxInterval = DEFAULT_MAX_INTERVAL;
			_doneCommands = [];
		}
		
		/**
		 * <p>リプレイを再生します。</p>
		 * @param speedRate 再生速度のレート
		 */
		public function replay(speedRate:Number = 1.0):void
		{
			if (speedRate <= 0) _speedRate = 1.0;
			if (10 < speedRate) _speedRate = 10.0;
			
			_speedRate = speedRate;
			execute();
		}
		
		//----------------------------------------------------------------------
		//  event handler
		//----------------------------------------------------------------------
		//------------------------------
		//  prviate event handler
		//------------------------------
		/**
		 * handler of TimerEvent.TIMER_COMPLETE
		 *  dispatched from _nextTimer
		 * @param event
		 */
		private function _nextTimer_handleTimerComplete(event:TimerEvent):void
		{
			_nextTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, _nextTimer_handleTimerComplete);
			_currentCommand.execute();
		}
	}
}