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
	
	/**
	 * <p>Commandsクラスは、IQueueableCommandの集合を保持するクラスです。</p>
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class Commands 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		//------------------------------
		//  public properties
		//------------------------------
		private var _content:Array;
		/**
		 * list of IQueueableCommand
		 */
		public function get content():Array
		{
			return _content;
		}
		
		//----------------------------------------------------------------------
		//  methods
		//----------------------------------------------------------------------
		//------------------------------
		//  public methods
		//------------------------------
		/**
		 * <p>新しいCommandsインスタンスを作成します。</p>
		 * @param	...args
		 */
		public function Commands(...commands:Array) 
		{
			if (commands.length == 0)
			{
				_content = [];
				return;
			}
			for (var p:String in commands)
			{
				if (commands[p] is Function) commands[p] = new QueueableMethodCommand(this, commands[p]);
				if (!(commands[p] is IQueueableCommand)) throw(new ArgumentError("Commands constucotr expects that arugument Array has IQueueableCommand instance."));
			}
			_content = commands;
		}
	}
}