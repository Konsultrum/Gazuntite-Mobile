package assets.skin
{
	import spark.skins.mobile.ButtonSkin;
	
	public class ToggleButtonSkin extends ButtonSkin
	{
		public function ToggleButtonSkin()
		{
			super();
		}
		override protected function getBorderClassForCurrentState():Class
		{
			var result:Class;
			
			switch (currentState)
			{
				case "up":
					result = ButtonUp;
					break;
				case "down":
					result = ButtonDown;
					break;
				case "upAndSelected":
					result = ButtonDown;
					break;
				case "downAndSelected":
					result = ButtonUp;
					break;
			}
			return result;
		}
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
			
		}
	}
}