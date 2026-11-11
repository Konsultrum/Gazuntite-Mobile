package com.gazuntite.topbar.view
{
	import com.gazuntite.common.viewmodel.mainlayout.MainLayoutManager;
	import com.gazuntite.common.viewmodel.mainlayout.MainLayoutState;
	import com.gazuntite.temp.view.CommunicationPlaceHolder;
	import com.gazuntite.temp.view.RapidAccessPlaceHolder;
	import com.gazuntite.temp.view.WebSearchPlaceHolder;
	
	import mx.binding.utils.BindingUtils;
	
	import spark.components.ViewNavigator;
	import spark.transitions.CrossFadeViewTransition;
	
	public class TopBarViewNavigator extends ViewNavigator
	{
		protected var mainLayoutManager:MainLayoutManager;
		protected var transition:CrossFadeViewTransition;
		public function TopBarViewNavigator()
		{
			super();
			transition = new CrossFadeViewTransition();
			mainLayoutManager = MainLayoutManager.getInstance();
			BindingUtils.bindSetter(onTopViewChange, mainLayoutManager, ["curViewState","rapidAccessViewOpen"]);
			BindingUtils.bindSetter(onTopViewChange, mainLayoutManager, ["curViewState","communicationViewOpen"]);
			BindingUtils.bindSetter(onTopViewChange, mainLayoutManager, ["curViewState","webViewOpen"]);
		}
		
		private function onTopViewChange(param:*):void
		{
			transition.duration = mainLayoutManager.prevViewState.topBarViewOpen? 250:0;
			this.popAll();
			var cur:MainLayoutState = mainLayoutManager.curViewState;
			if (cur.rapidAccessViewOpen)
			{
				this.pushView(RapidAccessPlaceHolder, null, null, transition);
			}
			else if (cur.communicationViewOpen)
			{
				this.pushView(CommunicationPlaceHolder, null, null, transition);
			}
			else if (cur.webViewOpen)
			{
				this.pushView(WebSearchPlaceHolder, null, null, transition);
			}
		}
	}
}