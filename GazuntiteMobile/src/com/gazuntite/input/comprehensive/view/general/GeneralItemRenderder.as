package com.gazuntite.input.comprehensive.view.general
{
	import flash.events.MouseEvent;
	
	import spark.components.LabelItemRenderer;
	
	public class GeneralItemRenderder extends LabelItemRenderer
	{
		public function GeneralItemRenderder()
		{
			super();
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			var call:GeneralItemCallout = new GeneralItemCallout();
			call.width = this.width-8;
			call.open(this);
		}
	}
}