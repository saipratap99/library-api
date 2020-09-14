require 'swagger_helper'

RSpec.describe '/v1/authors', type: :request do
  path "/v1/authors" do
    get "Retrives Authors" do
      tags "Authors"
      produces "application/json"
      parameter name: :page, in: :query,type: :integer
      parameter name: :per_page, in: :query,type: :integer
      response "200", "Authors retrived" do
        let(:page){1}
        let(:per_page){10}
        run_test!
      end
    end
end
end
