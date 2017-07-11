-- | Includes a scribe that can be used to log structured, JSON log
-- messages to ElasticSearch. These logs can be explored easily using
-- <https://www.elastic.co/products/kibana kibana> or your tool of
-- choice.
--
-- == __Important Note on Index Settings__
--
-- 'defaultEsScribeCfg' inherits a set of default index settings from
-- the @bloodhound@ package. These settings at this time of writing
-- set the indices up to have 3 shards and 2 replicas. This is an
-- arguably reasonable default setting for production but may cause
-- problems for development. In development, your cluster may be
-- configured to seek a write quorum greater than 1. If you're running
-- ElasticSearch on a single node, this could cause your writes to
-- wait for a bit and then fail due to a lack of quorum. __For development, we recommend setting your replica count to 0 or modifying your write quorum settings__. For production, we recommend reading the
-- <https://www.elastic.co/guide/en/elasticsearch/guide/current/scale.html ElasticSearch Scaling Guide> and choosing the appropriate settings,
-- keeping in mind that you can chage replica counts on a live index
-- but that changing shard counts requires recreating the index.
module Katip.Scribes.ElasticSearch
    (-- * Building a scribe
      mkEsScribe
    -- * Scribe configuration
    , EsScribeSetupError(..)
    , EsQueueSize
    , mkEsQueueSize
    , EsPoolSize
    , mkEsPoolSize
    , EsScribeCfg
    , essRetryPolicy
    , essQueueSize
    , essPoolSize
    , essAnnotateTypes
    , essIndexSettings
    , essIndexSharding
    , IndexShardingPolicy(..)
    , IndexNameSegment(..)
    , defaultEsScribeCfg
    , defaultEsScribeCfgV1
    , defaultEsScribeCfgV5
    -- * Utilities
    , mkDocId
    , module Katip.Scribes.ElasticSearch.Annotations
    , roundToSunday
    ) where


-------------------------------------------------------------------------------
import           Katip.Scribes.ElasticSearch.Annotations
import           Katip.Scribes.ElasticSearch.Internal
-------------------------------------------------------------------------------
