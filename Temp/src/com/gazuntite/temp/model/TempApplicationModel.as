package com.gazuntite.temp.model
{
	import com.gazuntite.common.model.valueobject.login.SessionDTO;
	import com.gazuntite.common.model.valueobject.provider.ProviderStatusDTO;

	[Bindable]
	public class TempApplicationModel
	{
		protected static var instance:TempApplicationModel;
		public var loggedInUserSessionDTO:SessionDTO;
		
		
		//TODO get version from config
		public var version:String = "0.1";
		
		public function TempApplicationModel()
		{
			loggedInUserSessionDTO = new SessionDTO();
			loggedInUserSessionDTO.Status = ProviderStatusDTO.ONLINE;
		}
		public static function getInstance():TempApplicationModel
		{
			if (instance == null)
			{
				instance = new TempApplicationModel();
			}
			return instance;
		}
	}
}