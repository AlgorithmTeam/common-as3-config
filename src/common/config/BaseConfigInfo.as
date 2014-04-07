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