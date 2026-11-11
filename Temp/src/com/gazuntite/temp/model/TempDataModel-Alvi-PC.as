package com.gazuntite.temp.model
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class TempDataModel
	{
		protected static var instance:TempDataModel = new TempDataModel();
		
		public var generalSource:ArrayCollection;
		public var allergySource:ArrayCollection;
		public var allergyItemList:ArrayCollection;
		public var icd9CodeList:ArrayCollection;
		public var icd9DescList:ArrayCollection;
		public var relationList:ArrayCollection;
		public var comprehensiveItemList:ArrayCollection;
		public var comprehensiveTabBarSource:ArrayCollection;
		public var sortSourceAllergy:ArrayCollection;
		public var sortSourceComprehensive:ArrayCollection;
		public var patientList:ArrayCollection;
		public var pharmacyList:ArrayCollection;
		public var medicineList:ArrayCollection;
		public var immunizationList:ArrayCollection;
		public var manufactureList:ArrayCollection;
		
		public function TempDataModel()
		{
			generalSource = new ArrayCollection(["Item One", "Item Two", "Item Three", "Item For","Item Five", "Item Six", "Item Seven"]);
			allergySource = new ArrayCollection(["Penicillin", "Dilantin", "Cephalosporins", "Sulfonamides","I.V. contrast dye", "Formaldehyde", "Chromium"]);
//			allergySource = new ArrayCollection(["Penicillin", "Dilantin", "Cephalosporins"]);
			allergyItemList = new ArrayCollection(["Penicillin", "Dilantin", "Cephalosporins"]);
			icd9CodeList = new ArrayCollection(["23.1", "123.2", "123.3","23.4", "123.5", "123.6","23.7", "123.8", "123.9"]);
			icd9DescList = new ArrayCollection(["TAENIA SOLIUM INFECTION INTESTINAL FORM","CYSTICERCOSIS","DIPHYLLOBOTHRIASIS INTESTINAL","HYMENOLEPIASIS","CESTODE INFECTION UNSPECIFIED"]);
			relationList = new ArrayCollection(["aunt","brother","cousin","daughter","father","grandchild","grandfather","husband","mother","sister","son","wife"]);
			comprehensiveItemList = new ArrayCollection(["Medical - Pelvic Varices", "Childhood - Malignant Neoplasm Of Other Major Salivary Glands","Medical - Pelvic Varices", "Childhood - Malignant Neoplasm Of Other Major Salivary Glands", "Medical - Pelvic Varices", "Childhood - Malignant Neoplasm Of Other Major Salivary Glands"]);
			comprehensiveTabBarSource = new ArrayCollection(["General","Family","Social"]);
			sortSourceAllergy = new ArrayCollection(["Recetly Added", "Allergy Name", "Reaction"]);
			sortSourceComprehensive = new ArrayCollection(["Recetly Added", "General History", "Family History", "Social"]);
			patientList = new ArrayCollection(["John Smith", "Lilly Pottery", "Dominique Camiliusberg", "Emmanuel Northswichski", "Sebastian Selevusdanovberg", "Elizabeth Androvochisven"]);
			pharmacyList = new ArrayCollection(["Congress Heights CHC Pharmacy","Hunt Place CHC Pharmacy","Walker Jones CHC Pharmacy","Upper Cardozo CHC Pharmacy"]);
			medicineList = new ArrayCollection(["Abacavir Sulfate","Abarelix","Bacitracin","Bicalutamide","Bleph 10","Butenafine","Calcitriol","DACOGEN","Fabrazyme","Gabapentin","Kalbitor","Labetalol","Palivizumab","Tacrine","Wellbutrin","Yervoy"]);
			immunizationList = new ArrayCollection(["Anthrax Vaccine","Hepatitis A Vaccine","Influenza A","Plague Vaccine","Rabies Vaccine","Yellow Fever Vaccine"]);
			manufactureList = new ArrayCollection(["Johnson & Johnson","General Electric Co.","Siemens AG","Medtronic Inc.","Baxter International Inc.","Covidien plc ","Novartis AG","Stryker Corp.","Boston Scientific Corp.","Hospira Inc. ","Bayer AG","Olympus Corp. "]);
		}
		public static function getInstance():TempDataModel
		{
			return instance;
		}
	}
}