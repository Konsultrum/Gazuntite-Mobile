package com.gazuntite.main.exambar.skin
{
	import assets.skin.InputButtonDown;
	import assets.skin.InputButtonUp;
	
	import spark.skins.mobile.ButtonSkin;
	
	
	public class InputButtonSkin extends ButtonSkin
	{

		public function InputButtonSkin()
		{
			super();
		}
		override protected function getBorderClassForCurrentState():Class
		{
			var result:Class;
			
			switch (currentState)
			{
				case "up":
					result = InputButtonUp;
					break;
				case "down":
					result = InputButtonDown;
					break;
				case "upAndSelected":
					result = InputButtonUp;
					break;
				case "downAndSelected":
					result = InputButtonDown;
					break;
			}
			return result;
		}
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
			
		}

	}
}