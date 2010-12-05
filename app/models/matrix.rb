class Matrix
  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  extend ActiveModel::Naming

  attr_reader :attributes
  attribute_method_suffix ""
  attribute_method_suffix "="
  define_attribute_methods [:data, :output, :target]
  @@data = nil
  @@output = nil
  @target = nil
  def initialize(attributes)
    @attributes = attributes.with_indifferent_access
  end

  def self.init_files
    @@data = YAML::load( File.open(Rails.root.join('config', 'data.yml').to_s) )
    @@output = YAML::load( File.open(Rails.root.join('config', 'outputs.yml').to_s) )
    @@target = YAML::load( File.open(Rails.root.join('config', 'targets.yml').to_s) )
  end

  def self.find(id)
    raise "Id out of range" unless (0...5036).include?(id)
    self.init_files unless Rails.cache.exist?(:data)
    Matrix.new({:data => @@data[id].split(","), :output => @@output[id].split(","), :target => @@target[id].split(",") })
  end

  def passed?
    self.output == self.target
  end

  def persisted?
    false
  end

  def to_param
    self.file if persisted?
  end

  def to_key
    [self.file] if persisted?
  end

  protected
  def attribute(name)
    @attributes[name]
  end

  def attribute=(name, value)
    @attributes[name] = value
  end
end