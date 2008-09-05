#!ruby -Ku
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rhaiker/utils'
require 'rhaiker/xml_parser'

=begin rdoc
Rhaiker is Hatena::Haiku::API ruby binding.
Use only Pure Ruby library.

see exsample/*.rb

please show Hatena::Haiku::API::Guide[http://h.hatena.ne.jp/api]

=end
class Rhaiker
  # HTTP-HEADER 'User-Agent' String
  attr_accessor :user_agent
  # Hatena::UserID String
  attr_accessor :user_id
  # Hatena::Haiku::API API-Key String
  attr_accessor :api_key
  # Hatena::Haiku::API ClientSource String
  attr_accessor :source

  # Hatena::Haiku::API BaseURL
  BaseAddress = 'http://h.hatena.ne.jp/api/'
  # Utilities.
  include Utils
  # Customized XML Parser for
  # Hatena::Haiku::API[http://h.hatena.ne.jp/api]
  include XML_Parser

  def initialize #:nodoc:
    @user_agent = 'rhaiker'
    @source = 'rhaiker'
  end

=begin rdoc
Description::
  get public-timeline from
  Hatena::Haiku::API[http://h.hatena.ne.jp/api#statuses-public_timeline]

Return::
  timeline ([{:id => 12345, ...}, ...]) or false

RelatedMethods::
  Utils#create_uri,
  Utils#create_request,
  Utils#http_access,
  XML_Parser#parse_timeline
=end
  def get_public_timeline
    uri = create_uri(
      BaseAddress + 
      'statuses/public_timeline.xml'
    )
    request = create_request(:get, uri)
    document = http_access(uri, request)
    if document
      return parse_timeline(document)
    else
      return false
    end
  end

=begin rdoc
Description::
  get friends_timeline from
  Hatena::Haiku::API[http://h.hatena.ne.jp/api#statuses-friends_timeline]

Params::
  user_id (target user_id) [,
  options ({:count => 20, [...]})]

Return::
  timeline ([{:id => 12345, ...}, ...]) or false

RelatedMethods::
  Utils#create_uri,
  Utils#create_request,
  Utils#parse_options,
  Utils#http_access,
  XML_Parser#parse_timeline,
=end
  def get_friends_timeline(user_id = nil, options = nil)
    uri_base = BaseAddress + 'statuses/friends_timeline'
    uri_base += user_id ? "/#{user_id}.xml" : '.xml'
    uri_base += parse_options(options) if options
    uri = create_uri(uri_base)
    request = create_request(:get, uri, user_id.nil?)
    document = http_access(uri, request)
    if document
      return parse_timeline(document)
    else
      return false
    end
  end

=begin rdoc
Description::
  get user_timeline from
  Hatena::Haiku::API[http://h.hatena.ne.jp/api#statuses-user_timeline]

Params::
  user_id (target user_id) [,
  options ({:count => 20, [...]})]

Return:: 
  timeline ([{:id => 12345, ...}, ...]) or false

RelatedMethods::
  Utils#create_uri,
  Utils#create_request,
  Utils#http_access,
  Utils#parse_options,
  XML_Parser#parse_timeline,
=end
  def get_user_timeline(user_id = nil, options = nil)
    uri_base = BaseAddress + 'statuses/user_timeline'
    uri_base += user_id ? "/#{user_id}.xml" : '.xml'
    uri_base += parse_options(options) if options
    uri = create_uri(uri_base)
    request = create_request(:get, uri, user_id.nil?)
    document = http_access(uri, request)
    if document
      return parse_timeline(document)
    else
      return false
    end
  end

=begin rdoc
Description::
  get keyword_timeline from
  Hatena::Haiku::API[http://h.hatena.ne.jp/api#statuses-keyword_timeline]

Params::
  keywrod (target keyword) [,
  options ({:count => 20, [...]})]

Return::
  timeline ([{:id => 12345, ...}, ...]) or false

RelatedMethods::
  Utils#create_uri,
  Utils#create_request,
  Utils#parse_options,
  Utils#http_access,
  XML_Parser#parse_timeline
=end
  def get_keyword_timeline(keyword, options = nil)
    uri_base = BaseAddress +
      'statuses/keyword_timeline/' +
      keyword + '.xml'
    uri_base += parse_options(options) if options
    uri = create_uri(uri_base)
    request = create_request(:get, uri)
    document = http_access(uri, request)
    if document
      return parse_timeline(document)
    else
      return false
    end
  end

=begin rdoc
Description::
  get timeline(include picture-url) from
  Hatena::Haiku::API[http://h.hatena.ne.jp/api#statuses-album]

Params::
  keyword (target keyword)

Return::
  timeline ([{:id => 12345, ...}, ...]) or false

RelatedMethods::
  Utils#create_uri,
  Utils#create_request,
  Utils#parse_options,
  Utils#http_access,
  XML_Parser#parse_timeline
=end
  def get_album(keyword = nil)
    uri_base = BaseAddress + 'statuses/album'
    uri_base += keyword ? "/#{keyword}.xml" : '.xml'
    uri = create_uri(uri_base)
    request = create_request(:get, uri)
    document = http_access(uri, request)
    if document
      return parse_timeline(document)
    else
      return false
    end
  end

=begin rdoc
Description::
  get status from
  Hatena::Haiku::API[http://h.hatena.ne.jp/api#statuses-show]

Params::
  status_id (target status_id)

Return::
  status ({:id => 12345, ...}) or false

RelatedMethods::
  Utils#create_uri,
  Utils#create_request,
  Utils#http_access,
  XML_Parser#parse_status
=end
  def get_status(status_id)
    uri = create_uri(
      BaseAddress +
      'statuses/show/' +
      status_id.to_s + '.xml'
    )
    request = create_request(:get, uri)
    document = http_access(uri, request)
    if document
      return parse_status(document.root)
    else
      return false
    end
  end

=begin rdoc
Description::
  get friends from
  Hatena::Haiku::API[http://h.hatena.ne.jp/api#statuses-friends]

Params::
  user_id (target user_id)

Return::
  users ([{:name => 'hoge', ...}, ...]) or false

RelatedMethods::
  Utils#create_uri,
  Utils#create_request,
  Utils#http_access,
  XML_Parser#parse_users
=end
  def get_friends(user_id = nil)
    uri_base = BaseAddress + 'statuses/friends'
    uri_base += user_id ? "/#{user_id}.xml" : '.xml'
    uri = create_uri(uri_base)
    request = create_request(:get, uri, user_id.nil?)
    document = http_access(uri, request)
    if document
      return parse_users(document)
    else
      return false
    end
  end

=begin rdoc
Description::
  get followers from
  Hatena::Haiku::API[http://h.hatena.ne.jp/api#statuses-followers]

Params::
  user_id (target user_id)

Return::
  users ([{:name => 'hoge', ...}, ...]) or false

RelatedMethods::
  Utils#create_uri,
  Utils#create_request,
  Utils#http_access,
  XML_Parser#parse_users
=end
  def get_followers(user_id = nil)
    uri_base = BaseAddress + 'statuses/followers'
    uri_base += user_id ? "/#{user_id}.xml" : '.xml'
    uri = create_uri(uri_base)
    request = create_request(:get, uri, user_id.nil?)
    document = http_access(uri, request)
    if document
      return parse_users(document)
    else
      return false
    end
  end

=begin rdoc
Description::
  get friend from
  Hatena::Haiku::API[http://h.hatena.ne.jp/api#friendship-show]

Params::
  user_id (target user_id)

Return::
  user ({:name => 'hoge', ...}) or false

RelatedMethods::
  Utils#create_uri,
  Utils#create_request,
  Utils#http_access,
  XML_Parser#parse_user
=end
  def get_friend(user_id)
    uri = create_uri(
      BaseAddress +
      'friendships/show/' +
      user_id + '.xml'
    )
    request = create_request(:get, uri)
    document = http_access(uri, request)
    if document
      return parse_user(document.root)
    else
      return false
    end
  end

=begin rdoc
Description::
  get hot-keyword from
  Hatena::Haiku::API[http://h.hatena.ne.jp/api#keywords-hot]

Return::
  keywords ([{:title => 'hoge', ...}, ...]) or false

RelatedMethods::
  Utils#create_uri,
  Utils#create_request,
  Utils#http_access,
  XML_Parser#parse_keywords
=end
  def get_hot_keywords
    uri = create_uri(BaseAddress + 'keywords/hot.xml')
    request = create_request(:get, uri)
    document = http_access(uri, request)
    if document
      return parse_keywords(document)
    else
      return false
    end
  end

=begin rdoc
Description::
  get keyword-list from
  Hatena::Haiku::API[http://h.hatena.ne.jp/api#keywords-list]

Params::
  options => {:page => pagenum}

Return::
  keywords ([{:title => 'hoge', ...}, ...]) or false

RelatedMethods::
  Utils#create_uri,
  Utils#create_request,
  Utils#parse_options,
  Utils#http_access,
  XML_Parser#parse_keywords
=end
  def get_keyword_list(options = nil)
    uri_base = BaseAddress + 'keywords/list.xml'
    uri_base += parse_options(options) if options
    uri = create_uri(uri_base)
    request = create_request(:get, uri)
    document = http_access(uri, request)
    if document
      return parse_keywords(document)
    else
      return false
    end
  end

=begin rdoc
Description::
  get following keywords from
  Hatena::Haiku::API[http://h.hatena.ne.jp/api#statuses-keywords]

Params::
  user_id (target user_id)

Return::
  keywords ([{:title => 'hoge', ...}, ...]) or false

RelatedMethods::
  Utils#create_uri
  Utils#create_request
  Utils#http_access
  XML_Parser#parse_keywords
=end
  def get_keywords(user_id = nil)
    uri_base = BaseAddress + 'statuses/keywrods'
    uri_base += user_id ? "/#{user_id}.xml" : '.xml'
    uri = create_uri(uri_base)
    request = create_request(:get, uri, user_id.nil?)
    document = http_access(uri, request)
    if document
      return parse_timeline(document)
    else
      return false
    end
  end

=begin rdoc
Description::
  get keyword from
  Hatena::Haiku::API[http://h.hatena.ne.jp/api#keywords-show]

Params::
  keyword (target keyword)

Return::
  keyword ({:title => 'hoge', ...}) or false

RelatedMethods::
  Utils#create_uri,
  Utils#create_request,
  Utils#http_access,
  XML_Parser#parse_keyword
=end
  def get_keyword(keyword)
    uri = create_uri(
      BaseAddress +
      'keywords/show/' +
      keyword + 'xml'
    )
    request = create_request(:get, uri)
    document = http_access(uri, request)
    if document
      return parse_keyword(document.root)
    else
      return false
    end
  end

=begin rdoc
Description::
  update status for
  Hatena::Haiku::API[http://h.hatena.ne.jp/api#statuses-update]

Params::
  options ({:status => 'hoge', ...}]

Return::
  status ({:text => 'hoge', ...}) or false

RelatedMethods::
  Utils#create_uri,
  Utils#create_request,
  Utils#parse_options,
  Utils#http_access,
  XML_Parser#parse_status

Notes::
  Still does not support of 'Upload Image File'
=end
  def status_update(options)
    uri_base = BaseAddress + 'statuses/update.xml'
    uri_base += parse_options(options)
    uri_base += '&source=' + @source
    uri = create_uri(uri_base)
    request = create_request(:post, uri, true)
    document = http_access(uri, request)
    if document
      return parse_status(document.root)
    else
      return false
    end
  end

=begin rdoc
Description::
  delete status for
  Hatena::Haiku::API[http://h.hatena.ne.jp/api#statuses-destroy]

Params::
  status_id (target status_id)

Return::
  status ({:text => 'hoge', ...}) or false

RelationMethods::
  create_uri,
  create_request,
  http_access,
  parse_status
=end
  def status_destroy(status_id)
    uri = create_uri(
      BaseAddress +
      'statuses/status/destroy/' +
      status_id.to_s + '.xml'
    )
    request = create_request(:post, uri, true)
    document = http_access(uri, request)
    if document
      return parse_status(document.root)
    else
      return false
    end
  end

=begin rdoc
Description::
  friend following for
  Hatena::Haiku::API[http://h.hatena.ne.jp/api#friendship-create]

Params::
  user_id (target user_id)

Return::
  user ({:id => 'hoge', ...}) or false

RelatedMethods::
  Utils#create_uri,
  Utils#create_request,
  Utils#http_access,
  XML_Parser#parse_user
=end
  def friendship_create(user_id)
    uri = create_uri(
      BaseAddress +
      'friendships/create/' +
      user_id + '.xml'
    )
    request = create_request(:post, uri, true)
    document = http_access(uri, request)
    if document
      return parse_user(document.root)
    else
      return false
    end
  end

=begin rdoc
Description::
  friend unfollowing for
  Hatena::Haiku::API[http://h.hatena.ne.jp/api#friendship-destroy]

Params::
  user_id (target user_id)

Return::
  user ({:id => 'hoge', ...}) or false

RelatedMethods::
  Utils#create_uri,
  Utils#create_request,
  Utils#http_access,
  XML_Parser#parse_user
=end
  def friendship_destroy(user_id)
    uri = create_uri(
      BaseAddress +
      'friendships/destroy/' +
      user_id + '.xml'
    )
    request = create_request(:post, uri, true)
    document = http_access(uri, request)
    if document
      return parse_user(document.root)
    else
      return false
    end
  end

=begin rdoc
Description::
  add star for
  Hatena::Haiku::API[http://h.hatena.ne.jp/api#favorites-create]

Params::
  status_id (target status_id)

Return::
  status ({:text => 'hoge', ...}) or false

RelatedMethods::
  Utils#create_uri,
  Utils#create_request,
  Utils#http_access,
  XML_Parser#parse_status
=end
  def favorites_create(status_id)
    uri = create_uri(
      BaseAddress +
      'favorites/create/' +
      status_id.to_s + '.xml'
    )
    request = create_request(:post, uri, true)
    document = http_access(uri, request)
    if document
      return parse_status(document.root)
    else
      return false
    end
  end

=begin rdoc
Description::
  delete star for
  Hatena::Haiku::API[http://h.hatena.ne.jp/api#favorites-destroy]

Params::
  status_id (target status_id)

Return::
  status {:text => 'hoge', ...}) or false

RelatedMethods::
  Utils#create_uri,
  Utils#create_request,
  Utils#http_access,
  XML_Parser#parse_status
=end
  def favorites_destroy(status_id)
    uri = create_uri(
      BaseAddress +
      'favorites/destroy/' +
      status_id.to_s + '.xml'
    )
    request = create_request(:post, uri, true)
    document = http_access(uri, request)
    if document
      return parse_status(document.root)
    else
      return false
    end
  end

=begin rdoc
Description::
  following keyword for
  Hatena::Haiku::API[http://h.hatena.ne.jp/api#keywords-create]

Params::
  keyword (target keyword)

Return::
  keyword ({:title => 'hoge', ...} or false

RelatedMethods::
  Utils#create_uri,
  Utils#create_request,
  Utils#http_access,
  XML_Parser#parse_keyword
=end
  def keyword_create(keyword)
    uri = create_uri(
      BaseAddress +
      'keywords/create/' +
      keyword + '.xml'
    )
    request = create_request(:post, uri, true)
    document = http_access(uri, request)
    if document
      return parse_keyword(document.root)
    else
      return false
    end
  end

=begin rdoc
Description::
  unfollowing keyword for
  Hatena::Haiku::API[http://h.hatena.ne.jp/api#keywords-destroy]

Params::
  keyword (target keyword)

Return::
  keyword ({:title => 'hoge', ...}) or false

RelatedMethods::
  Utils#create_uri,
  Utils#create_request,
  Utils#http_access,
  XML_Parser#parse_keyword
=end
  def keyword_destroy(keyword)
    uri = create_uri(
      BaseAddress +
      'keywords/destroy/' +
      keyword + '.xml'
    )
    request = create_request(:post, uri, true)
    document = http_access(uri, request)
    if document
      return parse_keyword(document.root)
    else
      return false
    end
  end

=begin rdoc
Description::
  create relation word1 and word2 for
  Hatena::Haiku::API[http://h.hatena.ne.jp/api#keywords-relation_create]

Params::
  word1 (target word),
  word2 (target word)

Return::
  keyword ({:title => 'hoge', ...}) or false

RelatedMethods::
  Utils#create_uri,
  Utils#create_request,
  Utils#http_access,
  XML_Parser#parse_keyword
=end
  def keyword_relation_create(word1, word2)
    uri = create_uri(
      BaseAddress +
      'keywords/relation/create.xml' +
      '?word1=' + word1 +
      '&word2=' + word2
    )
    request = create_request(:post, uri, true)
    document = http_access(uri, request)
    if document
      return parse_keyword(document.root)
    else
      return false
    end
  end

=begin rdoc
Description::
  delete relation word1 and word2 for
  Hatena::Haiku::API[http://h.hatena.ne.jp/api#keywords-relation_destroy]

Params::
  word1 (target word),
  word2 (rarget word)

Return::
  keyword ({:title => 'hoge', ...}) or false

RelatedMethods::
  Utils#create_uri,
  Utils#create_request,
  Utils#http_access,
  XML_Parser#parse_keyword
=end
  def keyword_relation_destroy(word1, word2)
    uri = create_uri(
      BaseAddress +
      'keywords/relation/destroy.xml' +
      '?word1=' + word1 +
      '&word2=' + word2
    )
    request = create_request(:post, uri, true)
    document = http_access(uri, request)
    if document
      return parse_keyword(document.root)
    else
      return false
    end
  end
end
