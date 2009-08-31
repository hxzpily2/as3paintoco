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
	 * <p>CommandStackは、IRedoableCommandをスタックするクラスです。スタックを使い、処理の「やり直し」「取り消し」を実現します。</p>
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class CommandStack 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		//------------------------------
		//  public properties
		//------------------------------
		/**
		 * <p>前のICommandインスタンスを取得します。処理の取り消しに使用します。</p>
		 */
		public function get previous():IRedoableCommand
		{
			return _stack[--_currentIndex];
		}
		
		/**
		 * <p>次のICommandインスタンスを取得します。処理のやり直しに使用します。</p>
		 */
		public function get next():IRedoableCommand
		{
			return _stack[_currentIndex++];
		}
		
		/**
		 * <p>スタック内に前のICommandが存在するかを取得します。</p>
		 */
		public function get hasPrevious():Boolean
		{
			return Boolean(0 < _currentIndex);
		}
		
		/**
		 * <p>スタック内に次のICommandが存在するかを取得します。</p>
		 */
		public function get hasNext():Boolean
		{
			return Boolean(_currentIndex < _stack.length);
		}
		
		//------------------------------
		//  private properties
		//------------------------------
		/**
		 * command stacks
		 */
		private var _stack:Array = [];
		
		/**
		 * current index
		 */
		private var _currentIndex:int = 0;
		
		//----------------------------------------------------------------------
		//  methods
		//----------------------------------------------------------------------
		//------------------------------
		//  public methods
		//------------------------------
		/**
		 * <p>新しいCommandStackインスタンスを作成します。</p>
		 */
		public function CommandStack() 
		{
		}
		
		/**
		 * <p>IRedoableCommandインスタンスをスタックに追加します。</p>
		 * @param	command
		 */
		public function push(command:IRedoableCommand):void
		{
			_stack[_currentIndex++] = command;
			// 新たにICommandをpushした際には、現在のインデックス以降のstacksを削除する
			_stack.splice(_currentIndex, _stack.length - _currentIndex);
		}
		
		/**
		 * <p>スタックを初期化します。</p>
		 */
		public function initialize():void
		{
			_stack = [];
			_currentIndex = 0;
		}
	}
}