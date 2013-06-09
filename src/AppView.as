package  
{
	import feathers.controls.Header;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.themes.MetalWorksMobileTheme;
	import starling.display.Sprite;
	import starling.events.Event;
	/**
	 * ...
	 * @author Apollo Meijer
	 */
	public class AppView extends Sprite
	{
		private var backgrounds:Array;
		private var assets:Array;
		
		private var navigator:ScreenNavigator;
		private var assetListScreen:ScreenNavigatorItem;
		private var selectAsset:ScreenNavigatorItem;
		private var assetDisplay:ScreenNavigatorItem;
		private var showAllAssets:ScreenNavigatorItem;
		
		
		
		public function AppView(_backgrounds:Array, _assets:Array) 
		{
			this.backgrounds = _backgrounds;
			this.assets = _assets;
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			var theme:MetalWorksMobileTheme = new MetalWorksMobileTheme(this.stage);
			
			this.navigator = new ScreenNavigator();
			this.addChild(this.navigator);
			
			assetListScreen = new ScreenNavigatorItem(DisplayOptionList, { listSelected: selectedOption } );
			this.navigator.addScreen(AppConfig.SELECT_DISPLAY_OPTIONS, assetListScreen);
			
			selectAsset = new ScreenNavigatorItem(DisplayAssetList, { complete: AppConfig.SELECT_DISPLAY_OPTIONS, listSelected: selectedOption }, {assets:this.assets});
			this.navigator.addScreen(AppConfig.SELECT_ASSET_OPTION, selectAsset);
			
			showAllAssets = new ScreenNavigatorItem(DisplayAllAssets, { complete: AppConfig.SELECT_DISPLAY_OPTIONS, listSelected: selectedOption }, {assets:this.assets});
			this.navigator.addScreen(AppConfig.SHOW_ALL_ASSET_DISPLAY, showAllAssets);
			
			assetDisplay = new ScreenNavigatorItem(DisplayAsset, { complete: AppConfig.SELECT_ASSET_OPTION });
			this.navigator.addScreen(AppConfig.SHOW_ASSET_DISPLAY, assetDisplay);
			
			this.navigator.showScreen(AppConfig.SELECT_DISPLAY_OPTIONS);
			
			var trans:ScreenSlidingStackTransitionManager = new ScreenSlidingStackTransitionManager(this.navigator);
		}
		
		public function selectedOption(e:Event, selectedObjInfo:Object ):void 
		{
			switch(selectedObjInfo.name) {
				case "List View":
					trace("list view init");
					this.navigator.showScreen(AppConfig.SELECT_ASSET_OPTION);
					break;
				case "Free View":
					this.navigator.showScreen(AppConfig.SHOW_ALL_ASSET_DISPLAY);
					break;
				default:
					assetDisplay.properties = {displayData:selectedObjInfo};
					this.navigator.showScreen(AppConfig.SHOW_ASSET_DISPLAY);
				break;
			}
		}
	}

}