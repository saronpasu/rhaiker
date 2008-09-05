#!ruby -Ku
require 'rhaiker'

# first you create Rhaiker instance.
@accessor = Rhaiker.new

# if you want update when must settings.
@accessor.user_id = 'your hatena_id'
@accessor.api_key = 'fhrIEhelagF' #@h.hatena.ne.jp

# optional settings
@accessor.user_agent = 'your user_agent'
@accessor.source = 'your source keyword'

# input status message in UTF-8.
params = {:status => 'Test Update.'}

# status update send Hatena::Haiku::API.
@accessor.status_update(params)


