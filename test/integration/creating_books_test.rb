require 'test_helper'

class CreatingBooksTest < ActionDispatch::IntegrationTest
  test 'creates books with valid data' do
    post '/api/books', {
      book: {
        title: 'Pragmatic Programmer',
        rating: 5,
        author: 'Dave Thomas',
        genre_id: 1,
        review: 'Exellent book for any programmer',
        amazon_id: '12345'
      }
    }.to_json, {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    book = json(response.body)[:book]
    assert_equal api_book_url(book[:id]), response.location

    assert_equal 'Pragmatic Programmer',  book[:title]
    assert_equal 5, book[:rating].to_i
    assert_equal 'Dave Thomas',  book[:author]
    assert_equal 1, book[:genre_id]
    assert_equal 'Exellent book for any programmer', book[:review]
    assert_equal '12345', book[:amazon_id]

  end

  test 'does not create book without title' do
    post '/api/books', { book: { title: nil, rating: 1 }}.to_json,
      { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }

    assert_equal 422, response.status
  end
end