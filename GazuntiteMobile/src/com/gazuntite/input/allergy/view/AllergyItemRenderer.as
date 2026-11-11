package com.gazuntite.input.allergy.view
{
	import flash.events.MouseEvent;
	
	import spark.components.LabelItemRenderer;
	
	public class AllergyItemRenderer extends LabelItemRenderer
	{
		public function AllergyItemRenderer()
		{
			super();
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			var call:AllergyItemCallout = new AllergyItemCallout();
			call.width = this.width-8;
			call.open(this);
		}
	}
}