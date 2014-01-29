package common.config
{
    import common.config.api.IConfig;

    import flash.utils.Dictionary;

    public class BasicConfig implements IConfig
    {
        protected var m_ConfigInfoList:Dictionary = new Dictionary;

        public function BasicConfig()
        {
        }

        public function parse( data:XML, cls:Class ):void
        {
            var dataList:XMLList = data.elements( data.children()[0].name() );
            var len:uint = dataList.length();
            for ( var i:uint = 0; i < len; i++ )
            {
                var node:XML = XML( dataList[i] );
                var configInfo:BaseConfigInfo = new cls;
                configInfo.fillXml( node );
                m_ConfigInfoList[configInfo.getKey()] = configInfo;
                /*if (configInfo is SerializedInfo)
                 {
                 var reflector:ReflectUtility = ReflectUtility.getReflector( cls );
                 (configInfo as SerializedInfo).mapper = reflector.getMapperWithMetadata( "Serializes", "id", true );
                 }*/
            }
        }

        /**
         * 通过覆盖BaseConfigInfo的getKey() 可改写key 默认key是id字段
         * @param key
         * @return
         */
        public function getConfigInfoByKey( key:* ):*
        {
            return m_ConfigInfoList[key];
        }

        public function getConfigList():Dictionary
        {
            return m_ConfigInfoList;
        }
    }
}