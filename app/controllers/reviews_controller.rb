class ReviewsController < ApplicationController
    # before_action :authenticate_user!
    before_action :find_review, only: [:destroy]
    # before_action :authorize, only: [:edit,:update, :destroy]

    def create
        @lesson = Lesson.find(params[:lesson])
        @teacher = @lesson.teacher
        @review = Review.new review_params
        @review.teacher = @teacher
        @review.user = current_user
        if @review.save
            @lesson.done
            @lesson.update lesson_params
            # byebug
            # ReviewMailer.new_review(@review).deliver_later(wait: 30.seconds)
            # # ReviewMailer.new_review(@review).deliver_now
            redirect_to teacher_path(@teacher)
        else
            @reviews = @teacher.reviews.order(created_at: :desc)
            render root_path
        end
    end

    

    def destroy
        @review.destroy
        redirect_to teacher_path(@review.teacher)
    end

    private
    def review_params
        params.permit(:body, :rating)
    end

    def authorize
        redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @review)

    end

    def find_review
        @review = Review.find(params[:id])
    end

    def lesson_params
        params.permit()
    end

end
