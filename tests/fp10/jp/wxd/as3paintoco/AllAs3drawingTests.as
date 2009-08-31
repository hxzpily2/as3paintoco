package jp.wxd.as3paintoco
{
	import jp.wxd.as3paintoco.command.*;
	import jp.wxd.as3paintoco.core.*;
	import jp.wxd.as3paintoco.data.*;
	import jp.wxd.as3paintoco.display.*
	import jp.wxd.as3paintoco.events.*
	import jp.wxd.as3paintoco.tools.*;
	import org.libspark.as3unit.runners.Suite;
	
	/**
	 * 
	 * @author Copyright (C) naoto koshikawa, All Rights Reserved.
	 */
	public class AllAs3drawingTests 
	{
		//----------------------------------------------------------------------
		//  properties
		//----------------------------------------------------------------------
		public static const RunWith:Class = Suite;
		public static const SuiteClasses:Array = [
			CanvasCoreTest,
			// command
			MouseDownCommandTest,
			ReplayCommandTest,
			ReplayQueueTest,
			// data
			CanvasDataTest,
			// display
			CanvasTest,
			LayerTest,
			LayersTest,
			StrokeTest,
			// events
			DrawingEventTest,
			DrawingFocusChangeTest,
			DrawingTextEventTest,
			// tools
			BaseToolTest,
			CircleToolTest,
			LineToolTest,
			PenToolTest,
			SelectToolTest,
			SquareToolTest,
			TextToolTest
		];
	}
}