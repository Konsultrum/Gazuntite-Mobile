package com.gazuntite.common.viewmodel.navigation
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class NavigationInfo
	{
		public var navItemList:ArrayCollection;
		private var _currentTopNavItem:NavigationInfoItem = null;
		
		public function get currentTopNavItem():NavigationInfoItem
		{
			return _currentTopNavItem;
		}
		
		public function set currentTopNavItem(value:NavigationInfoItem):void
		{
			_currentTopNavItem = value;
		}
		
		private var _currentSubNavItem:NavigationInfoItem = null;
		
		public function get currentSubNavItem():NavigationInfoItem
		{
			return _currentSubNavItem;
		}
		
		public function set currentSubNavItem(value:NavigationInfoItem):void
		{
			_currentSubNavItem = value;
			currentTopNavItem = value.parentItem;
		}
		
		public var jumpToSubItem:NavigationInfoItem;
		
		public function NavigationInfo()
		{
		}
	}
}