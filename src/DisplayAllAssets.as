package  
{
	import apollo.assetmanager.AssetManager;
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
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
	public class DisplayAllAssets extends Screen 
	{
		private var titleHeader:Header;
		private var list:List;
		private var backBtn:Button;
		private var urlAssets:Array;
		private var displayContainer:ScrollContainer;

		protected var _assets:Array;

				
		public function DisplayAllAssets() 
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
			titleHeader.title = "All Assets";
			
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
			assetManager.loadAssets(this.urlAssets, setContainerContent, null, this.urlAssets);
		}
		
		public function setContainerContent():void 
		{
			var contentHeight:Number = 0;
			var assetManager:AssetManager = AssetManager.getInstance();
			for (var i:int = 0; i < this.assets.length; i++) 
			{
				var name:String = this.assets[i].name;
				var url:String = urlAssets[i];
				var scale = TextureScaleHandler.getScaleByName(name.split(".").splice(0, 1)[0]);
				var texture:Texture = assetManager.getTextureFromAtf(url, scale);
				var image:Image = new Image(texture);
				
				image.x = 20;
				image.y = 20 + (contentHeight + (i *40));
				
				var label:Label = new Label();
				label.text = name;
				label.y = (image.y + image.height)
				label.x = 15;
				this.displayContainer.addChild(label);
				
				contentHeight += (image.height);
				this.displayContainer.addChild(image);
			}
			
		}
		
		private function onBackPressed(e:Event):void 
		{
			dispatchEventWith("complete");
		}
		
		private function onListChange(e:Event):void
		{
			dispatchEventWith("listSelected", false, list.selectedItem);
		}
		 
		public function get assets():Array
		{
			return this._assets;
		}
		 
		public function set assets( value:Array ):void
		{
			var arr:Array = [];
			for (var i:int = 0; i < value.length; i++) 
			{
				var url:String = value[i];
				var splitArray:Array = url.split("\\");
				if (splitArray.length == 1) {
					splitArray = url.split("/");
				}
				var name:String = splitArray[splitArray.length -1];
				var obj:Object = new Object();
				obj.name = name;
				obj.url = url;
				arr.push(obj);
			}
			this.urlAssets = value;
			this._assets = arr;
			this.invalidate( INVALIDATION_FLAG_DATA );
			
		}
	}

}