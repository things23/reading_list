require 'test_helper'

class ListingBooksTest < ActionDispatch::IntegrationTest
  setup do
    @fiction = Genre.create!(name: 'Fiction')

    @fiction.books.create!(title: 'Remembrance of Things Past)', rating: 5)
    @fiction.books.create!(title: "The Sun Also Rises", rating: 4)
  end

  test 'listing books' do
    get '/api/books'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    books = json(response.body)[:books]
    #debugger
    assert_equal Book.count, books.size
    book = Book.find(books.first[:id])
    assert_equal @fiction.id, book.genre.id
  end

  test 'lists to rated books' do
    get '/api/books?rating=5'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    assert_equal 1, json(response.body)[:books].size
  end
end
