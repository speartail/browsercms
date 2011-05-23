module Cms

  # All BrowserCMS modules will:
  # 1. Add app/portlets to the loadpath
  # 2. Serve static assets from their public directory.
  module Module


    def self.included(base)
      # Make sure class in app/portlets are in the load_path
      portlets_dir = File.join("..", "..", "app", "portlets")
      base.config.autoload_paths << portlets_dir

      base.initializer "browsercms.enable_serving_static_assets" do |app|
        # Ensures it is loaded earlier, to avoid blank assets problem listed here: http://jonswope.com/2010/07/25/rails-3-engines-plugins-and-static-assets/
        app.middleware.insert_before ::Rack::Lock, ::ActionDispatch::Static, "#{root}/public"
      end

    end


  end
end