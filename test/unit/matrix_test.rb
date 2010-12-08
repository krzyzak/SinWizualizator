require "test_helper"

class MatrixTest < ActiveSupport::TestCase
  include ActiveModel::Lint::Tests

  def model
    Matrix.new({:data => [1,2,3,4,5], :output => 2, :targer => 4})
  end

  test "it should raise ArgumentError if id is bigger than 5036" do
    assert_raise(ArgumentError) do
      Matrix.find(5037)
    end
  end

  test "it should raise ArgumentError if id is lower than 0" do
    assert_raise(ArgumentError) do
      Matrix.find(-1)
    end
  end

  test "it should get data from cache if exists" do
    Rails.cache.write :data, ["1,2,6,7","2,5,7,8"]
    Rails.cache.write :output, ["2", "4"]
    Rails.cache.write :target, ["2", "6"]
    @matrix = Matrix.find(1)

    Rails.cache.delete :data
    Rails.cache.delete :output
    Rails.cache.delete :target

    assert_equal("6", @matrix.target)
  end

  test "it should get data from file if cache don't exists" do
    @matrix = Matrix.find(5002)
    assert_equal("9", @matrix.target)
  end
end