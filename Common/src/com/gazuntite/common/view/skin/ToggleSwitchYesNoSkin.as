package com.gazuntite.common.view.skin
{
	import spark.skins.mobile.ToggleSwitchSkin;
	
	public class ToggleSwitchYesNoSkin extends ToggleSwitchSkin
	{
		public function ToggleSwitchYesNoSkin()
		{
			super();
			selectedLabel = "Yes";
			unselectedLabel = "No";
		}
	}
}