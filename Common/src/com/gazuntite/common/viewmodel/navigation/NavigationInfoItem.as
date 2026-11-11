package com.gazuntite.common.viewmodel.navigation
{
	import mx.collections.ArrayCollection;

	[Bindable] 
	public class NavigationInfoItem
	{
		public var viewId:int = ViewIds.PLACE_HOLDER;
		public var title:String = '';
		public var parentItem:NavigationInfoItem = null
		public var prevItem:NavigationInfoItem = null;
		public var nextItem:NavigationInfoItem = null;
		public var subNavInfoItemList:ArrayCollection = new ArrayCollection(); // list of NavigationIfoItem
		
		public function NavigationInfoItem(parentItemValue:NavigationInfoItem, titleValue:String, viewIdValue:int = ViewIds.PLACE_HOLDER)
		{
			parentItem = parentItemValue;
			title = titleValue;
			viewId = viewIdValue;
		}
		public function addSubItem(item:NavigationInfoItem):void
		{
			subNavInfoItemList.addItem(item);
		}
	}
}