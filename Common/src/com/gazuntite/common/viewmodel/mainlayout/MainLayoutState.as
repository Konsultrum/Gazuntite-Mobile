package com.gazuntite.common.viewmodel.mainlayout
{
	import flash.events.Event;

	[Bindable]
	public class MainLayoutState
	{
		public var rapidAccessViewOpen:Boolean = false;
		public var communicationViewOpen:Boolean = false;
		public var webViewOpen:Boolean = false;
		public var patientInputOpen:Boolean = false;
		public var patientHistoryOpen:Boolean = false;
		public function MainLayoutState()
		{
		}
		public function clone():MainLayoutState
		{
			var copy:MainLayoutState = new MainLayoutState();
			copy.rapidAccessViewOpen = this.rapidAccessViewOpen;
			copy.communicationViewOpen = this.communicationViewOpen;
			copy.webViewOpen = this.communicationViewOpen;
			copy.patientInputOpen = this.patientInputOpen;
			copy.patientHistoryOpen = this.patientHistoryOpen;
			return copy;
		}

		public function get topBarViewOpen():Boolean
		{
			var result:Boolean;
			result = rapidAccessViewOpen || communicationViewOpen || webViewOpen;
			return result;
		}
		
		public function closeTopBarViews():void
		{
			rapidAccessViewOpen = false;
			communicationViewOpen = false;
			webViewOpen = false;
		}
		
		public function get visibleViewCount():int
		{
			var result:int = 0;
			if (topBarViewOpen)
			{
				result ++;
			}
			if (patientInputOpen)
			{
				result ++;
			}
			if (patientHistoryOpen)
			{
				result ++;
			}
			return result;
		}
	}
}