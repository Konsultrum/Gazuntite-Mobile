package com.gazuntite.temp.integration
{
	import com.gazuntite.temp.model.TempDataModel;
	
	import mx.collections.ArrayCollection;

	public class SearchInputManagerAllergy extends SearchInputManagerGeneral
	{
		public function SearchInputManagerAllergy()
		{
			super();
		}
		override protected function getItemList():void
		{
			viewModel.availableItems = new ArrayCollection( TempDataModel.getInstance().allergySource.toArray());
		}
	}
}