package com.gazuntite.main.exambar.skin
{
	import assets.skin.HistoryButtonDown;
	import assets.skin.HistoryButtonUp;
	
	import spark.skins.mobile.ButtonSkin;
	
	
	public class HistoryButtonSkin extends ButtonSkin
	{

		public function HistoryButtonSkin()
		{
			super();
		}
		override protected function getBorderClassForCurrentState():Class
		{
			var result:Class;
			
			switch (currentState)
			{
				case "up":
					result = HistoryButtonUp;
					break;
				case "down":
					result = HistoryButtonDown;
					break;
				case "upAndSelected":
					result = HistoryButtonDown;
					break;
				case "downAndSelected":
					result = HistoryButtonUp;
					break;
			}
			return result;
		}
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
			
		}

	}
}