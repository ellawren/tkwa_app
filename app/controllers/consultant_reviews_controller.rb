class ConsultantReviewsController < ApplicationController

    def index
        @q = ConsultantReview.search(params[:q])
        @consultant_reviews = @q.result(:distinct => true).paginate(:page => params[:page], :per_page => 30)
    end

end
