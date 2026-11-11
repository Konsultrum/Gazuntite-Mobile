package com.gazuntite.common.view.component.searchInputSupportClasses
{
	import flash.events.Event;
	
	public class SearchInputEvent extends Event
	{
		public static const SEARCH_INPUT_EVENT_PENDING:String = "SEARCH_INPUT_EVENT_PENDING"; // search pending
		public static const SEARCH_INPUT_EVENT_COMPLETE:String = "SEARCH_INPUT_EVENT_COMPLETE"; // search complete
		public static const SEARCH_INPUT_EVENT_ERROR:String = "SEARCH_INPUT_EVENT_ERROR"; // search error
		public static const SEARCH_INPUT_EVENT_USER_OK:String = "SEARCH_INPUT_EVENT_USER_OK"; 
		public static const SEARCH_INPUT_EVENT_USER_CANCEL:String = "SEARCH_INPUT_EVENT_USER_CANCEL"; 
		public function SearchInputEvent(type:String)
		{
			super(type);
		}
	}
}