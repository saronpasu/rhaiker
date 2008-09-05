Gem::Specification.new do |s|
  s.name = %q{rhaiker}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["saronpasu"]
  s.date = %q{2008-09-06}
  s.description = %q{Hatena::Haiku::API ruby binding}
  s.email = ["jamneco@gmail.com"]
  s.extra_rdoc_files = ["History.ja.txt", "History.txt", "License.txt", "Manifest.txt", "README.ja.txt", "README.txt", "website/index.txt"]
  s.files = ["History.ja.txt", "History.txt", "License.txt", "Manifest.txt", "README.ja.txt", "README.txt", "Rakefile", "config/hoe.rb", "config/requirements.rb", "example/get_followers.rb", "example/get_following_all_words.rb", "example/get_hot_keywords.rb", "example/haiku_update.rb", "lib/rhaiker.rb", "lib/rhaiker/utils.rb", "lib/rhaiker/version.rb", "lib/rhaiker/xml_parser.rb", "script/console", "script/destroy", "script/generate", "script/txt2html", "setup.rb", "spec/rhaiker_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/deployment.rake", "tasks/environment.rake", "tasks/rspec.rake", "tasks/website.rake", "website/index.html", "website/index.txt", "website/javascripts/rounded_corners_lite.inc.js", "website/stylesheets/screen.css", "website/template.html.erb"]
  s.has_rdoc = true
  s.homepage = %q{http://rhaiker.rubyforge.org}
  s.post_install_message = %q{}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{rhaiker}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Hatena::Haiku::API ruby binding}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_development_dependency(%q<hoe>, [">= 1.7.0"])
    else
      s.add_dependency(%q<hoe>, [">= 1.7.0"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.7.0"])
  end
end
