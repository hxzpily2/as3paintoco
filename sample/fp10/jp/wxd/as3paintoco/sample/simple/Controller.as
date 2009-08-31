package jp.wxd.as3paintoco.sample.simple 
{
	import caurina.transitions.Tweener;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.DataEvent;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import jp.wxd.as3paintoco.command.MouseDownCommand;
	import jp.wxd.as3paintoco.command.ReplayCommand;
	import jp.wxd.as3paintoco.core.CanvasCore;
	import jp.wxd.as3paintoco.display.Canvas;
	import jp.wxd.as3paintoco.events.DrawingEvent;
	import jp.wxd.as3paintoco.events.DrawingFocusChange;
	import jp.wxd.as3paintoco.events.DrawingTextEvent;
	import jp.wxd.as3paintoco.sample.simple.data.Data;
	import jp.wxd.as3paintoco.sample.simple.display.option.Alpha;
	import jp.wxd.as3paintoco.sample.simple.display.option.Thickness;
	import jp.wxd.as3paintoco.sample.simple.setting.CanvasSetting;
	import jp.wxd.as3paintoco.sample.simple.setting.ToolSetting;
	import jp.wxd.as3paintoco.tools.ITool;
	import jp.wxd.as3paintoco.tools.PenTool;
	import jp.wxd.color.display.ColorPalette;
	import jp.wxd.core.command.Commands;
	import jp.wxd.core.command.IRedoableCommand;
	
	/**
	 * simple drawing toll sample
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class Controller 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		/**
		 * main time line linkaged to DocumenClass
		 * @param	mainTimeLine
		 */
		private var _mainTimeline:DocumentClass;
		
		/**
		 * data model
		 */
		private var _data:Data;
		
		//------------------------------
		//  display object
		//------------------------------
		/**
		 * background
		 */
		private var _background:Shape;
		
		/**
		 * canvas
		 */
		private var _canvas:Canvas;
		
		/**
		 * color palette
		 */
		private var _colorPalette:ColorPalette;
		
		/**
		 * alpha option
		 */
		private var _alphaOption:Alpha;
		
		/**
		 * thickness option
		 */
		private var _thicknessOption:Thickness;
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		/**
		 * constructor
		 * @param	mainTimeLine
		 */
		public function Controller(mainTimeLine:DocumentClass) 
		{
			_mainTimeline = mainTimeLine;
			_data = new Data();
			_data.addEventListener(Event.CHANGE, _data_changeHandler);
			prepare();
			initialize();
			activate();
		}
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------
		/**
		 * prepare
		 */
		private function prepare():void
		{
			prepareCanvas();
			prepareColorPalette();
			prepareCombobox();
			prepareOption();
			
			_data.normalColorTransform.color = CanvasSetting.NORMAL_ICON_COLOR;
			_data.selectedColorTransform.color = CanvasSetting.SELECTED_ICON_COLOR;
		}
		
		/**
		 * create canvas
		 */
		private function prepareCanvas():void
		{
			// create backgroud
			/*
			_background = new Shape();
			_background.graphics.lineStyle(1, 0xFFFFFFF);
			_background.graphics.beginFill(0x000000, 1.0);
			_background.graphics.drawRect(0, 0, CanvasSetting.CANVAS_WIDTH-2, CanvasSetting.CANVAS_HEIGHT-2);
			*/
			// create canvasCore
			_data.canvasCore = new CanvasCore(CanvasSetting.CANVAS_WIDTH, CanvasSetting.CANVAS_HEIGHT);
			_canvas = Canvas(_mainTimeline.addChild(_data.canvasCore.canvas));
			_canvas.x = (CanvasSetting.STAGE_WIDTH - CanvasSetting.CANVAS_WIDTH) / 2;
			_canvas.y = (CanvasSetting.STAGE_HEIGHT - CanvasSetting.CANVAS_HEIGHT) / 2;
			//_canvas.background = _background;
			_mainTimeline.addChild(_canvas);
		}
		
		/**
		 * create color palette
		 */
		private function prepareColorPalette():void
		{
			_colorPalette = new ColorPalette(0x33, 10, 1, 3);
			_colorPalette.visible = false;
			_mainTimeline.addChild(_colorPalette);
		}
		
		/**
		 * prepare Combobox
		 */
		private function prepareCombobox():void
		{
			//[todo] CanvasSettingへ移行
			// set effect option
			_mainTimeline.optionEffect.addItem( { label:"のーまる", data:{} } );
			_mainTimeline.optionEffect.addItem( { label:"影付き", data:{filters:[new DropShadowFilter()]} } );
			_mainTimeline.optionEffect.addItem( { label:"ふちどる", data: { filters:[new GlowFilter(0xffffff, 1, 4, 4, 20)] } } );
			
			// set effect option
			_mainTimeline.replaySpeed.addItem( { label:"ふつう", data: 5.0 } );
			_mainTimeline.replaySpeed.addItem( { label:"いそいそと", data: 10.0 } );
			_mainTimeline.replaySpeed.addItem( { label:"ものっそい", data: 20.0 } );
			_mainTimeline.replaySpeed.addItem( { label:"ちょっぱや", data: 30.0} );
		}
		
		/**
		 * prepare option
		 */
		private function prepareOption():void
		{
			_alphaOption = new Alpha(_data);
			_alphaOption.x = 1;
			_alphaOption.y = 1;
			
			_thicknessOption = new Thickness(_data);			
			_thicknessOption.x = 1;
			_thicknessOption.y = 1;
			
			_mainTimeline.optionAlpha.addChild(_alphaOption);
			_mainTimeline.optionThickness.addChild(_thicknessOption);
		}
		
		/**
		 * initialize
		 */
		private function initialize():void
		{
			initializeToolOptions();
			
			_data.canvasCore.applyTool(_data.penTool);
			_mainTimeline.optionWeight.value = _data.penTool.options.thickness;
			_mainTimeline.optionEffect.selectedIndex = 0;
			
			// initialize view
			var colorTransform:ColorTransform = new ColorTransform();
			colorTransform.color = ToolSetting.DEFAULT_PEN_COLOR;
			_mainTimeline.btnColor.color.transform.colorTransform = colorTransform;
			
			_data.color = ToolSetting.DEFAULT_PEN_COLOR;
			_data.thickness = ToolSetting.DEFAULT_PEN_THICKNESS;
			
			_data.backgroundColor = CanvasSetting.CANVAS_BACKGOUND_COLOR;
			
			btnPen_clickHandler();
			
			// for replay
			if (!_data.isReplaying) 
			{
				_data.replayQueue.push(new Commands(new ReplayCommand(null, initialize, null)));
			}
		}
		
		/**
		 * initializeToolOptions
		 */
		private function initializeToolOptions():void
		{
			_data.penTool.options = {
				thickness: ToolSetting.DEFAULT_PEN_THICKNESS,
				color: ToolSetting.DEFAULT_PEN_COLOR,
				filters: []
			};
			
			_data.lineTool.options = {
				thickness: ToolSetting.DEFAULT_PEN_THICKNESS,
				color: ToolSetting.DEFAULT_PEN_COLOR,
				filters: []
			};
			
			_data.squareTool.options = {
				thickness: ToolSetting.DEFAULT_PEN_THICKNESS,
				color: ToolSetting.DEFAULT_PEN_COLOR,
				filters: []
			};
			
			_data.circleTool.options = {
				thickness: ToolSetting.DEFAULT_PEN_THICKNESS,
				color: ToolSetting.DEFAULT_PEN_COLOR,
				filters: []
			};
			
			_data.textTool.options = {
				size: ToolSetting.DEFAULT_TEXT_SIZE,
				color: ToolSetting.DEFAULT_TEXT_COLOR,
				stage: _mainTimeline.stage,
				filters: []
			};
		}
		
		/**
		 * activate event listener
		 * @param	selectedIcon
		 */
		private function activate():void
		{
			// option
			_mainTimeline.btnColor.buttonMode = true;
			_mainTimeline.btnColor.addEventListener(MouseEvent.CLICK, btnColor_clickHandler);
			_mainTimeline.optionWeight.enabled = true;
			_mainTimeline.optionWeight.addEventListener(Event.CHANGE, optionWeight_changeHandler);
			_mainTimeline.optionEffect.enabled = true;
			_mainTimeline.optionEffect.addEventListener(Event.CHANGE, optionEffect_changeHandler);
			
			// tool
			_mainTimeline.btnSelect.buttonMode = true;
			_mainTimeline.btnSelect.addEventListener(MouseEvent.CLICK, btnSelect_clickHandler);
			_mainTimeline.btnPen.buttonMode = true;
			_mainTimeline.btnPen.addEventListener(MouseEvent.CLICK, btnPen_clickHandler);
			_mainTimeline.btnText.buttonMode = true;
			_mainTimeline.btnText.addEventListener(MouseEvent.CLICK, btnText_clickHandler);
			_mainTimeline.btnLine.buttonMode = true;
			_mainTimeline.btnLine.addEventListener(MouseEvent.CLICK, btnLine_clickHandler);
			_mainTimeline.btnSquare.buttonMode = true;
			_mainTimeline.btnSquare.addEventListener(MouseEvent.CLICK, btnSquare_clickHandler);
			_mainTimeline.btnCircle.buttonMode = true;
			_mainTimeline.btnCircle.addEventListener(MouseEvent.CLICK, btnCircle_clickHandler);
			
			_mainTimeline.optionAlpha.buttonMode = true;
			_mainTimeline.optionAlpha.addEventListener(Event.CHANGE, optionAlpha_changeHandler);
			_mainTimeline.optionThickness.buttonMode = true;
			_mainTimeline.optionThickness.addEventListener(Event.CHANGE, optionThickness_changeHandler);
			
			// plugin
			_mainTimeline.btnUndo.buttonMode = true;
			_mainTimeline.btnUndo.addEventListener(MouseEvent.CLICK, btnUndo_clickHandler);
			_mainTimeline.btnRedo.buttonMode = true;
			_mainTimeline.btnRedo.addEventListener(MouseEvent.CLICK, btnRedo_clickHandler);
			_mainTimeline.btnClear.buttonMode = true;
			_mainTimeline.btnClear.addEventListener(MouseEvent.CLICK, btnClear_clickHandler);
			
			// replay
			_mainTimeline.btnReplay.buttonMode = true;
			_mainTimeline.btnReplay.addEventListener(MouseEvent.CLICK, btnReplay_clickHandler);
			
			// background
			_mainTimeline.btnBgColor.buttonMode = true;
			_mainTimeline.btnBgColor.addEventListener(MouseEvent.CLICK, btnBgColor_clickHandler);
			
			// canvas
			_data.canvasCore.addEventListener(DrawingEvent.START_DRAWING, canvasCore_startDrawingHandler);
			_data.canvasCore.addEventListener(DrawingEvent.MOVE_DRAWING, canvasCore_moveDrawingHandler);
			_data.canvasCore.addEventListener(DrawingEvent.STOP_DRAWING, canvasCore_stopDrawingHandler);
			_data.canvasCore.addEventListener(DrawingTextEvent.STOP_DRAWING, canvasCore_stopDrawingTextHandler);
			_data.canvasCore.addEventListener(DrawingFocusChange.MOUSE_FOCUS_CHANGE, canvasCore_mouseFocusChangeHandler);
			_data.canvasCore.activate();
			
			// replay option
			_mainTimeline.replaySpeed.enabled = true;
		}
		
		/**
		 * deactivate event listener
		 */
		private function deactivate():void
		{
			// option
			_mainTimeline.btnColor.buttonMode = false;
			_mainTimeline.btnColor.removeEventListener(MouseEvent.CLICK, btnColor_clickHandler);
			_mainTimeline.optionWeight.enabled = false;
			_mainTimeline.optionWeight.removeEventListener(Event.CHANGE, optionWeight_changeHandler);
			_mainTimeline.optionEffect.enabled = false;
			_mainTimeline.optionEffect.removeEventListener(Event.CHANGE, optionEffect_changeHandler);
			
			// tool
			_mainTimeline.btnSelect.buttonMode = false;
			_mainTimeline.btnSelect.removeEventListener(MouseEvent.CLICK, btnSelect_clickHandler);
			_mainTimeline.btnPen.buttonMode = false;
			_mainTimeline.btnPen.removeEventListener(MouseEvent.CLICK, btnPen_clickHandler);
			_mainTimeline.btnText.buttonMode = false;
			_mainTimeline.btnText.removeEventListener(MouseEvent.CLICK, btnText_clickHandler);
			_mainTimeline.btnLine.buttonMode = false;
			_mainTimeline.btnLine.removeEventListener(MouseEvent.CLICK, btnLine_clickHandler);
			_mainTimeline.btnSquare.buttonMode = false;
			_mainTimeline.btnSquare.removeEventListener(MouseEvent.CLICK, btnSquare_clickHandler);
			_mainTimeline.btnCircle.buttonMode = false;
			_mainTimeline.btnCircle.removeEventListener(MouseEvent.CLICK, btnCircle_clickHandler);
			
			_mainTimeline.optionAlpha.buttonMode = false;
			_mainTimeline.optionAlpha.removeEventListener(Event.CHANGE, optionAlpha_changeHandler);
			_mainTimeline.optionThickness.buttonMode = false;
			_mainTimeline.optionThickness.removeEventListener(Event.CHANGE, optionThickness_changeHandler);
			
			// plugin
			_mainTimeline.btnUndo.buttonMode = false;
			_mainTimeline.btnUndo.removeEventListener(MouseEvent.CLICK, btnUndo_clickHandler);
			_mainTimeline.btnRedo.buttonMode = false;
			_mainTimeline.btnRedo.removeEventListener(MouseEvent.CLICK, btnRedo_clickHandler);
			_mainTimeline.btnClear.buttonMode = false;
			_mainTimeline.btnClear.removeEventListener(MouseEvent.CLICK, btnClear_clickHandler);
			
			// replay
			_mainTimeline.btnReplay.buttonMode = false;
			_mainTimeline.btnReplay.removeEventListener(MouseEvent.CLICK, btnReplay_clickHandler);
			
			// background
			_mainTimeline.btnBgColor.buttonMode = false;
			_mainTimeline.btnBgColor.removeEventListener(MouseEvent.CLICK, btnBgColor_clickHandler);
			
			// canvas
			_data.canvasCore.removeEventListener(DrawingEvent.START_DRAWING, canvasCore_startDrawingHandler);
			_data.canvasCore.removeEventListener(DrawingEvent.MOVE_DRAWING, canvasCore_moveDrawingHandler);
			_data.canvasCore.removeEventListener(DrawingEvent.STOP_DRAWING, canvasCore_stopDrawingHandler);
			_data.canvasCore.removeEventListener(DrawingTextEvent.STOP_DRAWING, canvasCore_stopDrawingTextHandler);
			_data.canvasCore.removeEventListener(DrawingFocusChange.MOUSE_FOCUS_CHANGE, canvasCore_mouseFocusChangeHandler);
			_data.canvasCore.deactivate();
			
			// replay option
			_mainTimeline.replaySpeed.enabled = false;
		}
		
		/**
		 * change icon color
		 * @param	event
		 */
		private function changeIconColor(selectedIcon:DisplayObject):void
		{
			_mainTimeline.btnSelect.transform.colorTransform = _data.normalColorTransform;
			_mainTimeline.btnPen.transform.colorTransform = _data.normalColorTransform;
			_mainTimeline.btnText.transform.colorTransform = _data.normalColorTransform;
			_mainTimeline.btnLine.transform.colorTransform = _data.normalColorTransform;
			_mainTimeline.btnSquare.transform.colorTransform = _data.normalColorTransform;
			_mainTimeline.btnCircle.transform.colorTransform = _data.normalColorTransform;
			selectedIcon.transform.colorTransform = _data.selectedColorTransform;
		}
		
		/**
		 * pickup color
		 * @param	mouseX
		 * @param	mouseY
		 */
		private function pickupColor(mouseX:Number, mouseY:Number):void
		{
			var color32:uint = _colorPalette.bitmapData.getPixel32(mouseX, mouseY);
			var color24:uint = color32 & 0x00FFFFFF;
			var alpha:uint = (color32 >> 24) & 0xFF;
			_colorPalette.alpha = 0.0;
			_colorPalette.visible = false;
			
			if (!alpha) return;
			
			// save color
			_data.color = color32;
			
			// for replay
			if (!_data.isReplaying) _data.replayQueue.push(new Commands(new ReplayCommand(null, pickupColor, [mouseX, mouseY])));
		}
		
		/**
		 * pickup color
		 * @param	mouseX
		 * @param	mouseY
		 */
		private function pickupBgColor(mouseX:Number, mouseY:Number):void
		{
			var color32:uint = _colorPalette.bitmapData.getPixel32(mouseX, mouseY);
			var color24:uint = color32 & 0x00FFFFFF;
			var alpha:uint = (color32 >> 24) & 0xFF;
			
			_colorPalette.alpha = 0.0;
			_colorPalette.visible = false;
			
			if (!alpha) return;
	
			// apply bg color
			_data.backgroundColor = color24;
/*
			var background:Shape = new Shape();
			background.graphics.lineStyle(1, 0xFFFFFFF);
			background.graphics.beginFill(color24, alpha);
			background.graphics.drawRect(0, 0, CanvasSetting.CANVAS_WIDTH - 2, CanvasSetting.CANVAS_HEIGHT -2);
			_canvas.background = background;
*/
//			Shape(_canvas.background).graphics.beginFill(color24, alpha);
//			Shape(_canvas.background).graphics.drawRect(0, 0, CanvasSetting.CANVAS_WIDTH - 2, CanvasSetting.CANVAS_HEIGHT -2);

			// for replay
			if (!_data.isReplaying) _data.replayQueue.push(new Commands(new ReplayCommand(null, pickupBgColor, [mouseX, mouseY])));
		}
		
		//------------------------------
		//  event handler
		//------------------------------
		/**
		 * handler of Event.CHANGE
		 * dispatched from _data
		 * @param	event
		 */
		private function _data_changeHandler(event:DataEvent):void
		{
			
			// change tool options
			var color24:uint;
			var alpha:Number;
			var colorTransform:ColorTransform;
			
			switch (event.data)
			{
				case "color":
				{
					color24 = _data.color & 0x00FFFFFF;
					alpha = (_data.color >> 24 & 0xFF) / 0xFF;
					_data.penTool.options.color = color24;
					_data.lineTool.options.color = color24;
					_data.squareTool.options.color = color24;
					_data.circleTool.options.color = color24;
					_data.textTool.options.color = color24;
					
					_data.penTool.options.alpha = alpha;
					_data.lineTool.options.alpha = alpha;
					_data.squareTool.options.alpha = alpha;
					_data.circleTool.options.alpha = alpha;
					_data.textTool.options.alpha = alpha;
					
					colorTransform = new ColorTransform();
					colorTransform.color = color24;
					_mainTimeline.btnColor.color.transform.colorTransform = colorTransform;
					
					break;
				}
				case "thickness":
				{
					_data.penTool.options.thickness = _data.thickness;
					_data.lineTool.options.thickness = _data.thickness;
					_data.squareTool.options.thickness = _data.thickness;
					_data.circleTool.options.thickness = _data.thickness;
					_data.textTool.options.size = _data.thickness;
					
					_mainTimeline.optionWeight.value = _data.thickness;
					break;
				}
				case "isReplaying":
				{
					if (_data.isReplaying && !_data.replayQueue.running)
					{
						deactivate();
						
						var replaySpeed:Number = _mainTimeline.replaySpeed.selectedItem.data;
						_data.canvasCore.initialize(CanvasSetting.CANVAS_WIDTH, CanvasSetting.CANVAS_HEIGHT);
//						_canvas.background = _background;
						_data.replayQueue.replay(replaySpeed);
					}
					else
					{
						activate();
					}
				}
				
				case "filters":
				{
					_data.penTool.options.filters = _data.filters;
					_data.lineTool.options.filters = _data.filters;
					_data.squareTool.options.filters = _data.filters;
					_data.circleTool.options.filters = _data.filters;
					_data.textTool.options.filters = _data.filters;
					break;
				}
				case "backgroundColor":
				{
					color24 = _data.backgroundColor & 0x00FFFFFF;
					alpha = (_data.backgroundColor >> 24 & 0xFF) / 0xFF;
					
					var background:Shape = new Shape();
					background.graphics.lineStyle(1, 0xFFFFFFF);
					background.graphics.beginFill(color24);
					background.graphics.drawRect(0, 0, CanvasSetting.CANVAS_WIDTH - 2, CanvasSetting.CANVAS_HEIGHT -2);
					_canvas.background = background;
					
					// change view's color
					colorTransform = new ColorTransform();
					colorTransform.color = color24;
					_mainTimeline.btnBgColor.color.transform.colorTransform = colorTransform;

					
					break;
				}
			}
		}
		
		/**
		 * handler of MouseEvent.CLICK
		 *  dispatched from btnSelect
		 * @param event
		 */
		private function btnSelect_clickHandler(event:MouseEvent = null):void
		{
			changeIconColor(_mainTimeline.btnSelect);
//			_data.canvasCore.canvasData.activeTool = _data.selectTool;
			_data.canvasCore.applyTool(_data.selectTool);
			// for replay
		}
		
		/**
		 * handler of MouseEvent.CLICK
		 *  dispatched from btnPen
		 * @param event
		 */
		private function btnPen_clickHandler(event:MouseEvent = null):void
		{
			changeIconColor(_mainTimeline.btnPen);
//			_data.canvasCore.canvasData.activeTool = _data.penTool;
			_data.canvasCore.applyTool(_data.penTool);
			// for replay
		}
		
		/**
		 * handler of MouseEvent.CLICK
		 *  dispatched from btnText
		 * @param	event
		 */
		private function btnText_clickHandler(event:MouseEvent = null):void
		{
			changeIconColor(_mainTimeline.btnText);
//			_data.canvasCore.canvasData.activeTool = _data.textTool;
			_data.canvasCore.applyTool(_data.textTool);
			// for replay
		}
		
		/**
		 * handler of MouseEvent.CLICK
		 *  dispatched from btnLine
		 * @param	event
		 */
		private function btnLine_clickHandler(event:MouseEvent = null):void
		{
			changeIconColor(_mainTimeline.btnLine);
//			_data.canvasCore.canvasData.activeTool = _data.lineTool;
			_data.canvasCore.applyTool(_data.lineTool);
			// for replay
		}
		
		/**
		 * handler of MouseEvent.CLICK
		 *  dispatched from btnSquare
		 * @param	event
		 */
		private function btnSquare_clickHandler(event:MouseEvent = null):void
		{
			changeIconColor(_mainTimeline.btnSquare);
//			_data.canvasCore.canvasData.activeTool = _data.squareTool;
			_data.canvasCore.applyTool(_data.squareTool);
			// for replay
		}
		
		/**
		 * handler of MouseEvent.CLICK
		 *  dispatched from btnCircle
		 * @param	event
		 */
		private function btnCircle_clickHandler(event:MouseEvent = null):void
		{
			changeIconColor(_mainTimeline.btnCircle);
//			_data.canvasCore.canvasData.activeTool = _data.circleTool;
			_data.canvasCore.applyTool(_data.circleTool);
			// for replay
		}
		
		/**
		 * handler of MouseEvent.CLICK
		 *  dispatched from btnColor
		 * @param	event
		 */
		private function btnColor_clickHandler(event:MouseEvent = null):void
		{
			_colorPalette.x = _mainTimeline.mouseX;
			_colorPalette.y = _mainTimeline.mouseY;
			_colorPalette.alpha = 0.0;
			_colorPalette.visible = true;
			Tweener.removeTweens(_colorPalette);
			Tweener.addTween(_colorPalette, 
				{
					alpha: 1.0,
					transition: "easeOutExpo",
					time: 0.5,
					onComplete: function() {
						_colorPalette.addEventListener(MouseEvent.CLICK, _colorPalette_clickHandler);
					}
				}
			);
		}
		
		/**
		 * handler of MouseEvent.CLICK
		 *  dispatched from _colorPalette
		 * @param	event
		 */
		private function _colorPalette_clickHandler(event:MouseEvent = null):void
		{
			_colorPalette.removeEventListener(MouseEvent.CLICK, _colorPalette_clickHandler);
			pickupColor(_colorPalette.mouseX, _colorPalette.mouseY);
		}
		
		/**
		 * handler of MouseEvent.CLICK
		 *  dispatched from optionWeight
		 * @param	event
		 */
		private function optionWeight_changeHandler(event:Event = null):void
		{
			_data.thickness = _mainTimeline.optionWeight.value;
			
			if (!_data.isReplaying) 
			{
				_data.replayQueue.push(
					new Commands(
						new ReplayCommand(
							null,
							function(thickness:uint) {_data.thickness = thickness},
							[_data.thickness]
						)
					)
				);
			}
		}
		
		/**
		 * handler of MouseEvent.CLICK
		 *  dispatched from optionEffect
		 * @param	event
		 */
		private function optionEffect_changeHandler(event:Event = null):void
		{
			_data.filters = _mainTimeline.optionEffect.selectedItem.data.filters;
			
			if (!_data.isReplaying) 
			{
				_data.replayQueue.push(
					new Commands(
						new ReplayCommand(
							null,
							function(filters:Array) {_data.filters = filters},
							[_data.filters.concat()]
						)
					)
				);
			}
		}
		
		/**
		 * handler of Event.CHANGE
		 *  dispatched from optionAlpha
		 * @param	event
		 */
		private function optionAlpha_changeHandler(event:Event = null):void
		{
			_data.color = event.target.color;
			if (!_data.isReplaying) 
			{
				_data.replayQueue.push(
					new Commands(
						new ReplayCommand(
							null,
							function(color:uint) {_data.color = color},
							[_data.color]
						)
					)
				);
			}
		}
		
		/**
		 * handler of Event.CHANGE
		 *  dispatched from optionThickness
		 * @param	event
		 */
		private function optionThickness_changeHandler(event:Event = null):void
		{
			_data.thickness = event.target.thickness;
			if (!_data.isReplaying) 
			{
				_data.replayQueue.push(
					new Commands(
						new ReplayCommand(
							null,
							function(thickness:Number) {_data.thickness = thickness},
							[_data.thickness]
						)
					)
				);
			}
		}
		
		
		/**
		 * handler of MouseEvent.CLICK
		 *  dispatched from btnUndo
		 * @param event
		 */
		private function btnUndo_clickHandler(event:MouseEvent = null):void
		{
			if (!_data.canvasCore.stack.hasPrevious) return;
			var command:IRedoableCommand = _data.canvasCore.stack.previous;
			if (command) MouseDownCommand(command).undo();
			
			if (!_data.isReplaying) 
			{
				_data.replayQueue.push(
					new Commands(
						new ReplayCommand(
							null,
							btnUndo_clickHandler,
							null
						)
					)
				);
			}
			
		}
		
		/**
		 * handler of MouseEvent.CLICK
		 *  dispatched from btnRedo
		 * @param event
		 */
		private function btnRedo_clickHandler(event:MouseEvent = null):void
		{
			if (!_data.canvasCore.stack.hasNext) return;
			var command:IRedoableCommand = _data.canvasCore.stack.next;
			if (command) MouseDownCommand(command).redo();
			
			if (!_data.isReplaying) 
			{
				_data.replayQueue.push(
					new Commands(
						new ReplayCommand(
							null,
							btnRedo_clickHandler,
							null
						)
					)
				);
			}
		}
		
		/**
		 * handler of MouseEvent.CLICK
		 *  dispatched from btnClear
		 * @param event
		 */
		private function btnClear_clickHandler(event:MouseEvent = null):void
		{	
			deactivate();
			_data.canvasCore.initialize(CanvasSetting.CANVAS_WIDTH, CanvasSetting.CANVAS_HEIGHT);
			initialize();
			activate();
//			_canvas.background = _background;
			
			if (!_data.isReplaying) 
			{
				_data.replayQueue.push(
					new Commands(
						new ReplayCommand(
							null,
							btnClear_clickHandler,
							null
						)
					)
				);
			}
			
		}
		
		/**
		 * handler of MouseEvent.CLICK
		 *  dispatched from btnReplay
		 * @param event
		 */
		private function btnReplay_clickHandler(event:MouseEvent = null):void
		{
			if (_data.isReplaying) return;
			_data.isReplaying = true;
		}
		
		/**
		 * handler of MouseEvent.CLICK
		 *  dispatched from btnBgColor
		 * @param event
		 */
		private function btnBgColor_clickHandler(event:MouseEvent = null):void
		{
			_colorPalette.x = _mainTimeline.mouseX - _colorPalette.width - 10;
			_colorPalette.y = _mainTimeline.mouseY - 10;
			_colorPalette.alpha = 0.0;
			_colorPalette.visible = true;
			Tweener.removeTweens(_colorPalette);
			Tweener.addTween(_colorPalette, 
				{
					alpha: 1.0,
					transition: "easeOutExpo",
					time: 0.5,
					onComplete: function() {
						_colorPalette.addEventListener(MouseEvent.CLICK, _bgcolorPalette_clickHandler);
					}
				}
			);
		}
		
		/**
		 * handler of MouseEvent.CLICK
		 *  dispatched from _colorPalette
		 * @param	event
		 */
		private function _bgcolorPalette_clickHandler(event:MouseEvent = null):void
		{
			_colorPalette.removeEventListener(MouseEvent.CLICK, _bgcolorPalette_clickHandler);
			pickupBgColor(_colorPalette.mouseX, _colorPalette.mouseY);
		}
		
		/**
		 * handler of DrawingEvent.START_DRAWING
		 *  dispatched from _canvasCore
		 * @param event
		 */
		private function canvasCore_startDrawingHandler(event:DrawingEvent):void
		{
			if (!_data.isReplaying) 
			{
				_data.replayQueue.push(
					new Commands(
						new ReplayCommand(
							null,
							_data.canvasCore.mouseDown,
							[event.tool, event.x, event.y]
						)
					)
				);
			}
		}
		
		/**
		 * handler of DrawingEvent.START_DRAWING
		 *  dispatched from _canvasCore
		 * @param event
		 */
		private function canvasCore_moveDrawingHandler(event:DrawingEvent):void
		{
			if (!_data.isReplaying) 
			{
				_data.replayQueue.push(
					new Commands(
						new ReplayCommand(
							null,
							_data.canvasCore.mouseMove,
							[event.tool, event.x, event.y]
						)
					)
				);
			}
		}
		
		/**
		 * handler of DrawingEvent.START_DRAWING
		 *  dispatched from _canvasCore
		 * @param event
		 */
		private function canvasCore_stopDrawingHandler(event:DrawingEvent):void
		{
			if (!_data.isReplaying) 
			{
				_data.replayQueue.push(
					new Commands(
						new ReplayCommand(
							null,
							_data.canvasCore.mouseUp,
							[event.tool, event.x, event.y]
						)
					)
				);
			}
		}
		
		/**
		 * handler of DrawingTextEvent.STOP_DRAWING
		 *  dispatched from _canvasCore
		 * @param event
		 */
		private function canvasCore_stopDrawingTextHandler(event:DrawingTextEvent):void
		{
			if (!_data.isReplaying) 
			{
				_data.replayQueue.push(
					new Commands(
						new ReplayCommand(
							null,
							_data.canvasCore.keyUp,
							[event.tool, event.charCode, event.text]
						)
					)
				);
			}
		}
		
		/**
		 * handler of DrawingFocusChange.MOUSE_FOCUS_CHANGE
		 *  dispatched from _canvasCore
		 * @param event
		 */
		private function canvasCore_mouseFocusChangeHandler(event:DrawingFocusChange):void
		{
			if (!_data.isReplaying) 
			{
				_data.replayQueue.push(
					new Commands(
						new ReplayCommand(
							null,
							_data.canvasCore.mouseFocusChange,
							[event.tool]
						)
					)
				);
			}
		}
	}
}