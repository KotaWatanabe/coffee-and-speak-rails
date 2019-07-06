class LessonsController < ApplicationController

    def create
        @lesson = Lesson.new lesson_params
       
        @lesson.user = current_user
        @id = params[:teacher]
        @teacher = Teacher.find(@id)
        @lesson.teacher = @teacher
            if @lesson.save
                @lesson.request
                @lesson.save
                redirect_to dashboard_user_path(current_user)
            else
                render :new
            end
    end

    def show
        @lesson = Lesson.find(params[:id])
        @teacher = @lesson.teacher
        @user = @lesson.user
    end

    def edit
    end
  
    def update
    end

    def destroy
        @lesson = Lesson.new lesson_params
        @lesson.destroy
        redirect_to dashboard_user_path(current_user)
      end

    def approve
        @lesson = Lesson.find(params[:lesson])
        @id = params[:user]
        @user = User.find(@id)
        @lesson.user = @user
         if @lesson.update lesson_params
            @lesson.approve!
            redirect_to teacher_dashboard_teacher_path(@lesson.teacher)
        else
            render :new
        end
    end
    def decline
        @lesson = Lesson.find(params[:lesson])
        @id = params[:user]
        @user = User.find(@id)
        @lesson.user = @user
         if @lesson.update lesson_params
            @lesson.decline!
            redirect_to teacher_dashboard_teacher_path(@lesson.teacher)
        else
            render :new
        end
    end

    def approve
        @lesson = Lesson.find(params[:lesson])
        @id = params[:user]
        @user = User.find(@id)
        @lesson.user = @user
         if @lesson.update lesson_params
            @lesson.approve!
            redirect_to teacher_dashboard_teacher_path(@lesson.teacher)
        else
            render :new
        end
    end

    def pay
        @lesson = Lesson.find(params[:lesson])
        @id = params[:teacher]
        @teacher = Teacher.find(@id)
        @lesson.user = User.find(params[:id])
         if @lesson.update lesson_params
            redirect_to new_lesson_payment_path(@lesson)
        else
            render :root_path
        end
    end

    def finish
        @lesson = Lesson.find(params[:lesson])
        @teacher_id = params[:teacher]
        @teacher = Teacher.find(@teacher_id)
        @lesson.teacher = @teacher
        @user_id = params[:user]
        @user = User.find(@user_id)
        @lesson.user = @user
         if @lesson.update lesson_params
            @lesson.finish!
            redirect_to teacher_dashboard_teacher_path(@teacher)
        else
            render :root_path
        end
    end

    def done

    end

  
    private
    def lesson_params
        params.permit(:comment, :answer)
    end
end
