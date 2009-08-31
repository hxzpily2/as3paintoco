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
	
	/**
	 * <p>CommandsQueueクラスは、複数のCommandsインスタンスをキューイングするクラスです。</p>
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class CommandsQueue extends EventDispatcher implements IQueueableCommand
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		//------------------------------
		//  public properties
		//------------------------------
		protected var _running:Boolean = false;
		/**
		 * <p>現在コマンドが実行中であるかどうかを取得します。</p>
		 */
		public function get running():Boolean
		{
			return _running;
		}
		
		//------------------------------
		//  private properties
		//------------------------------
		/**
		 * ICommand queue
		 */
		protected var _queue:Array = [];
		
		/**
		 * inserted ICommand queue
		 */
		protected var _insertedQueue:Array = [];
		
		/**
		 * current Commands
		 */
		protected var _currentCommands:Commands;
		
		/**
		 * current IQueueableCommand
		 */
		protected var _currentCommand:IQueueableCommand;
		
		/**
		 * done count
		 */
		protected var _doneCount:uint = 0;
		
		//----------------------------------------------------------------------
		//  methods
		//----------------------------------------------------------------------
		//------------------------------
		//  public methods
		//------------------------------
		/**
		 * <p>新しいCommandsQueueインスタンスを作成します。</p>
		 */
		public function CommandsQueue()
		{
			
		}
		
		/**
		 * <p>Commandsインスタンスをキューの最後に追加します。</p>
		 * @param	commands
		 */
		public function push(commands:Commands):void
		{
			if (commands.content.length == 0) return;
			_queue.push(commands);
		}
		
		/**
		 * <p>Commandsインスタンスをキューの先頭に割り込みさせます。</p>
		 */
		public function insert(commands:Commands):void
		{
			if (commands.content.length == 0) return;
			_insertedQueue.push(commands);
		}
		
		/**
		 * <p>コマンドを実行します。</p>
		 */
		public function execute():void
		{
			if (_queue.length == 0)
			{
				_running = false;
				dispatchEvent(new Event(Event.COMPLETE));
				return;
			}
			
			_running = true;
			_currentCommands = _queue[0];
			var commandsLength:Number = _currentCommands.content.length;
			for (var i:uint = 0; i < commandsLength; i++)
			{
				_currentCommand = _currentCommands.content[i];
				
				_currentCommand.addEventListener(Event.COMPLETE, _currentCommand_Completehandler);
				_currentCommand.execute();
			}
		}
		
		//------------------------------
		//  protected methods
		//------------------------------
		/**
		 * next command
		 */
		protected function next():void
		{
			_doneCount = 0;
			_currentCommand = null;
			_queue.shift();
			mergeQueue();
			execute();
		}
		
		/**
		 * merge _queue and _insertedQueue
		 */
		protected function mergeQueue():void
		{
			if (_insertedQueue.length > 0)
			{
				_queue = _insertedQueue.concat(_queue);
				_insertedQueue = [];
			}
		}
		
		//----------------------------------------------------------------------
		//  event handler
		//----------------------------------------------------------------------
		//------------------------------
		//  protected event handler
		//------------------------------
		/**
		 * handler of Event.COMPLETE
		 *  dispatche from _currentCommand
		 * @param event
		 */
		protected function _currentCommand_Completehandler(event:Event):void
		{
			event.target.removeEventListener(Event.COMPLETE, _currentCommand_Completehandler);
			_doneCount++;
			if (_doneCount == _currentCommands.content.length)
			{
				next();
			}
		}
	}
}