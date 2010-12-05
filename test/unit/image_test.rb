require "test_helper"

class ImageTest < ActiveSupport::TestCase
  include ActiveModel::Lint::Tests

  def model
    Image.new("asdas")
  end
end