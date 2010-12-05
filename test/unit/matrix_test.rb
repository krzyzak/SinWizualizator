require "test_helper"

class MatrixTest < ActiveSupport::TestCase
  include ActiveModel::Lint::Tests

  def model
    Matrix.new([1,2,3,4,5],2,4)
  end
end