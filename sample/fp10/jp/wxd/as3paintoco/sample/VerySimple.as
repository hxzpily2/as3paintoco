package jp.wxd.as3paintoco.sample 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import jp.wxd.as3paintoco.AS3Paintoco;
	import jp.wxd.as3paintoco.core.CanvasCore;
	import jp.wxd.as3paintoco.tools.PenTool;
	
	/**
	 * 超シンプルお絵かきツールサンプル
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class VerySimple extends Sprite
	{
		//----------------------------------------------------------------------
		//  methods
		//----------------------------------------------------------------------
		//------------------------------
		//  public methods
		//------------------------------
		/**
		 * constructor
		 */
		public function VerySimple() 
		{
			// 背景を作成します。
			var canvasBackground:Shape = new Shape();
			canvasBackground.graphics.lineStyle(1, 0x000000, 1.0);
			canvasBackground.graphics.beginFill(0xFEFEFE, 1.0);
			canvasBackground.graphics.drawRect(0, 0, 300, 300);
			
			// Paintocoをインスタンス化します。
			var paintoco:AS3Paintoco = new AS3Paintoco(this, 302, 302);
			
			// Canvasインスタンスに先ほど作成した背景を指定します。
			paintoco.background = canvasBackground;
			
			// ペンツールを適用します。
			paintoco.applyTool(new PenTool());

			// キャンバスを使用可能にします。
			paintoco.activate();
		}	
	}	
}