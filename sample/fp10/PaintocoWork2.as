package 
{
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import jp.wxd.as3paintoco.AS3Paintoco;
	import jp.wxd.as3paintoco.tools.CircleTool;
	import jp.wxd.as3paintoco.tools.ITool;
	import jp.wxd.as3paintoco.tools.LineTool;
	import jp.wxd.as3paintoco.tools.PenTool;
	import jp.wxd.as3paintoco.tools.SelectTool;
	import jp.wxd.as3paintoco.tools.SquareTool;
	import jp.wxd.as3paintoco.tools.TextTool;
	
	/**
	 * as3Paintoco sampleコード2
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class PaintocoWork2 extends Sprite
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		//------------------------------
		//  private properties
		//------------------------------
		/**
		 * AS3Paintoco instance
		 */
		private var _paintoco:AS3Paintoco;
		
		/**
		 * tools
		 */
		private var _tools:Object;
		
		//----------------------------------------------------------------------
		//  methods
		//----------------------------------------------------------------------
		//------------------------------
		//  public methods
		//------------------------------
		/**
		 * constructor
		 */
		public function PaintocoWork2() 
		{
			_tools = {
				penTool: new PenTool(),
				lineTool: new LineTool(),
				squareTool: new SquareTool(),
				circleTool: new CircleTool(),
				textTool: new TextTool(),
				selectTool: new SelectTool()
			};

			_tools.textTool.options = {
				size:24
			};
			
			// create AS3Paintoco
			_paintoco = new AS3Paintoco(this, 465, 465);
			_paintoco.replayable = true;
			initialize();
			createMenu();
		}
		
		/**
		 * initialize 
		 */
		private function initialize():void
		{
			_paintoco.initialize();
			// apply ITool
			_paintoco.applyTool(_tools.penTool);
			
			// activate CanvasCore
			_paintoco.activate();
		}
		
		/**
		 * create context menu
		 */
		private function createMenu():void
		{
			var contextMenu:ContextMenu = new ContextMenu();
			contextMenu.hideBuiltInItems();
			
			var penMenu:ContextMenuItem = new ContextMenuItem("penTool", true);
			var lineMenu:ContextMenuItem = new ContextMenuItem("lineTool");
			var squareMenu:ContextMenuItem = new ContextMenuItem("squareTool");
			var circleMenu:ContextMenuItem = new ContextMenuItem("circleTool");
			var textMenu:ContextMenuItem = new ContextMenuItem("textTool");
			var selectMenu:ContextMenuItem = new ContextMenuItem("selectTool");
			
			penMenu.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,
				contexToolMenu_menuSelect);
			lineMenu.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,
				contexToolMenu_menuSelect);
			squareMenu.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,
				contexToolMenu_menuSelect);
			circleMenu.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,
				contexToolMenu_menuSelect);
			textMenu.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,
				contexToolMenu_menuSelect);
			selectMenu.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,
				contexToolMenu_menuSelect);
			
			var clearMenu:ContextMenuItem = new ContextMenuItem("clearAction");
			var undoMenu:ContextMenuItem = new ContextMenuItem("undoAction");
			var redoMenu:ContextMenuItem = new ContextMenuItem("redoAction");
			var replayMenu:ContextMenuItem = new ContextMenuItem("replayAction", true);
			
			clearMenu.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,
				contexActionMenu_menuSelect);
			undoMenu.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,
				contexActionMenu_menuSelect);
			redoMenu.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,
				contexActionMenu_menuSelect);
			replayMenu.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,
				contexActionMenu_menuSelect);
				
			contextMenu.customItems.push(clearMenu);
			contextMenu.customItems.push(undoMenu);
			contextMenu.customItems.push(redoMenu);
			contextMenu.customItems.push(replayMenu);
			contextMenu.customItems.push(penMenu);
			contextMenu.customItems.push(lineMenu);
			contextMenu.customItems.push(squareMenu);
			contextMenu.customItems.push(circleMenu);
			contextMenu.customItems.push(textMenu);
			contextMenu.customItems.push(selectMenu);
			
			
			this.contextMenu = contextMenu;
		}
		
		//----------------------------------------------------------------------
		//  event listener
		//----------------------------------------------------------------------
		/**
		 * ContextMenuEvent.MENU_SELECT
		 * @param	event
		 */
		private function contexToolMenu_menuSelect(event:ContextMenuEvent):void
		{
			var toolKey:String = ContextMenuItem(event.target).caption;
			_paintoco.applyTool(_tools[toolKey]);
		}
		
		/**
		 * ContextMenuEvent.MENU_SELECT
		 * @param	event
		 */
		private function contexActionMenu_menuSelect(event:ContextMenuEvent):void
		{
			var toolKey:String = ContextMenuItem(event.target).caption;
			switch (toolKey)
			{
				case "clearAction":
					initialize();
					break;
				case "undoAction":
					_paintoco.undo();
					break;
				case "redoAction":
					_paintoco.redo();
					break;
				case "replayAction":
					_paintoco.replay(5.0);
					break;
			}
		}
	}
}