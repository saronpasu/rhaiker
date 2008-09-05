#!ruby -Ku
require 'rhaiker'

# first you create Rhaiker instance.
@accessor = Rhaiker.new

# optional settings
@accessor.user_agent = 'your user_agent'

# access to Hateha::Haiku::API
hot_keywords = @accessor.get_hot_keywords

# short case.
# this code is get 'Hot Keywords' only tiltes.
hot_keyword_titles = Rhaiker.new.get_hot_keywords.collect{|keyword|keyword[:title]}


