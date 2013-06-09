package  
{
	/**
	 * ...
	 * @author Apollo Meijer
	 */
	public class TextureScaleHandler 
	{
		
		public function TextureScaleHandler() 
		{
			
		}
		
		
		public static function getScaleByName(_name:String):Number {
			var scale:Number = 0;
			var obj:Object = TextureScaleConfig.scaleObjects;
			if (obj[_name]) {
				scale = obj[_name]; 
			}
			return scale;
		}
	}

}