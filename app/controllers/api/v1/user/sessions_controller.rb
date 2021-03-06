class Api::V1::User::SessionsController < UserController
  def create
    user_password = params[:session][:password]
    user_email = params[:session][:email]
    user = user_email.present? && User.find_by(email: user_email)

    if user.valid_password? user_password
      sign_in user, store: false
      user.save
      render json: {
      		status: 'success',
      		data: user.credential_as_json
      	}, status: 200
    else
      render json: { 
        status: 'fail',
        messages: "Invalid email or password"
      }, status: 422
    end
  end	
end