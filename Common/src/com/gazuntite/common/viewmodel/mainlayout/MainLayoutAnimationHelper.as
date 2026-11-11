package com.gazuntite.common.viewmodel.mainlayout
{
	import mx.effects.AnimateProperty;

	public class MainLayoutAnimationHelper
	{
		public var duration:Number = 1;
		protected var manager:MainLayoutManager = MainLayoutManager.getInstance();
		
		protected var topViewPercentHeight:Number = 0;
		protected var inputPercentHeight:Number = 0;
		protected var historyPercentHeight:Number = 0;
		
		public function MainLayoutAnimationHelper()
		{
		}
		protected function animateContainer(target:Object, propertyName:String, toValue:Number):void
		{
			var animator:AnimateProperty = new AnimateProperty(target);
			animator.property = propertyName;
			animator.toValue = toValue;
			animator.duration = duration;
			animator.play();
		}
		public function startAnimation():void
		{
			var prev:MainLayoutState = manager.prevViewState;
			var cur:MainLayoutState = manager.curViewState;
			
			var top_h:int;
			if (!cur.topBarViewOpen) 
			{	
				top_h = 0;	
				manager.uiTopViewContainer.includeInLayout = false;
				manager.uiTopViewContainer.visible = false;
			}
			else if (cur.visibleViewCount == 1)	
			{
				top_h = 50;
				manager.uiTopViewContainer.includeInLayout = true;
				manager.uiTopViewContainer.visible = true;
				animateContainer(manager.uiTopViewContainer, 'percentHeight', top_h);
			}
			else 
			{
				top_h = 50;
				manager.uiTopViewContainer.includeInLayout = true;
				manager.uiTopViewContainer.visible = true;
				animateContainer(manager.uiTopViewContainer, 'percentHeight', top_h);
			}
			
			
			var input_h:int;
			if (!cur.patientInputOpen) 
			{	
				input_h = 0;	
				manager.uiPatientInput.includeInLayout = false;
				manager.uiPatientInput.visible = false;
			}
			else if (cur.visibleViewCount == 1)	
			{
				input_h = 100;
				manager.uiPatientInput.includeInLayout = true;
				manager.uiPatientInput.visible = true;
				animateContainer(manager.uiPatientInput, 'percentHeight', input_h);
			}
			else 
			{
				input_h = 50;
				manager.uiPatientInput.includeInLayout = true;
				manager.uiPatientInput.visible = true;
				animateContainer(manager.uiPatientInput, 'percentHeight', input_h);
			}
			
			
			
			var history_h:int;
			if (!cur.patientHistoryOpen) 
			{	
				history_h = 0;	
				manager.uiPatientHistory.includeInLayout = false;
				manager.uiPatientHistory.visible = false;
			}
			else if (cur.visibleViewCount == 1)	
			{
				history_h = 100;
				manager.uiPatientHistory.includeInLayout = true;
				manager.uiPatientHistory.visible = true;
				animateContainer(manager.uiPatientHistory, 'percentHeight', history_h);
			}
			else 
			{
				history_h = 50;
				manager.uiPatientHistory.includeInLayout = true;
				manager.uiPatientHistory.visible = true;
				animateContainer(manager.uiPatientHistory, 'percentHeight', history_h);
			}
			
		}
	}
}