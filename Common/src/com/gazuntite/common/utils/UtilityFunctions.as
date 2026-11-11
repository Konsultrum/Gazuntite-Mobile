package com.gazuntite.common.utils
{
	import flash.utils.ByteArray;
	
	import mx.utils.Base64Decoder;

	public class UtilityFunctions
	{
		//Recieve base64 image string as parameter and return Bytearray that directly assign to image source
		public static function getByteArray(val:String):ByteArray
		{
			var base64Dec:Base64Decoder = new Base64Decoder();;
			var byteArr:ByteArray;
			base64Dec.decode(val);
			byteArr = base64Dec.toByteArray();
			
			return byteArr;
		}
		public static function StringToBoolean(val:String):Boolean 
		{
			/*if(val.toLowerCase() == "false")
			return false;
			
			else if(val.toLowerCase() =="true")
			return true;*/
			
			return val.toLowerCase() =="true";
		}
		public static function TitleCase( value:String ):String
		{
			var s:String = value.toLowerCase();
			var tokens:Array = s.split(' ');
			var ret:String = '';
			for( var i:int = 0; i < tokens.length; i++ )
			{
				var token:String = tokens[ i ];
				var sep:String = (tokens.length == 1 )? '':' ';
				ret += token.charAt().toUpperCase() + token.substr( 1 ) + sep;
			}
			
			return TrimString( ret );
		}
		public static function TrimString(text:String):String 
		{
			return text.replace(/^\s+|\s+$/g, "");
		}
	}
}