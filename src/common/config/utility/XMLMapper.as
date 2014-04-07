/**
 * User: Ray Yee
 * Date: 2014/4/7
 * All rights reserved.
 */
package common.config.utility
{
    public class XMLMapper
    {
        public function XMLMapper()
        {
        }

        public static function map( xmlObj:XML, mapped:Object ):void
        {
            if ( xmlObj == null ) return;
            var len:int = xmlObj.attributes().length();
            for ( var i:int = 0; i < len; i++ )
            {
                var propertyName:String = xmlObj.attributes()[i].name();
                if ( !mapped.hasOwnProperty( propertyName ) ) continue;
                mapped[propertyName] = xmlObj.attributes()[i];
            }
        }
    }
}
