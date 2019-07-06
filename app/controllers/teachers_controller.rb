class TeachersController < ApplicationController
    before_action :find_teacher, only: [:show, :edit, :update, :destroy]


    def new
      if !current_user.teacher
      @teacher = Teacher.new
      else
        redirect_to root_path
      end
    end
  
    def create
      @teacher = Teacher.new teacher_params      
      @teacher.user = current_user
      if @teacher.save
        params[:teacher][:teacher_timeslots].each do |ts|
          if ts
            slot = TeacherTimeslot.new
            slot.teacher_id = @teacher.id
            slot.timeslot_id = ts
            slot.save
          end
        end
        redirect_to teacher_path(@teacher.id)
      else
        render :new
      end
    end
  
    def show
      @review = Review.new
      @reviews = @teacher.reviews.order(created_at: :desc)
      @favourite = @teacher.favourites.find_by_user_id current_user if user_signed_in?

      unless @teacher.reviews.empty?
      @avg_rating = @teacher.reviews.average(:rating).floor(2).to_f
      end

    end
  
    def index
      @languages = Language.all
      @teachers = Teacher.all

      @teachers.each do|teacher|
        unless teacher.reviews.empty?
          @avg_rating = teacher.reviews.average(:rating).floor(2).to_f
        end
      end
      
        if params[:price]
          @language = Language.find_or_initialize_by(name: params[:language])
          @teachers= @language.teachers.order(price: :ASC)
        elsif params[:rating]
          ratings = []
          @teachers = []
          @language = Language.find_or_initialize_by(name: params[:language])
          teachers = @language.teachers
          teachers.each do |t|
            if t.reviews.length == 0
              ratings << {id: t.id, rating: 0}
            else
              total = 0
              count = 0
              t.reviews.each do |r|
                total += r.rating
                count +=1
              end
              ratings << {id: t.id, rating: total/count}
            end
          end
          ratings = ratings.sort_by{|r| -r[:rating]}
          ratings.each do |rating|
            @teachers << @language.teachers.find(rating[:id])
          end
          
        elsif params[:language]
          @language = Language.find_or_initialize_by(name: params[:language])
          @teachers= @language.teachers.order(created_at: :DESC)
        else
          @teachers = Teacher.order(created_at: :DESC)
        end

      
    end
  
    def edit
      # if !can?(:edit, @question)
      #   redirect_to root_path, alert: 'Not authorized'
      # end
    end
  
    def update
      if @teacher.update teacher_params
        redirect_to teacher_path(@teacher.id)
      else
        render :edit
      end
    end
  
    def destroy
      @teacher.destroy
      redirect_to teachers_path
    end

    def teacher_dashboard
      if user_signed_in?
        @teacher = current_user.teacher
        @requested_lessons = @teacher.lessons.where(aasm_state: "requested")
        @approved_lessons = @teacher.lessons.where(aasm_state: "approved")
        @payed_lessons = @teacher.lessons.where(aasm_state: "payed")
      end
    end

    private
  
    def teacher_params
      # params.require(:teacher).permit!
      params.require(:teacher).permit(:description, :price, :address, :language_names, :teacher_timeslots)

    end

  
    def find_teacher
      @teacher = Teacher.find(params[:id])
    end

    def average_rating
      @teachers.each do|teacher|
        @avg_rating = teacher.reviews.average(:rating).floor(2).to_f
      end
    end
end


