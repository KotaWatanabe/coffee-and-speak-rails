class Api::V1::FavouritesController < Api::ApplicationController
    def create
        teacher = Teacher.find params[:teacher_id]
        favourite = Favourite.new user: current_user, teacher: teacher
        favourite.save!
        render json: { status:201, id: favourite.id }
      
    end

      def destroy
        favourite = Favourite.find params[:id]
        favourite.destroy
        render json: { status: 200 }
      end
end
