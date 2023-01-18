# blocks-exapp-auth-rails-helper

BLOCKS外部アプリ認証と連係するためのRails用のヘルパーメソッドです。

## Installation

rubygems.org にはリリースしていないので Gemfile に GitHub リポジトリの参照を記述します

    gem "blocks-exapp-auth-rails-helper", git: "https://github.com/groovenauts/blocks-exapp-auth-rails-helper.git", tag: "v1"

## Usage

任意のコントローラーに `Blocks::Exapp::Auth::Rails::Helper` メソッドを include することで `blocks_exapp_authenticate` メソッドが利用可能になります。

ex)

```ruby
class ApplicationController < ActionController::Base
  include Blocks::Exapp::Auth::Rails::Helper

  before_action :blocks_exapp_authenticate

  rescue_from Blocks::Exapp::Auth::Rails::Helper::AuthenticationError, with: :blocks_auth_error

  def blocks_auth_error(exception=nil)
    render json: { error: exception&.message }, status: :unauthorized
  end
end
```

この例では magellan-console で認証エラーが発生した場合 `Blocks::Exapp::Auth::Rails::Helper::AuthenticationError` 例外が発生するので、
`rescue_from` で捕捉しています。

アクションで処理したい場合は around action フィルタを利用します。

ex) (認証失敗時にフィルタを止めず個別のアクションを実行したい場合)
```ruby
class ApplicationController < ActionController::Base
  include Blocks::Exapp::Auth::Rails::Helper

  acount_action :authenticate

  private def authenticate
    begin
      blocks_exapp_authenticate
    rescue Blocks::Exapp::Auth::Rails::Helper::AuthenticationError => e
      @error = e.message
    end
    yield
  end
end
```

外部アプリ認証のために必要なパラーメータは `Rails.application.config` で指定します。
たとえば以下のような `config/initializers/blocks_exapp_auth.rb` を作成します(この例では具体的な値は環境変数で渡します)。

```ruby
# freeze-string-literal: true

Rails.application.config.blocks_exapp_secret = ENV["MYAPP_BLOCKS_SECRET"] || ""
Rails.application.config.blocks_exapp_token = ENV["MYAPP_BLOCKS_TOKEN"] || ""
Rails.application.config.blocks_console_url = ENV["MYAPP_BLOCKS_CONSOLE_URL"]
```

