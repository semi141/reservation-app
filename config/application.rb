require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module ReservationApp
  class Application < Rails::Application

    config.load_defaults 7.2

    config.autoload_lib(ignore: %w[assets tasks])

    # ActiveStorage で MiniMagick を使う設定
    config.active_storage.variant_processor = :mini_magick

    # デフォルトのロケールを日本語に設定
    config.i18n.default_locale = :ja
  end
end
