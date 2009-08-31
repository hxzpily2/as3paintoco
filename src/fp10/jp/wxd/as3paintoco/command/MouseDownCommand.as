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
	import jp.wxd.as3paintoco.display.Layer;
	import jp.wxd.as3paintoco.display.Stroke;
	import jp.wxd.as3paintoco.tools.ITool;
	import jp.wxd.core.command.ICommand;
	import jp.wxd.core.command.IRedoableCommand;
	import jp.wxd.core.command.IUndoableCommand;
	
	/**
	 * <p>MouseDownCommandクラスは、描画時に行ったマウスの操作を表すコマンドです。</p>
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class MouseDownCommand implements IRedoableCommand
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		/**
		 * indicate whether executed or not
		 */
		private var _done:Boolean = false;
		
		/**
		 * tool
		 */
		private var _tool:ITool;
		
		/**
		 * mouseX
		 */
		private var _mouseX:Number;
		
		/**
		 * mouseY
		 */
		private var _mouseY:Number;
		
		/**
		 * current Stroke instance
		 */
		private var _stroke:Stroke;
		
		/**
		 * previous Stroke instance
		 */
		private var _originalStroke:Stroke;
		
		/**
		 * layer
		 */
		private var _layer:Layer;
		
		//----------------------------------------------------------------------
		//  methods
		//----------------------------------------------------------------------
		//------------------------------
		//  public methods
		//------------------------------
		/**
		 * <p>MouseDownCommandインスタンスを作成する。</p>
		 * @param	tool
		 * @param	mouseX
		 * @param	mouseY
		 * @param	stroke
		 */
		public function MouseDownCommand(tool:ITool, mouseX:Number, mouseY:Number, stroke:Stroke)
		{
			_tool = tool;
			_mouseX = mouseX;
			_mouseY = mouseY;
			_stroke = stroke;
			_layer = Layer(_stroke.parent);
			
			// check Stroke is a fresh one or not.
			if (_stroke.getBitmapData()) _originalStroke = _stroke.clone();
		}
		
		/**
		 * <p>コマンドを実行します。</p>
		 */
		public function execute():void
		{
			if (_done) return;
			_tool.stroke = _stroke;
//			_layer.addChild(_stroke);
			_done = true;
			_tool.mouseDown(_mouseX, _mouseY);
		}
		
		/**
		 * <p>コマンドを取り消します。</p>
		 */
		public function undo():void
		{
			if (!_originalStroke && _layer.contains(_stroke)) _layer.removeChild(_stroke);
			else swapStroke();
		}
		
		/**
		 * <p>コマンドをやり直します。</p>
		 */
		public function redo():void
		{
			if (!_originalStroke && !_layer.contains(_stroke)) _layer.addChild(_stroke);
			else swapStroke();
		}
		
		//------------------------------
		//  private methods
		//------------------------------
		/**
		 * swap current Stroke for original Stroke
		 */
		private function swapStroke():void
		{
			if (!_originalStroke) return;
			var stroke:Stroke = _stroke.clone();
			_stroke.setBitmapData(_originalStroke.getBitmapData());
			_stroke.transform = _originalStroke.transform;
			_originalStroke = stroke.clone();
		}
	}
}