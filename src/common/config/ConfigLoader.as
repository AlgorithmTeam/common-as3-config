/**
 * User: Ray Yee
 * Date: 14-1-29
 * All rights reserved.
 */
package common.config
{
    import common.config.api.IConfig;
    import common.loader.IPQLoader;
    import common.loader.PQLoader;
    import common.loader.item.XMLItem;

    import flash.system.System;
    import flash.utils.Dictionary;
    import flash.utils.getDefinitionByName;

    public class ConfigLoader
    {

        private var loader:IPQLoader = PQLoader.getInstance( "config" );
        private var configFileCache:Dictionary = new Dictionary;
        private var configFileNameList:Array = [];
        private var configClassCache:Dictionary = new Dictionary();
        private var configLoadedBack:Function;

        public function ConfigLoader()
        {
        }

        public function start( configFilePath:String, callBack:Function = null ):void
        {
            configLoadedBack = callBack;
            loader.addItem( configFilePath, XMLItem ).complete( function ():void
            {
                parseConfigFile( XMLItem( loader.getItem( configFilePath ) ).xml );

                //Recursion load configured file list
                loadXmlListItem();
            } );
            loader.start();
        }

        public function getConfigClass():Dictionary
        {
            return configClassCache;
        }

        private function parseConfigFile( xml:XML ):void
        {
            var fileList:XMLList = xml.configFileList.file;
            var len:int = fileList.length();
            for ( var j:uint = 0; j < len; j++ )
            {
                var file:XML = XML( fileList[j] );
                var fileName:String = file.@name;
                configFileCache[fileName] = String( file.@className );
                configFileNameList.push( fileName );
            }
            System.disposeXML( xml );
        }

        private function loadXmlListItem():void
        {
            var fileName:String = configFileNameList.shift();
            var className:String = configFileCache[fileName];
            var nameList:Array = fileName.split( "." );
            var fileUrlPath:String = "config/" + fileName;
            if ( nameList[1] == "xml" )
                loader.addItem( fileUrlPath, XMLItem );
            loader.complete( function ():void
            {
                var cls:Class = getDefinitionByName( className ) as Class;
                if ( cls )
                {
                    var config:IConfig = new cls;
                    if ( config )
                    {
                        var name:String = className + "Info";
                        var configCls:Class = getDefinitionByName( name ) as Class;
                        if ( nameList[1] == "xml" )
                        {
                            var xml:XML = XMLItem( loader.getItem( fileUrlPath ) ).xml;
                            config.parse( xml, configCls );
                            System.disposeXML( xml );
                        }

                        configClassCache[cls] = config;
                    }
                }

                if ( configFileNameList.length > 0 )
                {
                    loadXmlListItem();
                }
                else
                {
                    configLoadedBack && configLoadedBack();
                    loader.dispose();
                }

            } );
        }

        private function reflectConfigFileToClass():void
        {

        }
    }
}