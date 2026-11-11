package com.gazuntite.topbar.viewmodel
{
	[Bindable]
	public class TopBarViewModel
	{
		protected static var instance:TopBarViewModel;
		public var logoSelected:Boolean = false;
		public function TopBarViewModel(singleton:Number)
		{
		}
		public static function getInstance():TopBarViewModel
		{
			if (instance==null)
			{
				instance = new TopBarViewModel(0);
			}
			return instance;
		}
	}
}