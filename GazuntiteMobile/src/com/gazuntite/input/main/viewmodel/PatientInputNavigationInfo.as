package com.gazuntite.input.main.viewmodel
{
	import com.gazuntite.common.viewmodel.navigation.NavigationInfo;
	import com.gazuntite.common.viewmodel.navigation.NavigationInfoItem;
	import com.gazuntite.common.viewmodel.navigation.ViewIds;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class PatientInputNavigationInfo extends NavigationInfo
	{
		
		public function PatientInputNavigationInfo()
		{
			navItemList = new ArrayCollection();
			var item:NavigationInfoItem;
			var subItem:NavigationInfoItem;
			
			item = new NavigationInfoItem(null, "History,1");
			subItem = new NavigationInfoItem(item, "Allergies", ViewIds.ALLERGIES);
			item.addSubItem(subItem);
			
			subItem = new NavigationInfoItem(item, "Comprehensive HX", ViewIds.COMPREHENSIVE);
			item.addSubItem(subItem);
			
			subItem = new NavigationInfoItem(item, "Chronic Medication", ViewIds.CHRONIC);
			item.addSubItem(subItem);
			
			subItem = new NavigationInfoItem(item, "Immunization", ViewIds.IMMUNIZATION);
			item.addSubItem(subItem);
			
			navItemList.addItem(item);
			currentTopNavItem = item;
			currentSubNavItem = item.subNavInfoItemList[0] as NavigationInfoItem;
			
			
			item = new NavigationInfoItem(null, "Physical,2");
			subItem = new NavigationInfoItem(item, "Vitals", ViewIds.VITALS);
			item.addSubItem(subItem);
			
			subItem = new NavigationInfoItem(item, "Chief Complaint/HPI");
			item.addSubItem(subItem);
			
			subItem = new NavigationInfoItem(item, "Review of System");
			item.addSubItem(subItem);
			
			subItem = new NavigationInfoItem(item, "Physical");
			item.addSubItem(subItem);
			
			subItem = new NavigationInfoItem(item, "In-House Lab");
			item.addSubItem(subItem);
			
			navItemList.addItem(item);
			
			item = new NavigationInfoItem(null, "Assesment,3");
			subItem = new NavigationInfoItem(item, "Diagnosis");
			item.addSubItem(subItem);
			
			subItem = new NavigationInfoItem(item, "Treatment");
			item.addSubItem(subItem);
			
			subItem = new NavigationInfoItem(item, "Plan");
			item.addSubItem(subItem);
			
			navItemList.addItem(item);
			
			createLinks();  
		}
		protected function createLinks():void
		{
			var history:ArrayCollection = (this.navItemList[0] as NavigationInfoItem).subNavInfoItemList;
			var physical:ArrayCollection = (this.navItemList[1] as NavigationInfoItem).subNavInfoItemList;
			var access:ArrayCollection = (this.navItemList[2] as NavigationInfoItem).subNavInfoItemList;
			(history[0] as NavigationInfoItem).nextItem = history[1] as NavigationInfoItem;
			(history[1] as NavigationInfoItem).nextItem = history[2] as NavigationInfoItem;
			(history[2] as NavigationInfoItem).nextItem = history[3] as NavigationInfoItem;
			(history[3] as NavigationInfoItem).nextItem = physical[0] as NavigationInfoItem;

			(physical[0] as NavigationInfoItem).nextItem = physical[1] as NavigationInfoItem;
			(physical[1] as NavigationInfoItem).nextItem = physical[2] as NavigationInfoItem;
			(physical[2] as NavigationInfoItem).nextItem = physical[3] as NavigationInfoItem;
			(physical[3] as NavigationInfoItem).nextItem = physical[4] as NavigationInfoItem;
			(physical[4] as NavigationInfoItem).nextItem = access[0] as NavigationInfoItem;
			
			(access[0] as NavigationInfoItem).nextItem = access[1] as NavigationInfoItem;
			(access[1] as NavigationInfoItem).nextItem = access[2] as NavigationInfoItem;
			

			
			(history[1] as NavigationInfoItem).prevItem = history[0] as NavigationInfoItem;
			(history[2] as NavigationInfoItem).prevItem = history[1] as NavigationInfoItem;
			(history[3] as NavigationInfoItem).prevItem = history[2] as NavigationInfoItem;

			(physical[0] as NavigationInfoItem).prevItem = history[3] as NavigationInfoItem;
			(physical[1] as NavigationInfoItem).prevItem = physical[0] as NavigationInfoItem;
			(physical[2] as NavigationInfoItem).prevItem = physical[1] as NavigationInfoItem;
			(physical[3] as NavigationInfoItem).prevItem = physical[2] as NavigationInfoItem;
			(physical[4] as NavigationInfoItem).prevItem = physical[3] as NavigationInfoItem;
			
			(access[0] as NavigationInfoItem).prevItem = physical[4] as NavigationInfoItem;
			(access[1] as NavigationInfoItem).prevItem = access[0] as NavigationInfoItem;
			(access[2] as NavigationInfoItem).prevItem = access[1] as NavigationInfoItem;
			
		}
	}
}