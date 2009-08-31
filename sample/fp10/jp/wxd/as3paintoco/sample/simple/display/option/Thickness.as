package jp.wxd.as3paintoco.sample.simple.display.option
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.DataEvent;
	import flash.events.MouseEvent;
	import jp.wxd.as3paintoco.sample.simple.data.Data;
	
	/**
	 * ...
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class Thickness extends Sprite
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		private var _maxThickness:Number = 36;
		/**
		 * max thickness
		 */
		public function set maxThickness(value:Number):void
		{
			_maxThickness = value;
		}
		
		private var _minThickness:Number = 1;
		/**
		 * min thickness
		 */
		public function set minThickness(value:Number):void
		{
			_minThickness = value;
		}
		
		private var _color:uint = 0x0000000;
		/**
		 * color
		 */
		public function set color(value:uint):void
		{
			_color = value & 0x00FFFFFF;
			_alpha = (value >> 24 & 0xFF) / 0xFF;
			
			prepare();
		}
		
		private var _thickness:Number = 10;
		/**
		 * thickness
		 */
		public function get thickness():Number
		{
			return _thickness;
		}
		/** @private */
		public function set thickness(value:Number):void
		{
			_thickness = value;
			prepare();
		}
		
		/**
		 * color alpha
		 */
		private var _alpha:Number = 1.0;
		
		/**
		 * data
		 */
		private var _data:Data;
		
		/**
		 * indicate whether click or not
		 */
		private var _isPressed:Boolean = false;
		
		//------------------------------
		//  display object
		//------------------------------
		/**
		 * pen container
		 */
		private var _penContainer:Sprite;
		
		/**
		 * pen
		 */
		private var _pen:Shape;
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		/**
		 * constructor
		 */
		public function Thickness(data:Data) 
		{
			_data = data;
			_data.addEventListener(Event.CHANGE, _data_changeHandler);
			prepare();
			activate();
		}
		
		/**
		 * prepare DisplayObject
		 */
		private function prepare():void
		{
			preparePenContainer();
			preparePen();
		}
		
		/**
		 * prepare pen container
		 */
		private function preparePenContainer():void
		{
			if (!_penContainer)
			{
				_penContainer = new Sprite();
				addChild(_penContainer);
			}
			_penContainer.graphics.clear();
			_penContainer.graphics.beginFill(0xFFFFFF - _color, 1.0);
			_penContainer.graphics.drawRect(0, 0, _maxThickness, _maxThickness);
		}
		
		/**
		 * prepare pen
		 */
		private function preparePen():void
		{
			if (!_pen)
			{
				_pen = new Shape();
				_pen.x = _penContainer.width / 2 ;
				_pen.y = _penContainer.height / 2;
				_penContainer.addChild(_pen);
			}
			_pen.graphics.clear();
			_pen.graphics.beginFill(_color, _alpha);
			_pen.graphics.drawCircle(0, 0, _thickness / 2);
		}
		
		/**
		 * activate
		 */
		private function activate():void
		{
			_penContainer.addEventListener(MouseEvent.MOUSE_DOWN, _penContainer_mouseDownHandler);
			_penContainer.addEventListener(MouseEvent.MOUSE_MOVE, _penContainer_mouseMoveHandler);
			_penContainer.addEventListener(MouseEvent.MOUSE_UP, _penContainer_mouseUpHandler);
		//	_penContainer.addEventListener(MouseEvent.ROLL_OUT, _penContainer_mouseUpHandler);
		}
		
		//------------------------------
		//  event handler
		//------------------------------
		/**
		 * handler of Event.CHANGE
		 *  dispatched from _data
		 * @param	event
		 */
		private function _data_changeHandler(event:DataEvent):void
		{
			color = _data.color;
			thickness = _data.thickness;
		}
		
		/**
		 * handler of MouseEvent.MOUSE_DOWN
		 *  dispatched from _penContaienr
		 * @param event
		 */
		private function _penContainer_mouseDownHandler(event:MouseEvent):void
		{
			_isPressed = true;
			_penContainer_mouseMoveHandler(event);
		}
		
		/**
		 * handler of MouseEvent.MOUSE_MOVE
		 *  dispatched from _penContainer
		 * @param	event
		 */
		private function _penContainer_mouseMoveHandler(event:MouseEvent):void
		{
			if (!_isPressed) return;
			_thickness = Math.sqrt(Math.pow(event.localX - _pen.x, 2) + Math.pow(event.localY - _pen.y, 2));
			
			_thickness *= 2;
			if (_thickness < _minThickness) _thickness = _minThickness;
			if (_maxThickness < _thickness) _thickness = _maxThickness;
			preparePen();
//			_data.thickness = _thickness;
		}
		
		/**
		 * handler of MouseEvent.MOUSE_UP
		 *  dispatched from _penContainer
		 * @param	event
		 */
		private function _penContainer_mouseUpHandler(event:MouseEvent):void
		{
			_isPressed = false;
			dispatchEvent(new Event(Event.CHANGE, true));
		}
	}
}