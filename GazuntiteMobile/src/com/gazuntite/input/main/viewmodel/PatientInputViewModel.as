package com.gazuntite.input.main.viewmodel
{
	import com.gazuntite.common.viewmodel.navigation.ViewFactory;
	import com.gazuntite.common.viewmodel.navigation.ViewIds;
	import com.gazuntite.input.allergy.view.AllergiesInputView;
	import com.gazuntite.input.chronic.view.ChronicInputViewContainer;
	import com.gazuntite.input.comprehensive.view.ComprehensiveInputView;
	import com.gazuntite.input.immunization.view.ImmunizationInputViewContainer;
	import com.gazuntite.temp.view.PlaceHolderView;

	[Bindable]
	public class PatientInputViewModel
	{
		protected static var instance:PatientInputViewModel;
		
		public var navigationInfo:PatientInputNavigationInfo;
		
		public function PatientInputViewModel(singleton:int)
		{
			navigationInfo = new PatientInputNavigationInfo();
			registerView();
		}
		public static function getInstance():PatientInputViewModel
		{
			if (instance == null)
			{
				instance = new PatientInputViewModel(0);
			}
			return instance;
		}

		private function registerView():void
		{
			ViewFactory.registerViewClass(ViewIds.PLACE_HOLDER, PlaceHolderView);
			ViewFactory.registerViewClass(ViewIds.ALLERGIES, AllergiesInputView);
			ViewFactory.registerViewClass(ViewIds.COMPREHENSIVE, ComprehensiveInputView);
			ViewFactory.registerViewClass(ViewIds.CHRONIC, ChronicInputViewContainer);
			ViewFactory.registerViewClass(ViewIds.IMMUNIZATION, ImmunizationInputViewContainer);
			ViewFactory.registerViewClass(ViewIds.VITALS, PlaceHolderView);
		}
		
	}
}