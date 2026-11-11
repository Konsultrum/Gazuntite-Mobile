package com.gazuntite.common.view.skin
{
	import spark.skins.mobile.ToggleSwitchSkin;
	
	public class ToggleSwitchPresentPastSkin extends ToggleSwitchSkin
	{
		public function ToggleSwitchPresentPastSkin()
		{
			super();
			selectedLabel = "Present";
			unselectedLabel = "Past";
		}
	}
}