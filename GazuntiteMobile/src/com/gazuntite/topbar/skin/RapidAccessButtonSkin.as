package com.gazuntite.topbar.skin
{
	import assets.skin.RapidAccessDown;
	import assets.skin.RapidAccessUp;
	
	import spark.skins.mobile.ButtonSkin;
	
	
	public class RapidAccessButtonSkin extends ButtonSkin
	{

		public function RapidAccessButtonSkin()
		{
			super();
		}
		override protected function getBorderClassForCurrentState():Class
		{
			var result:Class;
			
			switch (currentState)
			{
				case "up":
					result = RapidAccessUp;
					break;
				case "down":
					result = RapidAccessDown;
					break;
				case "upAndSelected":
					result = RapidAccessDown;
					break;
				case "downAndSelected":
					result = RapidAccessUp;
					break;
			}
			return result;
		}
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
			
		}

	}
}