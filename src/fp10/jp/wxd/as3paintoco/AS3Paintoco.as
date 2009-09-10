package jp.wxd.as3paintoco
{
	import com.adobe.images.JPGEncoder;
	import com.adobe.images.PNGEncoder;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import jp.wxd.as3paintoco.command.MouseDownCommand;
	import jp.wxd.as3paintoco.command.ReplayCommand;
	import jp.wxd.as3paintoco.command.ReplayQueue;
	import jp.wxd.as3paintoco.core.CanvasCore;
	import jp.wxd.as3paintoco.display.Canvas;
	import jp.wxd.as3paintoco.events.DrawingEvent;
	import jp.wxd.as3paintoco.events.DrawingFocusChange;
	import jp.wxd.as3paintoco.events.DrawingTextEvent;
	import jp.wxd.as3paintoco.events.ReplayEvent;
	import jp.wxd.as3paintoco.tools.ITool;
	import jp.wxd.as3paintoco.tools.TextTool;
	import jp.wxd.core.command.Commands;
	import jp.wxd.core.command.IRedoableCommand;
	import jp.wxd.utils.clone;
	
	/**
	 * <p>Replay開始時、終了時に送出されるイベントです</p>
	 * <p></p>
	 * 
	 * @eventType jp.wxd.as3paintoco.events.ReplayEvent.START_REPLAY
	 */
	[Event( name = "startReplay", type = "jp.wxd.as3paintoco.events.DrawingEvent" )]
	
	/**
	 * <p>Replay終了時、終了時に送出されるイベントです</p>
	 * <p></p>
	 * 
	 * @eventType jp.wxd.as3paintoco.events.ReplayEvent.END_REPLAY
	 */
	[Event( name = "endReplay", type = "jp.wxd.as3paintoco.events.DrawingEvent" )]
	
	/**
	 * <p>AS3Paintocoはぺいんとこを利用する際に、インスタンス化するクラスです。</p>
	 * <code>
	 * <pre>
	 * // create AS3Paintoco
	 * var paint:AS3Paintoco = new AS3Paintoco(container, 465, 465);
	 * paint.applyTool(new PenTool());
	 * paint.activate();
	 * </pre>
	 * </code>
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class AS3Paintoco extends EventDispatcher
	{
		//----------------------------------------------------------------------
		//  static properties
		//----------------------------------------------------------------------
		//------------------------------
		//  public static properties
		//------------------------------
		/**
		 * <p>save()メソッドのデフォルトファイル名を取得します。</p>
		 * @see	#save()
		 */
		public static const DEFAULT_FILE_NAME:String = "as3paintoco";
		
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		//------------------------------
		//  public properties
		//------------------------------
		protected var _replayable:Boolean;
		/**
		 * <p>リプレイ可否を設定、取得します。初期状態はリプレイ機能はOFFです。</p>
		 */
		public function get replayable():Boolean
		{
			return _replayable;
		}
		/** @private */
		public function set replayable(value:Boolean):void
		{
			_replayable = value;
		}
		
		/**
		 * <p>キャンバスの背景を表すDisplayObjectインスタンスを設定または取得します。</p>
		 */
		public function get background():DisplayObject
		{
			return _canvas.background;
		}
		/** @private */
		public function set background(value:DisplayObject):void
		{
			_canvas.background = value;
			addHistory(function():void { background = value; },null);
		}
		
		private var _color:uint = 0xFFFFFF;
		/**
		 * <p>キャンバスの色を設定または取得します。</p>
		 */
		public function get color():uint
		{
			return _color;
		}
		/** @private */
		public function set color(value:uint):void
		{
			_color = value;
			createBackground();
		}
		
		protected var _canvas:Canvas;
		/**
		 * <p>キャンバスを取得します。</p>
		 */
		public function get canvas():Canvas
		{
			return _canvas;
		}
		
		protected var _width:Number;
		/**
		 * <p>キャンバスの幅を取得します。</p>
		 */
		public function get width():Number
		{
			return _width;
		}
		
		protected var _height:Number;
		/**
		 * <p>キャンバスの高さを取得します。</p>
		 */
		public function get height():Number
		{
			return _height;
		}
		
		protected var _isActive:Boolean;
		/**
		 * <p>アクティブ状態を取得します。</p>
		 */
		public function get isActive():Boolean
		{
			return _isActive;
		}
		
		//------------------------------
		//  protected properties
		//------------------------------
		/**
		 * CanvasCore instance
		 */
		protected var _canvasCore:CanvasCore;
			
		/**
		 * Replay commands
		 */
		protected var _replayQueue:ReplayQueue;
		
		
		//----------------------------------------------------------------------
		//  methods
		//----------------------------------------------------------------------
		//------------------------------
		//  public methods
		//------------------------------
		/**
		 * <p>AS3Paintocoクラスは、as3paintocoを使用する際にインスタンス化するクラスです。</p>
		 */
		public function AS3Paintoco(container:DisplayObjectContainer,
			width:Number, height:Number) 
		{
			if (!(container is DisplayObjectContainer)) 
				throw ArgumentError("container is not instance of DisplayObjectContainer.");
			_width = width;
			_height = height;
			_canvasCore = new CanvasCore(_width, _height);
			_canvas = _canvasCore.canvas;
			container.addChild(_canvas);
			
			_replayQueue = new ReplayQueue();
		}
		
		/**
		 * <p>キャンバスをアクティブにし、ユーザーイベントを受け付けます。ユーザは画を描くことが出来ます。</p>
		 */
		public function activate():void
		{
			activateCanvasCoreListener();
			_canvasCore.activate();
			_isActive = true;
		}
		
		/**
		 * <p>キャンバスを非アクティブにし、ユーザーイベントを受け付けを中止します。ユーザは画を描くことが出来ません。</p>
		 */
		public function deactivate():void
		{
			deactivateCanvasCoreListener();
			_canvasCore.deactivate();
			_isActive = false;
		}
		
		/**
		 * <p>キャンバスを初期化する際に利用します。</p>
		 */
		public function initialize(width:Number = 0, height:Number = 0):void
		{
			if (width != 0) _width = width;
			if (height != 0) _height = height;
			_canvasCore.initialize(_width, _height);
			addHistory(initialize, [_width, _height]);
		}
		
		/**
		 * <p>直前の処理を取り消します。</p>
		 */
		public function undo():void
		{
			if (!_canvasCore.stack.hasPrevious) return;
			var command:IRedoableCommand = _canvasCore.stack.previous;
			if (command) MouseDownCommand(command).undo();
			addHistory(undo, null);
		}
		
		/**
		 * <p>直前の処理をやり直します。</p>
		 */
		public function redo():void
		{
			if (!_canvasCore.stack.hasNext) return;
			var command:IRedoableCommand = _canvasCore.stack.next;
			if (command) MouseDownCommand(command).redo();
			addHistory(redo, null);
		}
		
		/**
		 * <p>いままでの操作をリプレイします。</p>
		 * @param	speed
		 */
		public function replay(speed:Number):void
		{
			deactivate();
			_canvasCore.initialize(_width, _height);
			_replayQueue.addEventListener(Event.COMPLETE, 
				_replayQueue_completeHandler);
			_replayQueue.replay(speed);
			dispatchEvent(new ReplayEvent(ReplayEvent.START_REPLAY));
		}
		
		/**
		 * <p>IToolを適用します。</p>
		 * @param	tool
		 */
		public function applyTool(tool:ITool):void
		{
			if (tool is TextTool) tool.options.stage = _canvas.stage;
			_canvasCore.applyTool(tool);
			addHistory(applyTool, [tool]);
		}
		
		/**
		 * <p>キャンバスをローカルファイルシステムにファイルを保存するためのダイアログボックスを開きます。</p>
		 * <p>ファイルの形式はPNG、またはJPEG形式です。</p>
		 * @param	fileName	保存時の初期ファイル名を指定します。
		 * @param	mode	PNG形式で保存したい場合は、pngを指定します。JPEG形式で保存したい場合は、jpgもしくはjpegと指定します。
		 * @param	quality	modeをjpgした際に使用されるJPEG画像の画質を0.0～1.0で指定します。modeをpngに指定した場合は無視されます。
		 */
		public function save(fileName:String = DEFAULT_FILE_NAME,
			mode:String = "png", quality:Number = 80):void
		{
			var bitmapData:BitmapData = new BitmapData(
				_width, _height, true, 0x00000000
			);
			bitmapData.draw(_canvas);
			
			var byteArray:ByteArray;
			
			switch (mode)
			{
				case "png":
				{
					byteArray = PNGEncoder.encode(bitmapData);
					break;
				}
				case "jpeg":
				case "jpg":
				{
					byteArray = new JPGEncoder(quality).encode(bitmapData);
					break;
				}
			}
			
			var fileReference:FileReference = new FileReference();
			fileReference.save(byteArray, fileName);
		}
		
		/**
		 * <p>リプレイ対象とする処理を履歴へ追加します。</p>
		 * @param	method
		 * @param	params
		 */
		public function addHistory(method:Function, params:Array = null):void
		{
			if (!_isActive || !_replayable) return;
			_replayQueue.push(
				new Commands(
					new ReplayCommand(null, method, params)
				)
			);
		}
		
		//------------------------------
		//  protected methods
		//------------------------------
		/**
		 * create background by _color properties
		 */
		protected function createBackground():void
		{
			var bitmapData:BitmapData = new BitmapData(_width, _height, false, _color);
			_canvasCore.canvas.background = new Bitmap(bitmapData);
		}
		
		/**
		 * activate canvas event listener
		 */
		protected function activateCanvasCoreListener():void
		{
			_canvasCore.addEventListener(DrawingEvent.START_DRAWING, 
				_canvasCore_startDrawingHandler, false, int.MAX_VALUE);
			_canvasCore.addEventListener(DrawingEvent.MOVE_DRAWING, 
				_canvasCore_moveDrawingHandler, false, int.MAX_VALUE);
			_canvasCore.addEventListener(DrawingEvent.STOP_DRAWING, 
				_canvasCore_stopDrawingHandler, false, int.MAX_VALUE);
			_canvasCore.addEventListener(DrawingTextEvent.STOP_DRAWING, 
				_canvasCore_stopDrawingTextHandler, false, int.MAX_VALUE);
			_canvasCore.addEventListener(DrawingFocusChange.MOUSE_FOCUS_CHANGE, 
				_canvasCore_mouseFocusChangeHandler, false, int.MAX_VALUE);
		}
		
		/**
		 * deactivate canvas event listener
		 */
		protected function deactivateCanvasCoreListener():void
		{
			_canvasCore.removeEventListener(DrawingEvent.START_DRAWING, 
				_canvasCore_startDrawingHandler);
			_canvasCore.removeEventListener(DrawingEvent.MOVE_DRAWING, 
				_canvasCore_moveDrawingHandler);
			_canvasCore.removeEventListener(DrawingEvent.STOP_DRAWING, 
				_canvasCore_stopDrawingHandler);
			_canvasCore.removeEventListener(DrawingTextEvent.STOP_DRAWING, 
				_canvasCore_stopDrawingTextHandler);
			_canvasCore.removeEventListener(DrawingFocusChange.MOUSE_FOCUS_CHANGE, 
				_canvasCore_mouseFocusChangeHandler);
		}
		
		//----------------------------------------------------------------------
		//  event handler
		//----------------------------------------------------------------------
		//------------------------------
		//  protected event handler
		//------------------------------
		/**
		 * handler of Event.COMPLETE
		 *  dispatched from _replayQueue
		 * @param	event
		 */
		protected function _replayQueue_completeHandler(event:Event):void
		{
			_replayQueue.removeEventListener(Event.COMPLETE,
				_replayQueue_completeHandler);
			activate();
			dispatchEvent(new ReplayEvent(ReplayEvent.END_REPLAY));
		}
		
		/**
		 * handler of DrawingEvent.START_DRAWING
		 *  dispatched from _canvasCore
		 * @param event
		 */
		private function _canvasCore_startDrawingHandler(event:DrawingEvent):void
		{
			addHistory(_canvasCore.mouseDown, [event.tool, event.x, event.y]);
		}
		
		/**
		 * handler of DrawingEvent.START_DRAWING
		 *  dispatched from _canvasCore
		 * @param event
		 */
		private function _canvasCore_moveDrawingHandler(event:DrawingEvent):void
		{
			addHistory(_canvasCore.mouseMove, [event.tool, event.x, event.y]);
		}
		
		/**
		 * handler of DrawingEvent.START_DRAWING
		 *  dispatched from _canvasCore
		 * @param event
		 */
		private function _canvasCore_stopDrawingHandler(event:DrawingEvent):void
		{
			addHistory(_canvasCore.mouseUp, [event.tool, event.x, event.y]);
		}
		
		/**
		 * handler of DrawingTextEvent.STOP_DRAWING
		 *  dispatched from _canvasCore
		 * @param event
		 */
		private function _canvasCore_stopDrawingTextHandler(
				event:DrawingTextEvent):void
		{
			addHistory(_canvasCore.keyUp, [event.tool, event.charCode, event.text]);
		}
		
		/**
		 * handler of DrawingFocusChange.MOUSE_FOCUS_CHANGE
		 *  dispatched from _canvasCore
		 * @param event
		 */
		private function _canvasCore_mouseFocusChangeHandler(
				event:DrawingFocusChange):void
		{
			addHistory(_canvasCore.mouseFocusChange, [event.tool]);
		}
	}
}