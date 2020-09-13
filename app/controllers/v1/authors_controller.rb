module V1
  class AuthorsController < ApplicationController
    def index
      @authors = Author.page(page).per(per_page)
      render json: { authors: @authors, meta: { pagination: { per_page: per_page, total_pages: page_count, authors: Author.count, current_page: page } } }
    end

    private

    def page
      @page ||= params[:page] || 1
    end

    def per_page
      @per_page ||= params[:per_page] || 10
    end

    def page_count
      count = Author.count / per_page.to_f
      count.ceil
    end
  end
end
