package com.gazuntite.view.patient.input.physical
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.gazuntite.patient.visit.model.QIModelLocator;
	import com.gazuntite.view.patient.input.physical.chiefcomplaint.PatientInputPhysicalChiefComplaintViewModel;
	import com.gazuntite.view.patient.input.physical.inhouselab.PatientInputPhysicalInHouseLabViewModel;
	import com.gazuntite.view.patient.input.physical.vitals.PatientInputPhysicalVitalsViewModel;

	[Bindable]
	public class PatientInputPhysicalViewModel
	{
		public var selectedViewLabel:String;
		public var refreshPhysicalData:Boolean;
		public var isPhysicalTabSelected:Boolean;
		public var model:QIModelLocator = QIModelLocator.getInstance();
		
		public var vitalsViewModel:PatientInputPhysicalVitalsViewModel = PatientInputPhysicalVitalsViewModel.getInstance();
		public var ccHpiViewModel:PatientInputPhysicalChiefComplaintViewModel = PatientInputPhysicalChiefComplaintViewModel.getInstance();
		public var inHouseLabViewModel:PatientInputPhysicalInHouseLabViewModel = PatientInputPhysicalInHouseLabViewModel.getInstance();
		
		//[06/13/2013] Shahid Munir
		public var patientInputPhysicalVitalsViewModel:PatientInputPhysicalVitalsViewModel = PatientInputPhysicalVitalsViewModel.getInstance();

		protected static var instance:PatientInputPhysicalViewModel;
		public function PatientInputPhysicalViewModel(useSingleton:Number)
		{
		}
		public static function getInstance():PatientInputPhysicalViewModel
		{
			if (instance == null)
			{
				instance = new PatientInputPhysicalViewModel(1);
			}
			return instance;
		}
		
		public function loadPhysicalTabData():void
		{
			if (refreshPhysicalData)
			{
				ccHpiViewModel.loadChiefComplaintHpi();
				inHouseLabViewModel.loadInHouseLabs();
				
				//[06/13/2013] Shahid Munir
				patientInputPhysicalVitalsViewModel.loadPatientVitals();
				
				refreshPhysicalData = false;
			}
		}
	
		public function clearPhysicalTabData():void
		{
			vitalsViewModel.clearVitals();
			ccHpiViewModel.clearChiefComplaintHpi();
			inHouseLabViewModel.clearInHouseLabs();
			
			clearROS();
			clearPhysicals();
		}
		
		public function loadPhysicalStaticData():void
		{
		}
		
		
		///////////////////////////// Review of System ////////////////////
		
		public function clearROS():void
		{
			var model:QIModelLocator = QIModelLocator.getInstance();
			if( null != model.rosDTOList )
				model.rosDTOList.removeAll();
		}
		
		public function clearPhysicals():void
		{
			var model:QIModelLocator = QIModelLocator.getInstance();
			if( null != model.physicalDTOList )
				model.physicalDTOList.removeAll();
		}
		
		///////////////////////////// Review of System ////////////////////
	}
}