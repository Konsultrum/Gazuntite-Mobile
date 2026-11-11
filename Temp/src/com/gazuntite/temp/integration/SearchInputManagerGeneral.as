package com.gazuntite.temp.integration
{
	import com.gazuntite.common.view.component.searchInputSupportClasses.ISearchInputManager;
	import com.gazuntite.common.view.component.searchInputSupportClasses.SearchInputEvent;
	import com.gazuntite.common.view.component.searchInputSupportClasses.SearchInputViewModel;
	import com.gazuntite.temp.model.TempDataModel;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	
	public class SearchInputManagerGeneral implements ISearchInputManager
	{
		protected var viewModel:SearchInputViewModel;
		protected var source:ArrayCollection;
		
		protected var timer:Timer;
		public function SearchInputManagerGeneral(sourceValue:ArrayCollection=null)
		{
			if (sourceValue!=null)
			{
				source = sourceValue;
			}
			else
			{
				source = TempDataModel.getInstance().generalSource;
			}
		}
		
		public function startSearch(viewModelValue:SearchInputViewModel):void
		{
			this.viewModel = viewModelValue;
			var event:SearchInputEvent = new SearchInputEvent(SearchInputEvent.SEARCH_INPUT_EVENT_PENDING);
			viewModel.dispatchEvent(event);
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
		}
		public function cancelSearch():void
		{
			timer.stop();
		}
		
		protected function onTimer(event:TimerEvent):void
		{
			timer.stop();
			getItemList();
			var search_event:SearchInputEvent = new SearchInputEvent(SearchInputEvent.SEARCH_INPUT_EVENT_COMPLETE);
			viewModel.dispatchEvent(search_event);
		}
		protected function getItemList():void
		{
			viewModel.availableItems = new ArrayCollection( source.toArray());
		}
	}
}