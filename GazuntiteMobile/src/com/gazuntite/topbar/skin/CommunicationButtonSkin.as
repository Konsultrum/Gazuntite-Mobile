package com.gazuntite.topbar.skin
{
	import assets.skin.CommunicationDown;
	import assets.skin.CommunicationUp;
	
	import spark.skins.mobile.ButtonSkin;
	
	public class CommunicationButtonSkin extends ButtonSkin
	{
		public function CommunicationButtonSkin()
		{
			super();
		}
		override protected function getBorderClassForCurrentState():Class
		{
			var result:Class;
			
			switch (currentState)
			{
				case "up":
					result = CommunicationUp;
					break;
				case "down":
					result = CommunicationDown;
					break;
				case "upAndSelected":
					result = CommunicationDown;
					break;
				case "downAndSelected":
					result = CommunicationUp;
					break;
			}
			return result;
		}
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
			
		}
	}
}