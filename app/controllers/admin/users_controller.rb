class Admin::UsersController < AdminController
    include DoorkeeperRegisterable

    def create
        client_app = Doorkeeper::Application.find_by(uid: user_params[:client_id])

        unless client_app
          return render json: { error: I18n.t("doorkeeper.errors.messages.invalid_client") }, status: :unauthorized
        end

        unless strong_password?(user_params[:password])
        return render json: { error: "Password must include at least one lowercase letter, one uppercase letter, one digit, one special character, and should be at least 8 and at most 30 characters" }, status: :unprocessable_entity
        end

        user = User.find_by(email: user_params[:email])
        return render json: { error: "Email Already registered." }, status: :unprocessable_entity if user.present?

        allowed_params = user_params.except(:client_id)
        user = User.new(allowed_params)

        if user.save
        render json: render_user(user, client_app), status: :ok
        else
        return render json: { error: user.errors.full_messages.join(", ") }, status: :unprocessable_entity
        end
    end

 private

    def strong_password?(password)
        password.match(/\A(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[^a-zA-Z0-9]).{8,30}\z/)
    end

    def user_params
        params.permit(:email, :password, :password_confirmation, :client_id)
    end
end
