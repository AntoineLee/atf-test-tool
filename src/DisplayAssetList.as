package  
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.controls.TextInput;
	import feathers.core.ITextEditor;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
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
		private var bottomHeader:Header;
		private var input:TextInput;
		private var clear:Button;

		protected var _assets:Array;

				
		public function DisplayAssetList() 
		{
			
		}
		
	
		override protected function draw():void 
		{
			titleHeader.width = actualWidth;
			bottomHeader.width = actualWidth;
			
			//input.height = bottomHeader.height -2;
			//titleHeader.height = titleHeader.height + 10;
			//input.height = 50;
			
			input.width = (actualWidth - 50);
			
			bottomHeader.y = titleHeader.height;
			
			list.y = titleHeader.height + bottomHeader.height;
			list.width = actualWidth;
			list.height = (actualHeight - titleHeader.height) - bottomHeader.height;
		}
		
		override protected function initialize():void 
		{
			bottomHeader = new Header();
			
			this.addChild(bottomHeader);
			
			titleHeader = new Header();
			titleHeader.title = "Select Asset";
			this.addChild(titleHeader);
			
			this.list = new List();
			list.dataProvider = new ListCollection(this.assets);
			list.itemRendererProperties.labelField = "name";
			list.itemRendererProperties.accessoryTextureFunction = function(item:Object):Texture {
				return StandardIcons.listDrillDownAccessoryTexture;
			};
			
			this.clear = new Button();
			this.clear.label = "CLEAR";
			this.addChild(this.clear);
			this.clear.addEventListener(Event.TRIGGERED, onClearPressed);
			
			this.backBtn = new Button();
			this.backBtn.label = "BACK";
			this.addChild(this.backBtn);
			this.backBtn.addEventListener(Event.TRIGGERED, onBackPressed);
			
			input = new TextInput();
			input.text = "Search";
			input.addEventListener( Event.CHANGE, input_changeHandler );
			input.addEventListener( FeathersEventType.FOCUS_OUT, input_focusOutHandler );
			
			this.addChild( input );
			
			var HeaderleftItems:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			var BottomLeftItems:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			var BottomRightItems:Vector.<DisplayObject> = new Vector.<DisplayObject>();
			BottomLeftItems.push(input);
			BottomRightItems.push(clear);
			HeaderleftItems.push(backBtn);
			this.titleHeader.leftItems = HeaderleftItems;
			this.bottomHeader.leftItems = BottomLeftItems;
			this.bottomHeader.rightItems = BottomRightItems;
			
			list.addEventListener(Event.CHANGE, onListChange);
			this.addChild(list);
		}
		
		private function input_focusOutHandler(e:Event):void 
		{
			list.dataProvider = new ListCollection(this.assets);
			trace("FOCUS OFF");
		}
		
		private function input_changeHandler(e:Event):void 
		{
			if (!input.text) {
				list.dataProvider = new ListCollection(this.assets);
			}else {
				var showList:Array = [];
				for (var i:int = 0; i < this.assets.length; i++) 
				{
					var obj:Object = this.assets[i];
					var name:String = obj.name;
					if (name.indexOf(input.text) != -1) {
						showList.push(obj);
					}
				}
				list.dataProvider = new ListCollection(showList);
			}
			
		}
		
		private function onBackPressed(e:Event):void 
		{
			dispatchEventWith("complete");
		}
		
		private function onClearPressed(e:Event):void 
		{
			input.text = "";
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