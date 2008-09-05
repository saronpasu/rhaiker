#!ruby -Ku
require 'rexml/document'
require 'date'
require 'uri'

class Rhaiker

=begin rdoc
XML Parser Module for 
Hatena::Haiku::API[http://h.hatena.ne.jp/api] Response.
=end
  module XML_Parser

=begin rdoc
Description::
  XML-Document-Parse for timeline

Params::
  document (REXML::Document-Instance)

Return::
  [{:id => 12345, ...}, ...]

RelatedMethods::
  parse_status
=end
    def parse_timeline(document)
      document.elements.collect('//statuses/status'){|status|
        parse_status(status)
      }
    end

=begin rdoc
Description::
  XML-Element-Parse for status

Params::
  status (REXML::Element-Instance)

Return::
  {:id => 12345, ...}

RelatedMethods::
  parse_timeline,
  parse_user,
  parse_reply
=end
    def parse_status(status)
      result = {
        :id =>
          status.elements['id'].text.to_i,
        :text =>
          status.elements['text'].text,
        :link =>
          URI.parse(status.elements['link'].text),
        :created_at =>
          DateTime.parse(status.elements['created_at'].text),
        :favorited =>
          status.elements['favorited'].text.to_i,
        :source =>
          status.elements['source'].text,
        :user =>
          parse_user(status.elements['user'])
      }
      in_reply_to = {
        :in_reply_to => {
          :status_id =>
            status.elements['in_reply_to_status_id'].text.to_i,
          :user_id =>
            status.elements['in_reply_to_user_id'].text
        }
      } if status.elements['in_reply_to_status_id'].has_text?
      result.merge!(in_reply_to) if in_reply_to
      replies = status.elements.collect('replies'){|reply|
        parse_reply(reply)
      }
      result.merge!({:replies => replies}) unless replies.empty?
      return result
    end

=begin rdoc
Description::
  XML-Element-Parse for reply

Params::
  reply (REXML::Element-Instance)

Return::
  {:id => 12345, ...}

RelatedMethods::
  parse_status,
  parse_user
=end
    def parse_reply(reply)
      {
        :id =>
          reply.elements['id'].text.to_i,
        :created_at =>
          DateTime.parse(reply.elements['created_at'].text),
        :favorited =>
          reply.elements['favorited'].text.to_i,
        :source =>
          reply.elements['source'].text,
        :text =>
          reply.elements['text'].text,
        :user =>
          parse_user(reply.elements['user'])
      }
    end

=begin rdoc
Description::
  XML-Document-Parse for users

Params::
  users (REXML::Document-Insetance)

Return::
  [{:id => 'hoge', ...}, ...]

RelatedMethods::
  parse_user
=end
    def parse_users(document)
      document.elements.collect('//users/user'){|user|
        parse_user(user)
      }
    end

=begin rdoc
Description::
  XML-Element-Parse for user

Params::
  user (REXML::Element-Instance)

Return::
  {:id => 'hoge', ...}

RelatedMethods::
  parse_users,
  parse_status,
  parse_reply
=end
    def parse_user(user)
      {
        :id =>
          user.elements['id'].text,
        :name =>
          user.elements['name'].text,
        :screen_name =>
          user.elements['screen_name'].text,
        :followers_count =>
          user.elements['followers_count'].text.to_i,
        :url =>
          URI.parse(user.elements['url'].text),
        :profile_image_url =>
          URI.parse(user.elements['profile_image_url'].text)
      }
    end

=begin rdoc
Description::
  XML-Document-Parse for keywords

Params::
  document (REXML::Document-Instance)

Return::
  [{:title => 'hoge', ...}, ...]

RelatedMethods::
  parse_keyword
=end
    def parse_keywords(document)
      document.elements.collect('//keywords/keyword'){|keyword|
        parse_keyword(keyword)
      }
    end

=begin rdoc
Description::
  XML-Element-Parse for keyword

Params::
  keyword (REXML::Element-Instance)

Return::
  timeline ({:title => 'hoge', ...})

RelatedMethods::
  parse_keywords
=end
    def parse_keyword(keyword)
      {
        :title =>
          keyword.elements['title'].text,
        :entry_count =>
          keyword.elements['entry_count'].text.to_i,
        :followers_count =>
          keyword.elements['followers_count'].text.to_i,
        :link =>
          URI.parse(keyword.elements['link'].text),
        :related_keywords =>
          keyword.elements.to_a('related_keywords')
      }
    end
  end
end

