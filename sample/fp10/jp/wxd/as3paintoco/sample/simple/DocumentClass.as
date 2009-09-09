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
package jp.wxd.as3paintoco.sample.simple 
{
	import fl.controls.ComboBox;
	import fl.controls.NumericStepper;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * <p>as3 Drawingライブラリのサンプルです。</p>
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class DocumentClass extends MovieClip
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		//------------------------------
		//  public properties
		//------------------------------
		/**
		 * alpha option for tool color
		 */
		public var optionAlpha:MovieClip;
		
		/**
		 * thickness option for tool pen
		 */
		public var optionThickness:MovieClip;
		
		/**
		 * weight option for tool
		 */
		public var optionWeight:NumericStepper;
		
		/**
		 * effect option for tool
		 */
		public var optionEffect:ComboBox;
		
		/**
		 * select button
		 */
		public var btnSelect:MovieClip;
		
		/**
		 * pen button
		 */
		public var btnPen:MovieClip;
		
		/**
		 * text button
		 */
		public var btnText:MovieClip;
		
		/**
		 * line button
		 */
		public var btnLine:MovieClip;
		
		/**
		 * square button
		 */
		public var btnSquare:MovieClip;
		
		/**
		 * circle button
		 */
		public var btnCircle:MovieClip;
		
		/**
		 * undo button
		 */
		public var btnUndo:MovieClip;
		
		/**
		 * redo button
		 */
		public var btnRedo:MovieClip;
		
		/**
		 * clear button
		 */
		public var btnClear:MovieClip;
		
		/**
		 * save button
		 */
		public var btnSave:MovieClip;
		
		/**
		 * color button
		 */
		public var btnColor:MovieClip;
		
		/**
		 * load image button
		 */
		public var btnLoadimage:MovieClip;
		
		/**
		 * change background color
		 */
		public var btnBgColor:MovieClip;
		
		/**
		 * replay button
		 */
		public var btnReplay:MovieClip;
		
		/**
		 * replay speed option
		 */
		public var replaySpeed:ComboBox;
		
		/**
		 * canvas container
		 */
		public var canvasContainer:MovieClip;
		
		//----------------------------------------------------------------------
		//  methods
		//----------------------------------------------------------------------
		/**
		 * public methods
		 */
		/**
		 * constructor
		 */
		public function DocumentClass() 
		{
			btnLoadimage.visible = false;
			new Controller(this);
		}
	}
}