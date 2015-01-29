require 'test_helper'

class ListingBooksTest < ActionDispatch::IntegrationTest
  test 'listing books' do
    setup do
      Book.create!(title: 'Pragmatic Programmer', rating: 5)
      Book.create!(title: "Ender's game", rating: 3)
    end
    get '/books'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    assert_equal Book.count, JSON.parse(response.body).size
  end
end
