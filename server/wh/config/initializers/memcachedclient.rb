require 'memcache.rb'
    mcd_default_options = {
            :namespace => 'game:user',
            :memcache_server => 'localhost:11211'
    }

if (!$memcached)  
$memcached= MemCache.new(mcd_default_options[:memcache_server], mcd_default_options)
end