package com.gazuntite.common.viewmodel.navigation
{
	public class ViewFactory
	{
		static protected var viewClassDict:Object = new Object();
		static public function registerViewClass(viewId:int, viewClass:Class):void
		{
			if (viewClassDict[viewId]==null)
			{
				viewClassDict[viewId] = viewClass;
			}
		}
		static public function getViewClass(viewId:int):Class
		{
			var result:Class = viewClassDict[viewId];
			return result;
		}
	}
}