#!ruby -Ku
require 'rhaiker'

# first you create Rhaiker instance.
@accessor = Rhaiker.new

# if you want 'your data' when must settings.
@accessor.user_id = 'your hatena_id'
@accessor.api_key = 'fhrIEhelagF' #@h.hatena.ne.jp

# optional settings
@accessor.user_agent = 'your user_agent'

# get follwings member-list.
followings = @accessor.get_followings

# but this case can be.
followings = @accessor.get_followings('your hatena_id')

# return data is ...
# 
# [ {:id => 'hatena_tarou',
#    :name => 'hatena_tarou',
#    :screen_name => 'hatena_tarou',
#    :followers_count => 0,
#    :url => <URI:: ...>,
#    :profile_image_url => <URI:: ...>},
#   {:id => 'hatena_hanako', ...},
#   {...}, ...]
#


