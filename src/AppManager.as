package  
{
	import apollo.assetmanager.AssetManager;
	import apollo.debugger.Debug;
	import apollo.starlingExtensions.StarlingHandler;
	import feathers.controls.Screen;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.ScrollContainer;
	import flash.filesystem.File;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Apollo Meijer
	 */
	public class AppManager extends Sprite
	{
		private var pngImage:Class;
				
		private var backgrounds:Array 		= [];
		private var assets:Array 			= [];
		private var debug:Debug;
		private var navigator:ScreenNavigator;
				
		public function AppManager() 
		{
			//var tex:Texture = Texture.fromAtfData(new pngImage(), 1, false);
			//var image:Image = new Image(tex);
			//image.width = StarlingHandler.getInstance().getScreenBounds().width;t
			//image.height = StarlingHandler.getInstance().getScreenBounds().height;
			//this.addChild(image);
			
			this.debug = Debug.getInstance();
			this.addChild(debug);
			
			this.loadBackgroundList();
			this.loadExternalAssetList();
			
			var appView:AppView = new AppView(this.backgrounds, this.assets);
			this.addChild(appView);
		}
		
		private function loadBackgroundList():void 
		{
			this.backgrounds = this.getFilesRecursive("backgrounds" , []);
			for (var i:int = this.backgrounds.length -1; i >= 0; i--) 
			{
				var asset:String = this.backgrounds[i];
				if (asset.indexOf(".atf") == -1) this.backgrounds.splice(i, 1);
				//debug.doTrace(asset);
			}
			
			trace(this.backgrounds);
		}
		
		private function loadExternalAssetList():void 
		{
			this.assets = this.getFilesRecursive("assets" , []);
			for (var i:int = this.assets.length -1; i >= 0; i--) 
			{
				var asset:String = this.assets[i];
				if (asset.indexOf(".atf") == -1) this.assets.splice(i, 1);
				//debug.doTrace(asset);
			}
			
			trace(this.assets);
		}
		
		
		private function getFilesRecursive(_folder:String, _array:Array):Array {
            //the current folder object
			var pathToFile:String = File.applicationStorageDirectory.nativePath;
			
            var currentFolder:File = File.applicationDirectory.resolvePath(_folder);
            //the current folder's file listing
            var files:* = currentFolder.getDirectoryListing();
            
            //iterate and put files in the result and process the sub folders recursively
            for (var f:int = 0; f < files.length; f++) {
                if (files[f].isDirectory) {
                    if (files[f].name !="." && files[f].name !="..") {
                        //it's a directory
                        getFilesRecursive((files[f].nativePath != "") ? files[f].nativePath:  files[f].url, _array);
                    }
                } else {
                    //it's a file yupeee
                    _array.push((files[f].nativePath != "") ? files[f].nativePath:  files[f].url);
                }
            }
            
			return _array;
            
        }
	}

}