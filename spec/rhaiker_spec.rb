require File.dirname(__FILE__) + '/spec_helper.rb'

describe Rhaiker, ' when first created' do

  before do
    @accessor = Rhaiker.new
  end

  it 'should be have a user_agent "rhaiker"' do
    @accessor.user_agent.should be_eql("rhaiker")
  end

  it 'should be have a source "rhaiker"' do
    @accessor.source.should be_eql("rhaiker")
  end

  it 'shoud not have a user_id' do
    @accessor.user_id.should be_nil
  end

  it 'should not have a api_key' do
    @accessor.api_key.should be_nil 
  end

  after do
    @accessor = nil
  end

end

describe Rhaiker::Utils, " when use" do
  before do
    @accessor = Rhaiker.new
    @accessor.user_id = 'saronpasu'
    @accessor.api_key = 'ar3hge2f'
  end

  it 'create_uri should be URI instance' do
    @accessor.create_uri(
      Rhaiker::BaseAddress +
      'statuses/public_timeline.xml'
    ).should be_a_kind_of(URI)
  end

  it 'create_request with type in :get should be Net::HTTP::Get instance' do
    uri = mock(:uri)
    uri.should_receive(:request_uri).and_return('text')
    @accessor.create_request(:get, uri).should be_a_kind_of(Net::HTTP::Get)
  end

  it 'create_request with type in :post should be Net::HTTP::Post instance' do
    uri = mock(:uri)
    uri.should_receive(:request_uri).and_return('text')
    @accessor.create_request(:post, uri).should be_a_kind_of(Net::HTTP::Post)
  end

  it 'create_request instance should have basic_auth' do
    uri = mock(:uri)
    uri.should_receive(:request_uri).and_return('text')
    @accessor.create_request(
      :get, uri, true
    )['Authorization'].should be_eql(
      "Basic c2Fyb25wYXN1OmFyM2hnZTJm"
    )
  end

   it 'http_access and return should be REXML::Document' do
     uri = mock('uri')
     request = mock('request')
     @accessor.should_receive(:http_access).and_return(REXML::Document.new('<a/>'))
     @accessor.http_access(uri, request).should be_a_kind_of(REXML::Document)
   end

   it 'parse_options and return parsed options' do
     @accessor.parse_options({:status=>'hello',:page=>2}).should be_eql('?status=hello&page=2')
   end

  after do
    @accessor = nil
  end
end

describe Rhaiker::XML_Parser, 'when use' do
  before do
    @accessor = Rhaiker.new
    @timeline = REXML::Document.new(
      '<statuses>
        <status>
          <id>1234567890</id>
          <created_at>2008-09-04T04:26:06Z</created_at>
          <text>ほげ</text>
          <keyword>ふが</keyword>
          <in_reply_to_status_id>1234567890</in_reply_to_status_id>
          <in_reply_to_user_id>saronpasu</in_reply_to_user_id>
          <favorited>0</favorited>
          <link>http://h.hatena.ne.jp/saronpasu/1234567890</link>
          <source>web</source>
          <replies>
            <id>1234567890</id>
            <created_at>2008-09-04T04:26:06Z</created_at>
            <text>ほげ</text>
            <keyword>ふが</keyword>
            <favorited>0</favorited>
            <link>http://h.hatena.ne.jp/saronpasu/1234567890</link>
            <source>web</source>
            <user>  
              <id>saronpasu</id>
              <name>saronpasu</name>
              <screen_name>saronpasu</screen_name>
              <url>http://h.hatena.ne.jp/saronpasu/</url>
              <profile_image_url>http://www.hatena.ne.jp/sa/saronpasu/profile.gif</profile_image_url>
              <followers_count>0</followers_count>
            </user>
          </replies>
          <user>
            <id>saronpasu</id>
            <name>saronpasu</name>
            <screen_name>saronpasu</screen_name>
            <url>http://h.hatena.ne.jp/saronpasu/</url>
            <profile_image_url>http://www.hatena.ne.jp/sa/saronpasu/profile.gif</profile_image_url>
            <followers_count>0</followers_count>
          </user>
        </status>
      </statuses>'
    )
    @status = REXML::Document.new('
      <status>
        <id>1234567890</id>
        <created_at>2008-09-04T04:26:06Z</created_at>
        <text>ほげ</text>
        <keyword>ふが</keyword>
        <in_reply_to_status_id/>
        <in_reply_to_user_id/>
        <favorited>0</favorited>
        <link>http://h.hatena.ne.jp/saronpasu/1234567890</link>
        <source>web</source>
        <user>
          <id>saronpasu</id>
          <name>saronpasu</name>
          <screen_name>saronpasu</screen_name>
          <url>http://h.hatena.ne.jp/saronpasu/</url>
          <profile_image_url>http://www.hatena.ne.jp/sa/saronpasu/profile.gif</profile_image_url>
          <followers_count>0</followers_count>
        </user>
      </status>'
    ).root
    @users = REXML::Document.new(
      '<users>
        <user>
          <id>saronpasu</id>
          <name>saronpasu</name>
          <screen_name>saronpasu</screen_name>
          <url>http://h.hatena.ne.jp/saronpasu/</url>
          <followers_count>0</followers_count>
          <profile_image_url>http://www.hatena.ne.jp/sa/saronpasu/profile.gif</profile_image_url>
        </user>
      </users>'
    )
   @user = REXML::Document.new(
     '<user>
       <id>saronpasu</id>
       <name>saronpasu</name>
       <screen_name>saronpasu</screen_name>
       <url>http://h.hatena.ne.jp/saronpasu/</url>
       <followers_count>0</followers_count>
       <profile_image_url>http://www.hatena.ne.jp/sa/saronpasu/profile.gif</profile_image_url>
     </user>'
   ).root
   @keywords = REXML::Document.new(
     '<keywords>
       <keyword>
         <title>ほげほげ</title>
         <link>http://h.hatena.ne.jp/keyword/hogehoge</link>
         <entry_count>0</entry_count>
         <followers_count>0</followers_count>
         <related_words>ふがふが</related_words>
       </keyword>
     </keywords>'
   )
   @keyword = REXML::Document.new(
     '<keyword>
       <title>ほげほげ</title>
       <link>http://h.hatena.ne.jp/keyword/hogehoge</link>
       <entry_count>0</entry_count>
       <followers_count>0</followers_count>
       <related_words>ふがふが</related_words>
      </keyword>'
   ).root
  end

  it 'parse_timeline and return Hash in Array Data' do
    @accessor.parse_timeline(@timeline).should be_a_kind_of(Array)
    @accessor.parse_timeline(@timeline).first.should be_a_kind_of(Hash)
  end

  describe 'parse_timeline result' do
    before do
      @result = @accessor.parse_timeline(@timeline)
    end

    it 'have status id' do
      @result.first.should have_key(:id)
    end
    it 'have status text' do
      @result.first.should have_key(:text)
    end
    it 'have status source' do
      @result.first.should have_key(:source)
    end
    it 'have status favorited' do
      @result.first.should have_key(:favorited)
    end
    it 'have status link' do
      @result.first.should have_key(:link)
    end
    it 'have user' do
      @result.first.should have_key(:user)
    end
    it 'have replies' do
      @result.first.should have_key(:replies)
    end
    it 'have in_reply_to' do
      @result.first.should have_key(:in_reply_to)
    end

    after do
      @result = nil
    end
  end

  it 'parse_status and return Hash Data' do
    @accessor.parse_status(@status).should be_a_kind_of(Hash)
  end

  it 'parse_users and return Hash in Array Data' do
    @accessor.parse_users(@users).should be_a_kind_of(Array)
    @accessor.parse_users(@users).first.should be_a_kind_of(Hash)
  end

  describe 'parse_users result' do
    before do
      @result = @accessor.parse_users(@users)
    end

    it 'have user id' do
      @result.first.should have_key(:id)
    end
    it 'have user name' do
      @result.first.should have_key(:name)
    end
    it 'have user screen_name' do
      @result.first.should have_key(:screen_name)
    end
    it 'have user url' do
      @result.first.should have_key(:url)
    end
    it 'have user followers_count' do
      @result.first.should have_key(:followers_count)
    end
    it 'have user profile_image_url' do
      @result.first.should have_key(:profile_image_url)
    end

    after do
      @result = nil
    end
  end

  it 'parse_user and return Hash Data' do
    @accessor.parse_user(@user).should be_a_kind_of(Hash)
  end

  it 'parse_keywords and return Hash in Array Data' do
    @accessor.parse_keywords(@keywords).should be_a_kind_of(Array)
    @accessor.parse_keywords(@keywords).first.should be_a_kind_of(Hash)
  end

  describe 'parse_keywords result' do
    before do
      @result = @accessor.parse_keywords(@keywords)
    end

    it 'have keyword title' do
      @result.first.should have_key(:title)
    end
    it 'have keyword link' do
      @result.first.should have_key(:link)
    end
    it 'have keyword entry_count' do
      @result.first.should have_key(:entry_count)
    end
    it 'have keyword followers_count' do
      @result.first.should have_key(:followers_count)
    end
    it 'have keyword related_keywords' do
      @result.first.should have_key(:related_keywords)
    end

    after do
      @result = nil
    end
  end

  it 'parse_keyword and return Hash Data' do
    @accessor.parse_keyword(@keyword).should be_a_kind_of(Hash)
  end

  after do
    @accessor = nil
    @timeline = nil
    @status = nil
    @users = nil
    @user = nil
    @keywords = nil
    @keyword = nil
  end
end

