package com.gazuntite.common.viewmodel.mainlayout
{
	import mx.core.UIComponent;

	[Bindable]
	public class MainLayoutManager
	{
		protected static var instance:MainLayoutManager
		public var curViewState:MainLayoutState = new MainLayoutState();
		public var prevViewState:MainLayoutState
		
		public var uiMainContainer:UIComponent;
		public var uiLoginView:UIComponent;
		public var uiTopViewContainer:UIComponent;
		public var uiPatientInput:UIComponent;
		public var uiPatientHistory:UIComponent;
		
		public var showPriacticeManagerView:Boolean = false;
		
		public function MainLayoutManager(singleton:Number)
		{
			prevViewState = curViewState.clone();
		}
		public static function getInstance():MainLayoutManager
		{
			if (instance == null)
			{
				instance = new MainLayoutManager(0);
			}
			return instance;
		}
		public function initialize(mainContainer:UIComponent, loginView:UIComponent, topView:UIComponent, input:UIComponent, history:UIComponent):void
		{
			uiMainContainer = mainContainer;
			uiLoginView = loginView;
			uiTopViewContainer = topView;
			uiPatientInput = input;
			uiPatientHistory = history;
			updateContainers();
		}
		public function processLoginSuccess():void
		{
			uiLoginView.visible = false;
		}
		public function togglePatientInput():void
		{
			curViewState.patientInputOpen = !curViewState.patientInputOpen;
			updateContainers();
		}
		public function maximizePatientInput():void
		{
			curViewState.patientInputOpen = true;
			curViewState.patientHistoryOpen = false;
			curViewState.closeTopBarViews();
			updateContainers();
		}
		public function togglePatientHistory():void
		{
			curViewState.patientHistoryOpen = !curViewState.patientHistoryOpen;
			if (curViewState.topBarViewOpen && curViewState.patientHistoryOpen)
			{
				curViewState.patientInputOpen = false;
			}
			updateContainers();
		}
		public function maximizePatientHistory():void
		{
			curViewState.patientInputOpen = false;
			curViewState.patientHistoryOpen = true;
			curViewState.closeTopBarViews();
			updateContainers();
		}
		public function toggleRapidAccess():void
		{
			curViewState.rapidAccessViewOpen = !curViewState.rapidAccessViewOpen;
			if (curViewState.rapidAccessViewOpen)
			{
				curViewState.webViewOpen = false;
				curViewState.communicationViewOpen = false;
			}
			updateContainers();
		}
		public function toggleCommunication():void
		{
			curViewState.communicationViewOpen = !curViewState.communicationViewOpen;
			if (curViewState.communicationViewOpen)
			{
				curViewState.rapidAccessViewOpen = false;
				curViewState.webViewOpen = false;
			}
			updateContainers();
		}
		public function toggleWeb():void
		{
			curViewState.webViewOpen = !curViewState.webViewOpen;
			if (curViewState.webViewOpen)
			{
				curViewState.rapidAccessViewOpen = false;
				curViewState.communicationViewOpen = false;
			}
			updateContainers();
		}
		protected function updateContainers():void
		{
			if (curViewState.topBarViewOpen && curViewState.patientInputOpen && curViewState.patientHistoryOpen)
			{
				if (curViewState.topBarViewOpen != prevViewState.topBarViewOpen)
				{
						curViewState.patientHistoryOpen = false;
				}
				else if (curViewState.patientInputOpen != prevViewState.patientInputOpen)
				{
					curViewState.patientHistoryOpen = false;
				}
				else if (curViewState.patientHistoryOpen != prevViewState.patientHistoryOpen)
				{
					curViewState.patientInputOpen = false;
				}
			}
			var animator:MainLayoutAnimationHelper = new MainLayoutAnimationHelper();
			animator.startAnimation();
		}
	}
}