package ghostcat.display.transfer
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filters.BitmapFilter;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import ghostcat.events.TickEvent;
	
	/**
	 * 在前端显示的动态模糊
	 * @author flashyiyi
	 * 
	 */
	public class MotionBlur extends GBitmapTransfer
	{
		public var fadeSpeed:Number;
		public var contentWidth:int;
		public var contentHeight:int;
		public var applyFilters:Array;
		
		private var cacheBitmapData:BitmapData;
		
		public function MotionBlur(target:DisplayObject,contentWidth:int,contentHeight:int,fadeSpeed:Number = 0.5,applyFilters:Array = null)
		{
			this.contentWidth = contentWidth;
			this.contentHeight = contentHeight;
			this.fadeSpeed = fadeSpeed;
			this.applyFilters = applyFilters;
			
			super(target);
			
			this.enabledTick = true;
		}
		
		public override function createBitmapData():void
		{
			if (bitmapData)
				bitmapData.dispose();
			
			bitmapData = new BitmapData(contentWidth,contentHeight,true,0);
			
			if (cacheBitmapData)
				cacheBitmapData.dispose();
			
			cacheBitmapData = new BitmapData(contentWidth,contentHeight,true,0);
		}
		
		public override function renderTarget():void
		{
			if (!bitmapData)
				return;
			
			cacheBitmapData.fillRect(cacheBitmapData.rect,0);
			cacheBitmapData.draw(_target);	
			
			bitmapData.colorTransform(bitmapData.rect,new ColorTransform(1,1,1,fadeSpeed));
			if (applyFilters)
			{
				for each (var filter:BitmapFilter in applyFilters)
					bitmapData.applyFilter(bitmapData,bitmapData.rect,new Point(),filter);
			}
			cacheBitmapData.copyPixels(bitmapData,bitmapData.rect,new Point(),null,null,true);
			
			bitmapData.fillRect(bitmapData.rect,0);
			bitmapData.copyPixels(cacheBitmapData,cacheBitmapData.rect,new Point());
		}
		
		public override function destory():void
		{
			if (cacheBitmapData)
				cacheBitmapData.dispose();
			
			super.destory();
		}
		
		protected override function tickHandler(event:TickEvent):void
		{
			renderTarget();
		}
	}
}