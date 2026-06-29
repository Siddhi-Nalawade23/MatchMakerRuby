class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

def index
  users = User.all.map do |user|
    {
      id:    user.id,
      name:  user.name,
      email: user.email,
      phone: user.phone,
      role:  user.role
    }
  end
  render json: users
end

  def create
  if params[:name].blank? ||
     params[:email].blank? ||
     params[:password].blank?

    render json: {
      error: "Name, email and password needed"
    }, status: :bad_request
    return
  end

  user = User.new(user_params)

  if user.save
    render json: {
      message: "User created successfully",
      user: {
        id:    user.id,
        name:  user.name,
        email: user.email,
        phone: user.phone,
        role:  user.role
      }
    }, status: :created

  else
    render json: {
      errors: user.errors.full_messages
    }, status: :unprocessable_entity
  end
end

def login
  user = User.find_by(email: params[:email]&.downcase&.strip)

  if user.nil?
    render json: { error: "Invalid email or password" }, status: :unauthorized
    return
  end

  if user.valid_password?(params[:password])
    token = JwtService.encode(user)

    render json: {
      message: "Login successful",
      token: token,
      user: {
        id:    user.id,
        name:  user.name,
        email: user.email,
        phone: user.phone,
        role:  user.role
      }
    }, status: :ok
  else
    render json: { error: "Invalid email or password" }, status: :unauthorized
  end
end

  def send_otp
    phone = params[:phone]
    user = User.find_by(phone: phone)
    if user.nil?
      render json: {
        error: "Phone number not registered"
      }, status: :bad_request
      return
    end
    otp = rand(100000..999999).to_s
    user.update(
      otp: otp,
      otp_created_at: Time.current,
      otp_expires_at: 10.minutes.from_now,
      otp_used: false
    )
    puts "OTP is #{otp}"
    render json: {
      message: "OTP sent successfully"
    }
  end
  private
  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :phone
    )
  end
end
