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

      def install_third_party_packages
        run "yarn add typed.js"
        run "yarn add smooth-scroll"
        run "yarn add aos@next"
        run "yarn add noty"
      end

      def install_stimulus_controllers
        copy_file "app/javascript/controllers/notice_controller.js"
        copy_file "app/javascript/controllers/typed_controller.js"
        copy_file "app/javascript/controllers/reveal_controller.js"
        copy_file "app/javascript/controllers/smooth_scroll_controller.js"
        copy_file "app/javascript/controllers/aos_controller.js"
        copy_file "app/javascript/controllers/noty_controller.js"
      end

      def import_third_party_css_into_assets_pipeline
        remove_file "app/assets/stylesheets/application.css"
        copy_file "app/assets/stylesheets/application.scss"
      end

      def install_images
        gsub_file "app/javascript/packs/application.js",
                  /\/\/ const images/, "const images"
        gsub_file "app/javascript/packs/application.js",
                  /\/\/ const imagePath/, "const imagePath"
        directory "app/javascript/images"
      end

      def install_application_shared_and_layouts
        directory "app/views/shared"
        directory "app/views/layouts", force: true
      end

      def create_application_helpers
        copy_file "app/helpers/application_helper.rb", force: true
      end

      def install_meta_tags
        copy_file "config/initializers/meta_tags.rb"
        copy_file "app/helpers/meta_tags_helper.rb"
      end

      def create_application_controller
        copy_file "app/controllers/application_controller.rb", force: true
      end

      def install_pages
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
