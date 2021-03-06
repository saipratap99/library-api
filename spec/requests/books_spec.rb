require "swagger_helper"
RSpec.describe "/v1/books", type: :request do
    path "/v1/books" do
      post "Create a Book" do
        tags "Books"
        consumes "application/json"
        parameter name: :book, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            edition: { type: :integer },
            publication_year: { type: :string },
            authors: { type: :string },
          },
          required: ["name", "edition","publication_year","authors"],
        }
        response "200", "Book created" do
          let(:book) { { name: "Ruby Programming", edition: 1,publication_year: "2011", authors: "18,29,75" } }
          run_test!
        end
    end
    end
    path "/v1/books" do
        get "Retrives Books" do
          tags "Books"
          produces "application/json"
          parameter name: :page, in: :query,type: :integer
          parameter name: :per_page, in: :query,type: :integer
          response "200", "Books retrived" do
            let(:page){1}
            let(:per_page){10}
            run_test!
          end
        end
    end
    path "/v1/books/{id}" do
      get "Retrives a Book" do
        tags "Books"
        produces "application/json"
        parameter name: :id, in: :path,type: :integer
        response "200", "Book retrived" do
          let(:id){2}
          run_test!
        end
      end
  end
  path "/v1/books/{id}" do
    patch "Updates a Book" do
      tags "Books"
      consumes "application/json"
      parameter name: :id, in: :path, type: :integer
      parameter name: :book, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          edition: { type: :integer },
          publication_year: { type: :string },
          authors: { type: :string },
        }
      }
      response "200", "Book is updated" do
        let(:id) {1}
        let(:book) { { name: "R Programming", edition: 2,publication_year: "1991", authors: "8,25" } }
        run_test!
      end
  end
  end

  path "/v1/books/{id}" do
    delete "deletes a Book" do
      tags "Books"
      produces "application/json"
      parameter name: :id, in: :path,type: :integer
      response "200", "Book deleted" do
        let(:id){2}
        run_test!
      end
    end
end
end
