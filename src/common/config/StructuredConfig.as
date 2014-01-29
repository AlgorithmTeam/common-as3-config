/*
 * Copyright (c) 2013. Ray Yee. All rights reserved.
 */

/**
 * User: Ray Yee
 * Date: 13-10-24
 */
package common.config
{
    import common.data.structure.HashMap;
    import common.data.structure.linkList.DoubleLinkList;
    import common.data.structure.linkList.LinkNode;

    import flash.utils.Dictionary;

    /**
     * 支持多数据结构解析的配置
     */
    public class StructuredConfig
    {
        public function StructuredConfig()
        {
            super();
        }

        protected function parseXMLToStructure( data:XML, cls:Class, ds:* ):void
        {
            var dataList:XMLList = data.elements( data.children()[0].name() );
            var len:uint = dataList.length();
            var toStructureFunction:Function = toStructure;
            if ( ds is Dictionary ) toStructureFunction = toDictionary;
            else if ( ds is HashMap ) toStructureFunction = toHashMap;
            else if ( ds is Array ) toStructureFunction = toArray;
            else if ( ds is DoubleLinkList ) toStructureFunction = toLinkList;
            for ( var i:uint = 0; i < len; i++ )
            {
                var node:XML = XML( dataList[i] );
                var configInfo:BaseConfigInfo = new cls;
                configInfo.fillXml( node );
                toStructureFunction( configInfo, ds );
            }
        }

        private function toLinkList( configInfo:BaseConfigInfo, linkList:DoubleLinkList ):void
        {
            var node:LinkNode = new LinkNode();
            node.m_NodeData = configInfo;
            linkList.pushNode( node );
        }

        private function toArray( configInfo:BaseConfigInfo, array:Array ):void
        {
            array.push( configInfo );
        }

        private function toHashMap( configInfo:BaseConfigInfo, hashMap:HashMap ):void
        {
            hashMap.put( configInfo.getKey(), configInfo );
        }

        private function toDictionary( configInfo:BaseConfigInfo, dictionary:Dictionary ):void
        {
            dictionary[configInfo.getKey()] = configInfo;
        }

        protected function toStructure( configInfo:BaseConfigInfo, ds:* ):void
        {
            throw new Error( "请用子类实现具体的数据结构来解析配置。" );
        }
    }
}
