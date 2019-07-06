class PaymentsController < ApplicationController
    def new
        @lesson = Lesson.find params[:lesson_id]
        @teacher = @lesson.teacher
        @user = @lesson.user
      end
    
      def create
        @payment = Payment.new payment_params
        @lesson_id = params[:lesson]
        @lesson = Lesson.find(@lesson_id)
        @user_id = params[:user]
        @user = User.find(@user_id)
        @payment.user = @user
        @teacher_id = params[:teacher]
        @teacher = Teacher.find(@teacher_id)
        @payment.teacher = @teacher
        charge = Stripe::Charge.create({
          amount: (@teacher.price * 100).to_i,
          currency: 'cad',
          source: params[:stripe_token],
          description: "Charge for #{@teacher} by #{current_user}"
          })
          if @payment.save
             @lesson.pay
             @lesson.update lesson_params
          @payment.update(transaction_id: charge.id)
          redirect_to thanks_lesson_payment_path(@lesson,@payment), notice: 'Thanks for completing the payment.'
          else
          flash.now[:alert] = 'Problem handling the payment, please try again'
          render :new
        end
      end

      def thanks
        @lesson = Lesson.find(params[:lesson_id])
      end

      private

      def payment_params
        params.permit(:teacher_id, :user_id, :lesson_id)
      end

      def lesson_params
        params.permit(:comment)
    end
end
