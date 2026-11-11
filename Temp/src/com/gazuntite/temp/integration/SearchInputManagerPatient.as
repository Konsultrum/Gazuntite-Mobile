package com.gazuntite.temp.integration
{
	import com.gazuntite.temp.model.TempDataModel;
	
	import mx.collections.ArrayCollection;

	public class SearchInputManagerPatient extends SearchInputManagerGeneral
	{
		public function SearchInputManagerPatient()
		{
			super();
		}
		override protected function getItemList():void
		{
			viewModel.availableItems = new ArrayCollection( TempDataModel.getInstance().patientList.toArray());
		}
	}
}