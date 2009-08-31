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
	 * <p>MethodCommandクラスはコマンドパターンにおけるレシーバーを任意に設定可能なコマンドクラスです。</p>
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class MethodCommand implements IMethodCommand, ICommand
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		//------------------------------
		//  public properties
		//------------------------------
		protected var _scope:Object;
		/**
		 * function scope if function is closure
		 */
		public function get scope():Object
		{
			return _scope;
		}
		
		protected var _method:Function;
		/**
		 * function
		 */
		public function get method():Function
		{
			return _method;
		}
		
		protected var _parameter:*;
		/**
		 * argument of function
		 */
		public function get parameter():*
		{
			return _parameter;
		}
		
		protected var _result:*;
		/**
		 * result of invoking function
		 */
		public function get result():*
		{
			return _result;
		}
		
		//----------------------------------------------------------------------
		//  methods
		//----------------------------------------------------------------------
		//------------------------------
		//  public methods
		//------------------------------
		/**
		 * <p>新しいMethodCommandインスタンスを作成します。</p>
		 * @param	scope	第二引数に指定するmethodがクロージャである場合の実行時のスコープを指定します。
		 * @param	method	実行したいFunctionインスタンスを指定します。
		 * @param	parameter	指定したFunctionを実行時に渡す引数を指定します。
		 */
		public function MethodCommand(scope:*, method:Function, parameter:* = null) 
		{
			_scope = scope;
			_method = method;
			if (!parameter) _parameter = [];
			else if (parameter is Array) _parameter = parameter;
			else _parameter = [parameter];
		}
		
		/**
		 * <p>コマンドを実行します。</p>
		 */
		public function execute():void
		{
			_result = _method.apply(_scope, _parameter);
		}
	}
}