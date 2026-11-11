package com.gazuntite.common.view.component.searchInputSupportClasses
{
	public interface ISearchInputManager
	{
		function startSearch (viewModelValue:SearchInputViewModel):void;
		function cancelSearch ():void;
	}
}