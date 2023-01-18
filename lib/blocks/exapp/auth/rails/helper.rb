# frozen_string_literal: true

require_relative "helper/version"

module Blocks
  module Exapp
    module Auth
      module Rails
        module Helper
          class AuthenticationError < StandardError; end

          private def blocks_exapp_authenticate
            if session[:blocks_user_info]
              # do nothing
            elsif params[:data]
              secret = ::Rails.application.config.blocks_exapp_secret
              blocks_exapp_info = JWT.decode(Base64.decode64(params[:data]), secret, true)
              session[:blocks_user_info] = blocks_exapp_info[0]["user"]
            elsif params[:authenticate]
              raise AuthenticationError, Base64.urlsafe_decode64(params[:authenticate]).sub(/\ABearer\s*/, "")
            else
              token = ::Rails.application.config.blocks_exapp_token
              token = Base64.urlsafe_encode64(token)
              token = Base64.urlsafe_encode64(token)
              console_url = ::Rails.application.config.blocks_console_url || "https://console.magellanic-clouds.com/"
              redirect_url = request.url
              redirect_to "#{console_url}blocks/exapp/auth?redirect_to=#{URI.encode_www_form_component(redirect_url)}&authz=#{token}", allow_other_host: true
            end
          end
        end
      end
    end
  end
end
