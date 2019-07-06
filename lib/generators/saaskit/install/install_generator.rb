require 'rails/generators/base'

module Saaskit
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def add_gems_to_gemfile
        gem 'meta-tags', '~> 2.11', '>= 2.11.1'
        gem 'gibbon', '~> 3.2'

        gem_group :development, :test do
          gem 'standard', '~> 0.0.40'
        end

        gem_group :development do
          gem 'eefgilm', '~> 1.2', '>= 1.2.1'
        end
      end

      def bundle_install
        Bundler.with_clean_env do
          run "bundle install"
        end
      end

      def organizing_gemfile
        run "eefgilm"
      end

      def copy_credentials_sample
        copy_file "config/credentials.yml.sample"
      end

      def enable_require_master_key_in_production
        uncomment_lines "config/environments/production.rb",
                        /config.require_master_key = true/
      end

      def install_stimulus
        run "yarn add stimulus"
        copy_file "app/javascript/controllers/index.js"
        insert_into_file "app/javascript/packs/application.js", after: "require(\"channels\")\n" do
          <<~CODE
            // Tell webpacker to require stimulus
            require("stimulus")
            import 'controllers'
          CODE
        end
      end

      def install_notice_controller
        copy_file "app/javascript/controllers/notice_controller.js"
      end

      def install_typed_controller
        run "yarn add typed.js"
        copy_file "app/javascript/controllers/typed_controller.js"
      end

      def install_reveal_controller
        copy_file "app/javascript/controllers/reveal_controller.js"
      end

      def install_smooth_scroll_controller
        run "yarn add smooth-scroll"
        copy_file "app/javascript/controllers/smooth_scroll_controller.js"
      end

      def install_aos_controller
        run "yarn add aos@next"
        copy_file "app/javascript/controllers/aos_controller.js"
      end

      def install_noty_controller
        run "yarn add noty"
        copy_file "app/javascript/controllers/noty_controller.js"
      end

      def install_tailwindcss
        run "yarn add tailwindcss"
        run "yarn add tailwindcss-transitions"
        run "yarn add tailwindcss-gradients"
        run "yarn add tailwindcss-pseudo"
        copy_file "app/javascript/stylesheets/application.scss"
        append_to_file "app/javascript/packs/application.js" do
          <<~CODE
            require("stylesheets/application.scss")
          CODE
        end
        insert_into_file "app/views/layouts/application.html.erb", after: "<%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>\n" do
          <<~CODE
            <%= stylesheet_pack_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
          CODE
        end
        copy_file "app/javascript/stylesheets/tailwind.config.js"
        insert_into_file "postcss.config.js", after: "plugins: [\n" do
          <<~CODE
            require('tailwindcss')('./app/javascript/stylesheets/tailwind.config.js'),
            require('autoprefixer'),
          CODE
        end
      end

      def install_purgecss
        run "yarn add glob-all"
        run "yarn add path"
        run "yarn add purgecss-webpack-plugin"
        copy_file "config/webpack/plugins/purgecss-webpack-plugin.js"
        insert_into_file "config/webpack/production.js", after: "const environment = require('./environment')\n" do
          <<~CODE
            environment.plugins.append('PurgecssWebpackPlugin', require('./plugins/purgecss-webpack-plugin'))
          CODE
        end
      end

      def install_images
        gsub_file "app/javascript/packs/application.js",
                  /\/\/ const images/, "const images"
        gsub_file "app/javascript/packs/application.js",
                  /\/\/ const imagePath/, "const imagePath"

        copy_file "app/javascript/images/logo_color_horizontal.svg"
        copy_file "app/javascript/images/logo_color_stacked.svg"
        copy_file "app/javascript/images/logo_color_symbol.svg"
        copy_file "app/javascript/images/logo_white_horizontal.svg"
        copy_file "app/javascript/images/logo_white_stacked.svg"
        copy_file "app/javascript/images/logo_white_symbol.svg"
        copy_file "app/javascript/images/tgav_logo_white_symbol.svg"
      end

      def create_application_controller
        copy_file "app/controllers/application_controller.rb", force: true
      end

      def create_application_layouts
        copy_file "app/views/shared/_head.html.erb"
        copy_file "app/views/shared/_notices.html.erb"
        copy_file "app/views/shared/_navbar.html.erb"
        copy_file "app/views/shared/_footer.html.erb"
        copy_file "app/views/layouts/application.html.erb", force: true
        copy_file "app/views/layouts/land.html.erb"
      end

      def create_application_helpers
        copy_file "app/helpers/application_helper.rb", force: true
      end

      def install_meta_tags
        copy_file "config/initializers/meta_tags.rb"
        copy_file "app/helpers/meta_tags_helper.rb"
      end

      def install_pages
        copy_file "app/javascript/images/pablo-done.png"
        copy_file "app/javascript/images/github.svg"
        copy_file "app/javascript/images/rails.svg"
        copy_file "app/javascript/images/webpack.svg"
        copy_file "app/javascript/images/stimulus.svg"
        copy_file "app/javascript/images/tailwind.svg"
        copy_file "app/javascript/images/layout-top-panel-6.svg"
        copy_file "app/javascript/images/shield-protected.svg"
        copy_file "app/javascript/images/facebook.svg"
        copy_file "app/javascript/images/user.svg"
        copy_file "app/javascript/images/layout-left-panel-1.svg"
        copy_file "app/javascript/images/right-circle.svg"
        copy_file "app/javascript/images/group.svg"
        copy_file "app/javascript/images/shield-check.svg"
        copy_file "app/javascript/images/repeat.svg"
        copy_file "app/javascript/images/credit-card.svg"
        copy_file "app/javascript/images/sale-2.svg"
        copy_file "app/javascript/images/file.svg"
        copy_file "app/javascript/images/stripe.svg"
        copy_file "app/javascript/images/paypal.svg"
        copy_file "app/javascript/images/outlet.svg"
        copy_file "app/javascript/images/notifications-1.svg"
        copy_file "app/javascript/images/address-book-2.svg"
        copy_file "app/javascript/images/mail-opened.svg"
        copy_file "app/javascript/images/sending-mail.svg"
        copy_file "app/javascript/images/chart-bar-1.svg"
        copy_file "app/javascript/images/selected-file.svg"
        copy_file "app/javascript/images/display-1.svg"
        copy_file "app/javascript/images/cloud-upload.svg"
        copy_file "app/forms/newsletter_form.rb"
        copy_file "app/adapters/mailchimp/base_adapter.rb"
        copy_file "app/models/concerns/coming_soon_pending_subscribable.rb"
        directory "app/views/pages"
        copy_file "app/controllers/pages_controller.rb"
        route "root to: 'pages#home'"
        route "post '/subscribe', to: 'pages#subscribe'"
      end

      def create_and_migrate_db
        rails_command "db:create"
        rails_command "db:migrate"
      end

      def tidy_up_codebase
        run "bundle exec standardrb --fix"
      end

      def display_readme_in_terminal
        readme "README"
      end
    end
  end
end
