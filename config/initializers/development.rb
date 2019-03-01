Rails.application.configure do
  if Rails.env.development?
    config.after_initialize do
      Bullet.enable = true
      # Bullet.alert = true
      Bullet.bullet_logger = true
      Bullet.console = true
      Bullet.rails_logger = true
      Bullet.add_footer = true
      # Bullet.stacktrace_includes = [ 'your_gem', 'your_middleware' ]
      # Bullet.stacktrace_excludes = [ 'their_gem', 'their_middleware', ['my_file.rb', 'my_method'], ['my_file.rb', 16..20] ]
    end
  end
end
