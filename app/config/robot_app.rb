require 'yaml'
require 'pry'
require 'pathname'
require 'rails'

project_root = Pathname.new(File.expand_path(File.join(File.basename(__FILE__), %w(..))))
require project_root.join('app/config/configuration.rb')
Dir[project_root.join('app/**/**/*.rb')].each{|f| require f}

module RobotApp

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration = Configuration.new
    yield(configuration)
    self.configuration.load_config
    p "Settings: #{self.configuration.instance_values}"
    self.configuration
  end

  def self.change_configure
    self.configuration = Configuration.new
    yield(configuration)
    self.configuration
  end

  def self.load_configure
    p 'Loading config Settings....'
    self.configuration.load_config
    self.configuration
  end

  def self.method_missing(m, *args, &block)
    self.configuration.instance_variable_get("@#{m}") if self.configuration.instance_variable_names.include?("@#{m}")
  end

end
