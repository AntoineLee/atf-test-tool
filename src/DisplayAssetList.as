package  
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.skins.StandardIcons;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Apollo Meijer
	 */
	public class DisplayAssetList extends Screen 
	{
		private var titleHeader:Header;
		private var list:List;
		private var backBtn:Button;

		protected var _assets:Array;

				
		public function DisplayAssetList() 
		{
			
		}
		
	
		override protected function draw():void 
		{
			titleHeader.width = actualWidth;
			
			list.y = titleHeader.height;
			list.width = actualWidth;
			list.height = actualHeight - titleHeader.height;
			
			trace("DRAW");
		}
		
		override protected function initialize():void 
		{
			titleHeader = new Header();
			titleHeader.title = "Select Asset";
			
			this.addChild(titleHeader);
			
			this.list = new List();
			list.dataProvider = new ListCollection(this.assets);
			list.itemRendererProperties.labelField = "name";
			list.itemRendererProperties.accessoryTextureFunction = function(item:Object):Texture {
				return StandardIcons.listDrillDownAccessoryTexture;
			};
			
			this.backBtn = new Button();
			this.backBtn.label = "BACK";
			this.addChild(this.backBtn);
			this.backBtn.addEventListener(Event.TRIGGERED, onBackPressed);
			
			var item:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			item.push(this.backBtn);
			this.titleHeader.leftItems = item;
			
			list.addEventListener(Event.CHANGE, onListChange);
			this.addChild(list);
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
			this._assets = arr;
			this.invalidate( INVALIDATION_FLAG_DATA );
			
		}
	}

}