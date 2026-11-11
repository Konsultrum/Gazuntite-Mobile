package com.gazuntite.topbar.skin
{
	import assets.skin.WebDown;
	import assets.skin.WebUp;
	
	import spark.skins.mobile.ButtonSkin;
	
	public class WebButtonSkin extends ButtonSkin
	{
		public function WebButtonSkin()
		{
			super();
		}
		override protected function getBorderClassForCurrentState():Class
		{
			var result:Class;
			
			switch (currentState)
			{
				case "up":
					result = WebUp;
					break;
				case "down":
					result = WebDown;
					break;
				case "upAndSelected":
					result = WebDown;
					break;
				case "downAndSelected":
					result = WebUp;
					break;
			}
			return result;
		}
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
			
		}
	}
}