module EvilBlocks
  # Change Slim options to support @data-role shortcut.
  def self.install_to_slim!
    # Add @data-role alias to Slim.
    #
    # Copy from role-rails by Sasha Koss.
    # https://github.com/kossnocorp/role-rails
    shortcut = Slim::Parser.default_options[:shortcut]
    shortcut['@']  = { :attr =>  'data-role' }
    shortcut['@.'] = { :attr => ['data-role', 'class'] }
    Slim::Engine.default_options[:merge_attrs]['data-role'] = ' '
  end

  # Add assets paths to standalone Sprockets environment.
  def self.install(sprockets)
    sprockets.append_path(Pathname(__FILE__).dirname.join('assets/javascripts'))
  end

  if defined? ::Rails
    # Tell Ruby on Rails to add `evil-block.js` to Rails Admin load paths.
    class Engine < ::Rails::Engine
      initializer 'evil-front.slim' do
        EvilBlocks.install_to_slim! if defined?(Slim::Parser)
      end
    end
  end
end
