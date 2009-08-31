package jp.wxd.as3paintoco.sample.simple.data 
{
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.ColorTransform;
	import jp.wxd.as3paintoco.command.ReplayQueue;
	import jp.wxd.as3paintoco.core.CanvasCore;
	import jp.wxd.as3paintoco.tools.CircleTool;
	import jp.wxd.as3paintoco.tools.ITool;
	import jp.wxd.as3paintoco.tools.LineTool;
	import jp.wxd.as3paintoco.tools.PenTool;
	import jp.wxd.as3paintoco.tools.SelectTool;
	import jp.wxd.as3paintoco.tools.SquareTool;
	import jp.wxd.as3paintoco.tools.TextTool;
	
	/**
	 * 
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class Data extends EventDispatcher
	{
		//----------------------------------------------------------------------
		//  prorperties
		//----------------------------------------------------------------------
		private var _canvasCore:CanvasCore;
		/**
		 * canvas core
		 */
		public function get canvasCore():CanvasCore
		{
			return _canvasCore;
		}
		/** @private */
		public function set canvasCore(value:CanvasCore):void
		{
			_canvasCore = value;
		}
		
		private var _replayQueue:ReplayQueue;
		/**
		 * ReplayCommand Queue
		 */
		public function get replayQueue():ReplayQueue
		{
			return _replayQueue;
		}
		
		//------------------------------
		//  ITool
		//------------------------------
		private var _penTool:ITool;
		/**
		 * pen tool
		 */
		public function get penTool():ITool
		{
			return _penTool;
		}
		
		private var _lineTool:ITool;
		/**
		 * line tool
		 */
		public function get lineTool():ITool
		{
			return _lineTool;
		}
		
		private var _squareTool:ITool;
		/**
		 * square tool
		 */
		public function get squareTool():ITool
		{
			return _squareTool;
		}
		
		private var _circleTool:ITool;
		/**
		 * circle tool
		 */
		public function get circleTool():ITool
		{
			return _circleTool;
		}
		
		private var _selectTool:ITool;
		/**
		 * select tool
		 */
		public function get selectTool():ITool
		{
			return _selectTool;
		}
		
		private var _textTool:ITool;
		/**
		 * text tool
		 */
		public function get textTool():ITool
		{
			return _textTool;
		}
		
		//------------------------------
		//  tool options
		//------------------------------
		private var _color:uint;
		/**
		 * tool option color
		 */
		public function get color():uint
		{
			return _color;
		}
		/**
		 * @private
		 */
		public function set color(value:uint):void
		{
			_color = value;
			dispatchEvent(new DataEvent(Event.CHANGE, false, false, "color"));
		}
		
		private var _thickness:uint;
		/**
		 * tool option thickness
		 */
		public function get thickness():uint
		{
			return _thickness;
		}
		/**
		 * @private
		 */
		public function set thickness(value:uint):void
		{
			_thickness = value;
			dispatchEvent(new DataEvent(Event.CHANGE, false, false, "thickness"));
		}
		
		private var _filters:Array;
		/**
		 * tool option filters
		 */
		public function get filters():Array
		{
			return _filters;
		}
		/**
		 * @private
		 */
		public function set filters(value:Array):void
		{
			_filters = value;
			dispatchEvent(new DataEvent(Event.CHANGE, false, false, "filters"));
		}
		
		private var _backgroundColor:uint;
		/**
		 * background color
		 */
		public function get backgroundColor():uint
		{
			return _backgroundColor;
		}
		/**
		 * @private
		 */
		public function set backgroundColor(value:uint):void
		{
			_backgroundColor = value;
			dispatchEvent(new DataEvent(Event.CHANGE, false, false, "backgroundColor"));
		}
		
		
		//------------------------------
		//  other properties
		//------------------------------
		
		private var _isReplaying:Boolean = false;
		/**
		 * indicate whether during replaying or not
		 */
		public function get isReplaying():Boolean
		{
			return _isReplaying;
		}
		/** @private */
		public function set isReplaying(value:Boolean):void
		{
			_isReplaying = value;
			dispatchEvent(new DataEvent(Event.CHANGE, false, false, "isReplaying"));
		}
		
		private var _normalColorTransform:ColorTransform;
		/**
		 * ColorTransform for normal status
		 */
		public function get normalColorTransform():ColorTransform
		{
			return _normalColorTransform;
		}
		
		private var _selectedColorTransform:ColorTransform;
		/**
		 * ColorTransform for selected status
		 */
		public function get selectedColorTransform():ColorTransform
		{
			return _selectedColorTransform;
		}
		
		
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		/**
		 * constructor
		 */
		public function Data() 
		{
			_replayQueue = new ReplayQueue();
			_replayQueue.addEventListener(Event.COMPLETE, _replayQueue_completeHandler);
			_penTool = new PenTool();
			_lineTool = new LineTool();
			_squareTool = new SquareTool();
			_circleTool = new CircleTool();
			_textTool = new TextTool();
			_selectTool = new SelectTool();
			_normalColorTransform = new ColorTransform();
			_selectedColorTransform = new ColorTransform();
		}
		
		//------------------------------
		//  event handler
		//------------------------------
		/**
		 * event handler of Event.COMPLETE
		 *  dispatched from _replayQueue
		 * @param	event
		 */
		private function _replayQueue_completeHandler(event:Event):void
		{
			isReplaying = false;
		}
	}
}