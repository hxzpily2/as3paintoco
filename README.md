# as3paintoco(ぺいんとこ)
お絵描きライブラリ。

# 機能
主に、以下のような機能を持っています。

* undo, redo機能
* replay機能
* お絵描きした画像の保存機能

# 使い方
as3paintoco(ぺいんとこ)はFlash Player10.0.32以降に対応しております。ただし、開発中ステータスのため予期しない動作をするかも知れません。その点ご了承下さい。

## ライブラリの準備

* このライブラリは、as3corelibを使用しているので、as3corelib.swcをライブラリパスに通します。
* as3paintoco_alpha4.swcをダウンロードして、ライブラリパスに通します。

# sample code

```as3
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
        private var _paint:AS3Paintoco;
 
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
 
            // AS3Paintocoのインスタンスを生成します。
            _paint = new AS3Paintoco(this, 465, 465);
            _paint.replayable = true;
            initialize();
            createMenu();
        }
 
        /**
         * initialize 
         */
        private function initialize():void
        {
           _paint.initialize();
           // 初期ツールを設定します。
            _paint.applyTool(_tools.penTool);
 
            // キャンバスをアクティブにしお絵描き可能にします。
            _paint.activate();
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
            var saveMenu:ContextMenuItem = new ContextMenuItem("saveAction", true);
 
            clearMenu.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,
                contexActionMenu_menuSelect);
            undoMenu.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,
                contexActionMenu_menuSelect);
            redoMenu.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,
                contexActionMenu_menuSelect);
            replayMenu.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,
                contexActionMenu_menuSelect);
            saveMenu.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,
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
            contextMenu.customItems.push(saveMenu);
 
            this.contextMenu = contextMenu;
        }
 
        //----------------------------------------------------------------------
        //  event listener
        //----------------------------------------------------------------------
        /**
         * ContextMenuEvent.MENU_SELECT
         * @param    event
         */
        private function contexToolMenu_menuSelect(event:ContextMenuEvent):void
        {
            var toolKey:String = ContextMenuItem(event.target).caption;
            // 選択されたツールを適用します。
            _paint.applyTool(_tools[toolKey]);
        }
 
        /**
         * ContextMenuEvent.MENU_SELECT
         * @param    event
         */
        private function contexActionMenu_menuSelect(event:ContextMenuEvent):void
        {
            var toolKey:String = ContextMenuItem(event.target).caption;
            switch (toolKey)
            {
                case "clearAction":
                    // 初期化します。
                    initialize();
                    break;
                case "undoAction":
                    // ワンストロークを取り消します。
                    _paint.undo();
                    break;
                case "redoAction":
                    // ワンストロークをやり直します。
                    _paint.redo();
                    break;
                case "replayAction":
                    // 最初からお絵描きを再生します。
                    _paint.replay(5.0);
                    break;
                case "saveAction":
                    // お絵描きしたキャンバスをローカルファイルに保存します。
                    _paint.save("paint.png");
                    break;
            }
        }
    }
}
```

