package  
{
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.skins.StandardIcons;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Apollo Meijer
	 */
	public class DisplayOptionList extends Screen 
	{
		private var titleHeader:Header;
		private var list:List;
		
		public function DisplayOptionList() 
		{
			
		}
		
	
		override protected function draw():void 
		{
			titleHeader.width = actualWidth;
			
			list.y = titleHeader.height;
			list.width = actualWidth;
			list.height = actualHeight - titleHeader.height;
		}
		
		override protected function initialize():void 
		{
			titleHeader = new Header();
			titleHeader.title = "Select Display Option";
			this.addChild(titleHeader);
			
			this.list = new List();
			list.dataProvider = new ListCollection(AppConfig.DISPLAY_OPTIONS);
			list.itemRendererProperties.labelField = "name";
			list.itemRendererProperties.accessoryTextureFunction = function(item:Object):Texture {
				return StandardIcons.listDrillDownAccessoryTexture;
			};
			
			list.addEventListener(Event.CHANGE, onListChange);
			this.addChild(list);
		}
		
		private function onListChange(e:Event):void 
		{
			dispatchEventWith("listSelected", false, list.selectedItem);
		}
	}

}