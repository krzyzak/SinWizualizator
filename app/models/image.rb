class Image
  include ActiveModel::Validations
  extend ActiveModel::Naming

  attr_accessor :name
  attr_reader :exists

  validate do |image|
      image.errors.add_to_base("Name can't be blank") if image.name.blank?
    end

  def initialize(name = nil)
    @name = name
    @exists = false
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

  def save
    #TODO: implement image saving
    @exists = true
  end
end