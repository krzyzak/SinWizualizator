class Image
  include ActiveModel::Validations
  extend ActiveModel::Naming

  attr_accessor :name
  attr_reader :exists
  @@base_dir = "/test"
  @@ext = "png"
  validate do |image|
    image.errors.add_to_base("Name can't be blank") if image.name.blank?
  end

  def initialize(name = nil, exists = false)
    @name = name
    @exists = exists
  end

  def persisted?
    @exists
  end

  def to_param
    @name if persisted?
  end

  def to_key
    [@name] if persisted?
  end

  def path
    "#{@@base_dir}/#{self.name}.#{@@ext}"
  end

  def save
    #TODO: implement image saving
    @exists = true
  end

  def self.find(name)
   Image.new(name, true) if File.exists?("#{@@base_dir}/#{name}.#{@@ext}")
  end

  def self.find_or_create(name)
    if File.exists?("#{@@base_dir}/#{name}.#{@@ext}")
      "#{@@base_dir}/#{name}.#{@@ext}"
    else
      @image = Image.new(name)
      @image.save
      @image
    end
  end
end