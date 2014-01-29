package common.config
{

    /******************************************************
     *
     * 创建者：cy
     * 功能：
     * 说明：
     *
     ******************************************************/
    public class BaseConfigInfo
    {
        public var id:int;
        protected static const SPLIT_SYMBOL:String = "-";
        protected static const SPLIT_SYMBOL_LIST:String = ",";

        public function BaseConfigInfo()
        {
        }

        /**
         * xml赋值
         * @param    obj
         */
        public function fillXml( xmlObj:XML ):void
        {
            if ( xmlObj == null ) return;
            var len:int = xmlObj.attributes().length();
            for ( var i:int = 0; i < len; i++ )
            {
                var propertyName:String = xmlObj.attributes()[i].name();
                if ( !hasOwnProperty( propertyName ) ) continue;
                this[propertyName] = xmlObj.attributes()[i];
            }
        }

        public function getKey():String
        {
            return String( id );
        }

        public function getID():int
        {
            return id;
        }

    }
}