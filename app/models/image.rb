require 'RMagick'
class Image
  include ActiveModel::Validations
  extend ActiveModel::Naming

  attr_accessor :name
  attr_reader :exists
  @@base_dir = "/images"
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
    @matrix = Matrix.find(self.name.to_i)
    @image_size = 128
    @image = Magick::Image.new(@image_size, @image_size)
    @size = @image_size / 8
    x = 0
    y = 0
    65.times do |i|
      @data = Magick::Draw.new
      color = 16 * @matrix.data[i].to_i
      @data.fill("rgb(#{color},#{color},#{color})")
      @data.rectangle(x, y, x + @size, y + @size)
      x += @size
      x = 0 if (i % 8 == 0 && i != 0)
      y += @size if (i % 8 == 0 && i != 0)
      @data.draw(@image)
    end
    if @image.write(Rails.root.join('public',"images", "#{self.name}.#{@@ext}").to_s)
      @exists = true
    else
      false
    end   
  end

  def self.find(name)
   Image.new(name, true) if File.exists?(Rails.root.join('public',"images", "#{name}.#{@@ext}").to_s)
  end

  def self.find_or_create(name)
    if File.exists?(Rails.root.join('public',"images", "#{name}.#{@@ext}").to_s)
      "#{@@base_dir}/#{name}.#{@@ext}"
    else
      @image = Image.new(name)
      @image.save
      @image
    end
  end
end