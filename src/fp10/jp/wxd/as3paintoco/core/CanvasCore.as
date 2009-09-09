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
package jp.wxd.as3paintoco.core 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import jp.wxd.as3paintoco.command.MouseDownCommand;
	import jp.wxd.as3paintoco.data.CanvasData;
	import jp.wxd.as3paintoco.display.Canvas;
	import jp.wxd.as3paintoco.display.Layer;
	import jp.wxd.as3paintoco.display.Stroke;
	import jp.wxd.as3paintoco.events.DrawingEvent;
	import jp.wxd.as3paintoco.events.DrawingFocusChange;
	import jp.wxd.as3paintoco.events.DrawingTextEvent;
	import jp.wxd.as3paintoco.tools.ITool;
	import jp.wxd.core.command.CommandStack;
	import jp.wxd.core.command.IRedoableCommand;
	
	/**
	 * <p>描画開始時に発生するイベントです</p>
	 * <p></p>
	 * 
	 * @eventType jp.wxd.as3paintoco.events.DrawingEvent.START_DRAWING
	 */
	[Event( name="startDrawing", type="jp.wxd.as3paintoco.events.DrawingEvent" )]
	
	/**
	 * <p>描画中に発生するイベントです</p>
	 * <p></p>
	 * 
	 * @eventType jp.wxd.as3paintoco.events.DrawingEvent.MOVE_DRAWING
	 */
	[Event( name = "moveDrawing", type = "jp.wxd.as3paintoco.events.DrawingEvent" )]
	
	/**
	 * <p>描画終了時に発生するイベントです</p>
	 * <p></p>
	 * 
	 * @eventType jp.wxd.as3paintoco.events.DrawingEvent.STOP_DRAWING
	 */
	[Event( name = "stopDrawing", type = "jp.wxd.as3paintoco.events.DrawingEvent" )]
	
	
	/**
	 * <p>CanvasCoreクラスは画を描く際に、キャンバスのコントローラの役割を担います。</p>
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class CanvasCore extends EventDispatcher
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		//------------------------------
		//  public properties
		//------------------------------
		private var _canvas:Canvas;
		/**
		 * <p>キャンバスのビューの役割を担う<code>Canvas</code>のインスタンスを表します。</p>
		 */
		public function get canvas():Canvas
		{
			return _canvas;
		}
		
		private var _stack:CommandStack;
		/**
		 * <p>キャンバスのビューで発生するユーザイベントを起因に生成されるコマンドを保持する<code>CommandStack</code>のインスタンスを表します。</p>
		 */
		public function get stack():CommandStack
		{
			return _stack;
		}	
		
		//------------------------------
		//  private properties
		//------------------------------
		/**
		 * キャンバスのデータモデルの役割を担う<code>CanvasData</code>のインスタンスを表します。
		 */
		private var _canvasData:CanvasData;
		
		//----------------------------------------------------------------------
		//  methods
		//----------------------------------------------------------------------
		//------------------------------
		//  public methods
		//------------------------------
		/**
		 * <p>キャンバスを作成するには<code>CanvasCore</code>のインスタンスを作成し、
		 * <code>canvas</code>プロパティを参照してcanvasのビューをDisplayObjectツリーへ追加して下さい。</p>
		 * @param	w	キャンバスの幅を指定します。
		 * @param	h	キャンバスの高さを指定します。
		 */
		public function CanvasCore(w:Number, h:Number) 
		{
			_canvasData = new CanvasData({canvasWidth:w, canvasHeight:h});
			_canvas = new Canvas(_canvasData);
			_stack = new CommandStack();
			
			_canvasData.activeLayer = new Layer(
				_canvasData.canvasWidth, _canvasData.canvasHeight
			);
		}
		
		/**
		 * <p>キャンバスを初期化する際に利用します。</p>
		 * @param	w	キャンバスの幅を指定します。
		 * @param	h	キャンバスの高さを指定します。
		 */
		public function initialize(w:Number, h:Number):void
		{
			_canvasData.initialize({canvasWidth:w, canvasHeight:h});
			_canvas.initialize();
			_stack = new CommandStack();
			
			_canvasData.activeLayer = new Layer(
				_canvasData.canvasWidth, _canvasData.canvasHeight
			);
		}
		
		/**
		 * <p>指定したツールをcanvasData.activeToolに登録し、現在のツールとします。</p>
		 * <p>このメソッドでツールを登録して、初めてユーザはキャンバスを操作することが出来ます。</p>
		 * @param	tool
		 */
		public function applyTool(tool:ITool):void
		{
			_canvasData.activeTool = tool;
		}

		/**
		 * <p>EventListenerを登録することで、ユーザイベントを受け付けます。</p>
		 */
		public function activate():void
		{
			if (!_canvasData.activeTool) return;
			_canvasData.isActive = true;
			_canvasData.addEventListener(Event.CHANGE, _canvasData_changeHandler, false, int.MAX_VALUE);
			// User Event
			_canvas.addEventListener(MouseEvent.MOUSE_DOWN, _canvas_mouseDownHandler, false, int.MAX_VALUE);
			_canvas.addEventListener(KeyboardEvent.KEY_DOWN, _canvas_keyDownHandler, false, int.MAX_VALUE);
			_canvas.addEventListener(KeyboardEvent.KEY_UP, _canvas_keyUpHandler, false, int.MAX_VALUE);
		}
		
		/**
		 * <p>EventListenerを解除することで、ユーザイベントを受け付けないようにします。</p>
		 */
		public function deactivate():void
		{
			_canvasData.isActive = false;
			_canvasData.removeEventListener(Event.CHANGE, _canvasData_changeHandler, false);
			// User Event
			_canvas.removeEventListener(MouseEvent.MOUSE_DOWN, _canvas_mouseDownHandler, false);
			_canvas.removeEventListener(KeyboardEvent.KEY_DOWN, _canvas_keyDownHandler, false);
			_canvas.removeEventListener(KeyboardEvent.KEY_UP, _canvas_keyUpHandler, false);
		}
		
		/**
		 * <p>MouseEvent.MOUSE_DOWNイベント発生時の処理を実行します。</p>
		 * <p>ユーザイベントによって、CanvasクラスのインスタンスからMouseEvent.MOUSE_DOWNイベントが発生した際に実行されます。</p>
		 * <p>publicメソッドとなっているため、リプレイ機能などの自動お絵かき処理を実現するために外部から実行することも可能です。</p>
		 * @param	tool	MouseEvent.MOUSE_DOWN時のIToolインスタンスを指定します。
		 * @param	currentX	MouseEvent.MOUSE_DOWN時のx座標を指定します。
		 * @param	currentY	MouseEvent.MOUSE_DOWN時のy座標を指定します。
		 */
		public function mouseDown(tool:ITool, currentX:Number, currentY:Number):void
		{
			var customEvent:DrawingEvent = new DrawingEvent(DrawingEvent.START_DRAWING, true, true, tool, currentX, currentY);
			dispatchEvent(customEvent);
			if (customEvent.isDefaultPrevented()) return;
			
			var stroke:Stroke;
			if (tool.isDrawable)
			{
				// 描画ツールの場合新しいStrokeを生成する
				stroke = new Stroke();
			}
			else
			{
				var underObjects:Array = _canvas.getObjectsUnderPoint(_canvas.localToGlobal(new Point(currentX, currentY)));
				var len:Number = underObjects.length;
				if (len && !(underObjects[len -1] is Layer))
					stroke = Stroke(DisplayObject(underObjects[underObjects.length -1]).parent);
					
				if (!stroke) return;
			}
			
			_canvasData.activeLayer.addChild(stroke);
			
			_canvas.removeEventListener(MouseEvent.MOUSE_DOWN, _canvas_mouseDownHandler, false);
			_canvas.addEventListener(MouseEvent.MOUSE_UP, _canvas_mouseUpHandler, false, int.MAX_VALUE);
			_canvas.addEventListener(MouseEvent.ROLL_OUT, _canvas_mouseUpHandler, false, int.MAX_VALUE);
			_canvas.addEventListener(MouseEvent.MOUSE_MOVE, _canvas_mouseMoveHandler, false, int.MAX_VALUE);
			_canvas.addEventListener(KeyboardEvent.KEY_DOWN, _canvas_keyDownHandler, false, int.MAX_VALUE);
			_canvas.addEventListener(KeyboardEvent.KEY_UP, _canvas_keyUpHandler, false, int.MAX_VALUE);
			_canvas.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, _canvas_mouseFocusChangeHandler, true, int.MAX_VALUE);
			var command:IRedoableCommand = new MouseDownCommand(tool, currentX, currentY, stroke);
			command.execute();
			_stack.push(command);
		}
		
		/**
		 * <p>MouseEvent.MOUSE_MOVEイベント発生時の処理を実行します。</p>
		 * <p>ユーザイベントによって、CanvasクラスのインスタンスからMouseEvent.MOUSE_MOVEイベントが発生した際に実行されます。</p>
		 * <p>publicメソッドとなっているため、リプレイ機能などの自動お絵かき処理を実現するために外部から実行することも可能です。</p>
		 * @param	tool	MouseEvent.MOUSE_MOVE時のIToolインスタンスを指定します。
		 * @param	currentX	MouseEvent.MOUSE_MOVE時のx座標を指定します。
		 * @param	currentY	MouseEvent.MOUSE_MOVE時のy座標を指定します。
		 */
		public function mouseMove(tool:ITool, currentX:Number, currentY:Number):void
		{
			var customEvent:DrawingEvent = new DrawingEvent(DrawingEvent.MOVE_DRAWING, true, true, tool, currentX, currentY);
			dispatchEvent(customEvent);
			if (customEvent.isDefaultPrevented()) return;
			
			tool.mouseMove(currentX, currentY);
		}
		
		/**
		 * <p>MouseEvent.MOUSE_UPイベント発生時の処理を実行します。</p>
		 * <p>ユーザイベントによって、CanvasクラスのインスタンスからMouseEvent.MOUSE_UPイベントが発生した際に実行されます。</p>
		 * <p>publicメソッドとなっているため、リプレイ機能などの自動お絵かき処理を実現するために外部から実行することも可能です。</p>
		 * @param	tool	MouseEvent.MOUSE_UP時のIToolインスタンスを指定します。
		 * @param	currentX	MouseEvent.MOUSE_UP時のx座標を指定します。
		 * @param	currentY	MouseEvent.MOUSE_UP時のy座標を指定します。
		 */
		public function mouseUp(tool:ITool, currentX:Number, currentY:Number):void
		{
			var customEvent:DrawingEvent = new DrawingEvent(DrawingEvent.STOP_DRAWING, true, true, tool, currentX, currentY);
			dispatchEvent(customEvent);
			if (customEvent.isDefaultPrevented()) return;
			
			if (!_canvasData.isActive)
			{
				// 自動実行の場合
				tool.mouseFocusChange();
			}
			
			_canvas.addEventListener(MouseEvent.MOUSE_DOWN, _canvas_mouseDownHandler, false, int.MAX_VALUE);
			_canvas.removeEventListener(MouseEvent.MOUSE_UP, _canvas_mouseUpHandler, false);
			_canvas.removeEventListener(MouseEvent.ROLL_OUT, _canvas_mouseUpHandler, false);
			_canvas.removeEventListener(MouseEvent.MOUSE_MOVE, _canvas_mouseMoveHandler, false);
			tool.mouseUp(currentX, currentY);
		}
		
		/**
		 * <p>KeyBoardEvent.KEY_DOWNイベント発生時の処理を実行します。</p>
		 * <p>ユーザイベントによって、CanvasクラスのインスタンスからKeyBoardEvent.KEY_DOWNイベントが発生した際に実行されます。</p>
		 * <p>publicメソッドとなっているため、リプレイ機能などの自動お絵かき処理を実現するために外部から実行することも可能です。</p>
		 * @param	tool	KeyBoardEvent.KEY_DOWN時のIToolインスタンスを指定します。
		 * @param	charCode	KeyBoardEvent.KEY_DOWN時のキーに対応する文字コード値を指定します。
		 * @param	text	KeyBoardEvent.KEY_DOWN時の関連するTextFieldインスタンスのtextプロパティを指定します。
		 */
		public function keyDown(tool:ITool, charCode:uint, text:String = null):void
		{
			var customEvent:DrawingTextEvent = new DrawingTextEvent(DrawingTextEvent.START_DRAWING, true, true, tool, charCode, text);
			dispatchEvent(customEvent);
			if (customEvent.isDefaultPrevented()) return;
			
			tool.keyDown(charCode, text);
		}
		
		/**
		 * <p>KeyBoardEvent.KEY_UPイベント発生時の処理を実行します。</p>
		 * <p>ユーザイベントによって、CanvasクラスのインスタンスからKeyBoardEvent.KEY_UPイベントが発生した際に実行されます。</p>
		 * <p>publicメソッドとなっているため、リプレイ機能などの自動お絵かき処理を実現するために外部から実行することも可能です。</p>
		 * @param	tool	KeyBoardEvent.KEY_UP時のIToolインスタンスを指定します。
		 * @param	charCode	KeyBoardEvent.KEY_UP時のキーに対応する文字コード値を指定します。
		 * @param	text	KeyBoardEvent.KEY_UP時の関連するTextFieldインスタンスのtextプロパティを指定します。
		 */
		public function keyUp(tool:ITool, charCode:uint, text:String = null):void
		{
			var customEvent:DrawingTextEvent = new DrawingTextEvent(DrawingTextEvent.STOP_DRAWING, true, true, tool, charCode, text);
			dispatchEvent(customEvent);
			if (customEvent.isDefaultPrevented()) return;
			
			tool.keyUp(charCode, text);
		}
		
		/**
		 * <p>FocusEvent.MOUSE_FOCUS_CHANGEイベント発生時の処理を実行します。</p>
		 * <p>ユーザイベントによって、CanvasクラスのインスタンスからFocusEvent.MOUSE_FOCUS_CHANGEイベントが発生した際に実行されます。</p>
		 * <p>publicメソッドとなっているため、リプレイ機能などの自動お絵かき処理を実現するために外部から実行することも可能です。</p>
		 * @param	tool	FocusEvent.MOUSE_FOCUS_CHANGE時のIToolインスタンスを指定します。
		 */
		public function mouseFocusChange(tool:ITool):void
		{
			var customEvent:DrawingFocusChange = new DrawingFocusChange(DrawingFocusChange.MOUSE_FOCUS_CHANGE, true, true, tool);
			dispatchEvent(customEvent);
			if (customEvent.isDefaultPrevented()) return;
			
			tool.mouseFocusChange();
		}
		
		//----------------------------------------------------------------------
		//  event handler
		//----------------------------------------------------------------------
		//------------------------------
		//  event handler
		//------------------------------
		/**
		 * handler of Event.CHANGE
		 *  dispatched from _canvasData
		 * @param event
		 */
		private function _canvasData_changeHandler(event:DataEvent):void
		{
			
		}
		
		/**
		 * handler of MouseEvent.MOUSE_DOWN
		 *  dispatched from _canvas
		 * @param event
		 */
		private function _canvas_mouseDownHandler(event:MouseEvent):void
		{
			mouseDown(_canvasData.activeTool, _canvas.mouseX, _canvas.mouseY);
		}
		
		/**
		 * handler of MouseEvent.MOUSE_MOVE
		 *  dispatched from _canvas
		 * @param event
		 */
		private function _canvas_mouseMoveHandler(event:MouseEvent):void
		{
			mouseMove(_canvasData.activeTool, _canvas.mouseX, _canvas.mouseY);
		}
		
		/**
		 * handler of MouseEvent.MOUSE_UP and MouseEvent.
		 *  dispatched from _canvas
		 * @param event
		 */
		private function _canvas_mouseUpHandler(event:MouseEvent):void
		{
			mouseUp(_canvasData.activeTool, _canvas.mouseX, _canvas.mouseY);
		}
		
		/**
		 * handler of KeyBoardEvent.KEY_DOWN
		 *  dispatched from _canvas
		 * @param event
		 */
		private function _canvas_keyDownHandler(event:KeyboardEvent):void
		{
			var text:String;
			if (event.target is TextField) text = TextField(event.target).text;
			keyDown(_canvasData.activeTool, event.charCode, text);
		}
		
		/**
		 * handler of KeyBoardEvent.KEY_UP
		 *  dispatched from _canvas
		 * @param event
		 */
		private function _canvas_keyUpHandler(event:KeyboardEvent):void
		{
			var text:String;
			if (event.target is TextField) text = TextField(event.target).text;
			keyUp(_canvasData.activeTool, event.charCode, text);
		}
		
		/**
		 * handler of FocusEvent.MOUSE_FOCUS_CHANGE
		 *  dispatched from _canvas
		 */
		private function _canvas_mouseFocusChangeHandler(event:FocusEvent):void
		{
			mouseFocusChange(_canvasData.activeTool);
		}
	}
}