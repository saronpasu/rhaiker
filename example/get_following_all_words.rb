#!ruby -Ku
require 'rhaiker'

# first you create Rhaiker instance.
@accessor = Rhaiker.new

# optional settings
@accessor.user_agent = 'your user_agent'

# access to Hateha::Haiku::API
my_following_words = @accessor.keywords('your hatena_id')

# filltering only title.
mywords = my_following_words.collect{|myword|
  myword[:title]
}

# filltering related-words only title.
related_words = my_following_words.collect{|myword|
   myword[:related_keywords].collect{|related_word|
     related_word[:title]
   }
}

# following-words and related-words.
all_words = mywords + related_words
all_words = all_words.uniq


