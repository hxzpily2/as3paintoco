package jp.wxd.as3paintoco.tools 
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import jp.wxd.as3paintoco.display.Stroke;
	/**
	 * Tool Interface
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public interface ITool 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		//------------------------------
		//  getter/setter
		//------------------------------
		/**
		 * ツールを使用している際にマウスカーソルに追尾するカーソルを設定します。
		 */
		function get cursor():DisplayObject;
		/** @private */
		function set cursor(value:DisplayObject):void;

		/**
		 * ツールが対象とするStrokeを表します。
		 */
		function get stroke():Stroke
		/** @private */
		function set stroke(value:Stroke):void;
		
		/**
		 * ツールが描写ツールであるかどうかを表します。
		 */
		function get isDrawable():Boolean;
		
		/**
		 * ツールのオプションを設定します。
		 */
		function get options():Object;
		/** @private */
		function set options(value:Object):void;
		
		//----------------------------------------------------------------------
		//  method
		//----------------------------------------------------------------------		
		/**
		 * ツールが使用可能となった場合に呼び出されます。
		 * ツールを使用する度に初期化を行う場合、このメソッドを利用します。
		 */
		function activate():void;
		
		/**
		 * ツールがロードされた際に一度だけ呼び出されます。(IToolを実装したクラスのコンストラクタ内から呼び出します)
		 * 一度だけ初期化を行う際にはこのメソッドを利用します。
		 */
		function configure():void;
		
		/**
		 * ツールが使用不可となった場合に呼び出されます。
		 * ツール使用後の後処理などを行う場合、このメソッドを利用します。
		 */
		function deactivate():void;
		
		/**
		 * KeyをDownした際に呼び出されます。
		 * @param	charCode	KeyをDownした際の対象キーの文字コードを表します。
		 * @param	text	KeyDownにより変更となったtextがあれば指定します。
		 */
		function keyDown(charCode:uint, text:String = null):void;
		
		/**
		 * KeyをUpした際に呼び出されます。
		 * @param	charCode	KeyをUpした際の対象キーの文字コードを表します。
		 * @param	text	KeyUpにより変更となったtextがあれば指定します。
		 */
		function keyUp(charCode:uint, text:String = null):void;
		
		/**
		 * MouseをDoubleClickした際に呼び出されます。
		 * @param	x	マウスをダブルクリックした際のキャンパス上のx座標を表します。
		 * @param	y	マウスをダブルクリックした際のキャンパス上のy座標を表します。
		 */
		function mouseDoubleClick(x:Number, y:Number):void;

		/**
		 * MouseをDownした際に呼び出されます。
		 * @param	x	マウスをダウンした際のキャンパス上のx座標を表します。
		 * @param	y	マウスをダウンした際のキャンパス上のy座標を表します。
		 */
		function mouseDown(x:Number, y:Number):void;
		
		/**
		 * MouseをMoveした際に呼び出されます。
		 * @param	x	マウスをダブルクリックした際のキャンパス上のx座標を表します。
		 * @param	y	マウスをダブルクリックした際のキャンパス上のy座標を表します。
		 */
		function mouseMove(x:Number, y:Number):void;

		/**
		 * MouseをUpした際に呼び出されます。
		 * @param	x	マウスをダブルクリックした際のキャンパス上のx座標を表します。
		 * @param	y	マウスをダブルクリックした際のキャンパス上のy座標を表します。
		 */
		function mouseUp(x:Number, y:Number):void;
		
		/**
		 * MouseによるFocus切り替えをした際に呼び出されます。
		 */
		function mouseFocusChange():void;
	}
}