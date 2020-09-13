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
          let(:encounter) { { name: "Ruby Programming", edition: 1,publication_year: "2011", authors: "18,29,75" } }
          run_test!
        end
    end
    end
    path "/v1/books" do
        get "Retrives Books" do
          tags "Books"
          parameter name: :book, in: :body, schema: {
          type: :object,
          properties: {
            page: { type: :integer },
            per_page: { type: :integer },
          },
          required: ["page","per_page"],
          }
          response "200", "Books retrived" do
            let(:encounter){{page: 1,per_page: 5}}
            run_test!
          end
        end
    end
end