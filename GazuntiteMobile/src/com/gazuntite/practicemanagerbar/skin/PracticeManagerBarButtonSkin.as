package com.gazuntite.practicemanagerbar.skin
{
	import assets.skin.PracticeManagerBarButtonDown;
	import assets.skin.PracticeManagerBarButtonUp;
	
	import spark.skins.mobile.ButtonSkin;
	
	
	public class PracticeManagerBarButtonSkin extends ButtonSkin
	{

		public function PracticeManagerBarButtonSkin()
		{
			super();
		}
		override protected function getBorderClassForCurrentState():Class
		{
			var result:Class;
			
			switch (currentState)
			{
				case "up":
					result = PracticeManagerBarButtonUp;
					break;
				case "down":
					result = PracticeManagerBarButtonDown;
					break;
				case "upAndSelected":
					result = PracticeManagerBarButtonDown;
					break;
				case "downAndSelected":
					result = PracticeManagerBarButtonUp;
					break;
			}
			return result;
		}
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
			
		}

	}
}