package com.gazuntite.common.view.component.searchInputSupportClasses
{
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class SearchInputViewModel extends EventDispatcher
	{
		public var searchText:String = "";
		public var selectedItem:Object;
		public var availableItems:ArrayCollection = new ArrayCollection();
		public var labelField:String = null; //if null, client should use toString()
		public function SearchInputViewModel()
		{
			super();
		}
	}
}