package common.config.api
{
    public interface IConfig
    {
        function parse( data:XML, cls:Class = null ):void;
    }
}