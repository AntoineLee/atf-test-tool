package  
{
	import apollo.assetmanager.AssetManager;
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.data.ListCollection;
	import feathers.display.Image;
	import feathers.skins.StandardIcons;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Apollo Meijer
	 */
	public class DisplayAsset extends Screen 
	{
		private var titleHeader:Header;
		private var list:List;
		private var backBtn:Button;
		private var _displayData:Object;
		private var displayContainer:ScrollContainer;

				
		public function DisplayAsset() 
		{
			
		}
		
	
		override protected function draw():void 
		{
			titleHeader.width = actualWidth;
			
			displayContainer.y = titleHeader.height;
			displayContainer.width = actualWidth;
			displayContainer.height = actualHeight - titleHeader.height;
		}
		
		override protected function initialize():void
		{
			titleHeader = new Header();
			titleHeader.title = this.displayData.name;
			
			this.addChild(titleHeader);
			
			this.backBtn = new Button();
			this.backBtn.label = "BACK";
			this.addChild(this.backBtn);
			this.backBtn.addEventListener(Event.TRIGGERED, onBackPressed);
			
			var item:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			item.push(this.backBtn);
			this.titleHeader.leftItems = item;
			
			this.displayContainer = new ScrollContainer();
			this.addChild(this.displayContainer);
			
			var assetManager:AssetManager = AssetManager.getInstance();
			assetManager.loadAssets([this.displayData.url], setContainerContent, null,[this.displayData.url]);
		}
		
		public function setContainerContent():void 
		{
			var assetManager:AssetManager = AssetManager.getInstance();
			var scale = TextureScaleHandler.getScaleByName(this.displayData.name.split(".").splice(0, 1)[0]);
			var texture:Texture = assetManager.getTextureFromAtf(this.displayData.url, scale);
			var image:Image = new Image(texture);
			
			image.x = 20;
			image.y = 20;
			this.displayContainer.addChild(image);
		}
		
		private function onBackPressed(e:Event):void 
		{
			dispatchEventWith("complete");
		}
		
		private function onListChange(e:Event):void 
		{
			dispatchEventWith("listSelected", false, list.selectedItem);
		}
		
		public function get displayData():Object
		{
			return this._displayData;
		}
		 
		public function set displayData( value:Object ):void
		{
			this._displayData = value;
			this.invalidate( INVALIDATION_FLAG_DATA );
			
		}
	}

}