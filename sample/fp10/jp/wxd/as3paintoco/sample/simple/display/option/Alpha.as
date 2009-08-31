package jp.wxd.as3paintoco.sample.simple.display.option
{
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import jp.wxd.as3paintoco.sample.simple.data.Data;
	
	/**
	 * ...
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class Alpha extends Sprite
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		//------------------------------
		//  static properties
		//------------------------------
		/**
		 * width of container
		 */
		private static const WIDTH_CONTAINER:Number = 98;
		
		/**
		 * height of container
		 */
		private static const HEIGHT_CONTAINER:Number = 18;
		
		//------------------------------
		//  public properties
		//------------------------------
		private var _color:uint = 0x00000FF;
		/**
		 * color
		 */
		public function get color():uint
		{
			return uint(int(0xFF * _alpha) << 24) | _color;
		}
		
		/** @private */
		public function set color(value:uint):void
		{
			_color = value & 0x00FFFFFF;
			_alpha = (value >> 24 & 0xFF) / 0xFF;
			prepare();
		}
		
		/**
		 * alpha
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
		 * container
		 */
		private var _container:Sprite;
		
		/**
		 * bar
		 */
		private var _bar:Shape;
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		/**
		 * constructor
		 */
		public function Alpha(data:Data) 
		{
			_data = data;
			_data.addEventListener(Event.CHANGE, _data_changeHandler);
			prepare();
			activate();
		}
		
		/**
		 * prepare
		 */
		private function prepare():void
		{
			prepareContainer();
			prepareBar();
		}
		
		/**
		 * prepare container
		 */
		private function prepareContainer():void
		{
			if (!_container)
			{
				_container = new Sprite();
				addChild(_container);
			}
			_container.graphics.clear();
			_container.graphics.beginFill(0, 0.0);
			_container.graphics.drawRect(0, 0, WIDTH_CONTAINER, HEIGHT_CONTAINER);
		}
		
		/**
		 * prepare bar
		 */
		private function prepareBar():void
		{
			if (!_bar)
			{
				_bar = new Shape();
				addChild(_bar);
			}
			_bar.graphics.clear();
			_bar.graphics.beginFill(_color, _alpha);
			_bar.graphics.drawRect(0, 0, WIDTH_CONTAINER * _alpha, HEIGHT_CONTAINER);
			
			_bar.graphics.lineStyle(1, 0xFFFFFF, 1.0);
			_bar.graphics.moveTo(WIDTH_CONTAINER * _alpha, HEIGHT_CONTAINER);
			_bar.graphics.lineTo(WIDTH_CONTAINER * _alpha, 0);
			
		}
		
		private function activate():void
		{
			_container.addEventListener(MouseEvent.MOUSE_DOWN, _container_mouseDownHandler);
			_container.addEventListener(MouseEvent.MOUSE_MOVE, _container_mouseMoveHandler);
			_container.addEventListener(MouseEvent.MOUSE_UP, _container_mouseUpHandler);
			_container.addEventListener(MouseEvent.ROLL_OUT, _container_mouseUpHandler);
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
		}
		
		/**
		 * handler of MouseEvent.MOUSE_DOWN
		 *  dispatched from _container
		 * @param event
		 */
		private function _container_mouseDownHandler(event:MouseEvent):void
		{
			_isPressed = true;
			_container_mouseMoveHandler(event);
		}
		
		/**
		 * handler of MouseEvent.MOUSE_MOVE
		 *  dispatched from _container
		 * @param	event
		 */
		private function _container_mouseMoveHandler(event:MouseEvent):void
		{
			if (!_isPressed) return;
			_alpha = event.localX / WIDTH_CONTAINER;
			if (1.0 < _alpha) _alpha = 1.0;
			if (_alpha < 0.0) _alpha = 0.0;
			prepareBar();
//			_data.color = uint(int(0xFF * _alpha) << 24) | _color;
		}
		
		/**
		 * handler of MouseEvent.MOUSE_UP
		 *  dispatched from _container
		 * @param	event
		 */
		private function _container_mouseUpHandler(event:MouseEvent):void
		{
			_isPressed = false;
			dispatchEvent(new Event(Event.CHANGE, true));
		}
	}
}