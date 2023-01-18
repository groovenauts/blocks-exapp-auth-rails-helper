# frozen_string_literal: true

require_relative "lib/blocks/exapp/auth/rails/helper/version"

Gem::Specification.new do |spec|
  spec.name = "blocks-exapp-auth-rails-helper"
  spec.version = Blocks::Exapp::Auth::Rails::Helper::VERSION
  spec.authors = ["Chikanaga Tomoyuki"]
  spec.email = ["t-chikanaga@groovenauts.jp"]

  spec.summary = "BLOCKS外部アプリ認証を利用するRails用ヘルパーモジュール"
  spec.description = "BLOCKS外部アプリ認証を利用するRails用ヘルパーモジュール"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["allowed_push_host"] = ""

  spec.metadata["source_code_uri"] = "https://github.com/groovenauts/blocks-exapp-auth-rails-helper"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "jwt"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
