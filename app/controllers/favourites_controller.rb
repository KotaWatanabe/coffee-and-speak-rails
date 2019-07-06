class FavouritesController < ApplicationController
        def create
            teacher = Teacher.find params[:teacher_id]
            favourite = Favourite.new user: current_user, teacher: teacher
            # if !can?(:favourite, teacher)
            #   redirect_to teacher, alert: "can't favourite teacher"
            # elsif favourite.save
            #   redirect_to teacher, notice: 'Favourited'
            # else
            #   redirect_to teacher, alert: 'Not Favourited'
            # end
            if favourite.save
                redirect_to teacher, notice: 'Favourited'
            end
          end
    
          def destroy
            favourite = Favourite.find params[:id]
            # if can? :destroy, favourite
            #   favourite.destroy
            #   redirect_to favourite.teacher, notice: 'favourite removed'
            # else
            #   redirect_to favourite.teacher, alert: "can't delete favourite"
            # end
            if favourite.destroy
                redirect_to favourite.teacher, notice: 'favourite removed'
            end
          end
end
