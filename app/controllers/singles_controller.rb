class SinglesController < ApplicationController
  include Authenticatable
  skip_before_action :verify_authenticity_token

  # skip auth for public routes if needed
  # skip_before_action :authenticate_request, only: [:index]

  def create
    single = Single.new(single_params)
    if single.save
      render json: {
        message: "Single created successfully",
        single: single
      }, status: :created
    else
      render json: {
        errors: single.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def index
    singles =
      if params[:broker_number].present?
        Single.where(broker_number: params[:broker_number])
      else
        Single.all
      end
    render json: singles
  end

  # GET /singles/my_singles
  # Requires: Authorization: Bearer <token>
  def my_singles
    singles = Single.where(user_id: @current_user_id)
    if singles.any?
      render json: {
        user_id: @current_user_id,
        count: singles.count,
        singles: singles.map { |s| format_single(s) }
      }, status: :ok
    else
      render json: {
        user_id: @current_user_id,
        count: 0,
        singles: []
      }, status: :ok
    end
  end

  private

  def format_single(s)
    {
      id:            s.id,
      first_name:    s.first_name,
      last_name:     s.last_name,
      phone:         s.phone,
      email:         s.email,
      age:           s.age,
      gender:        s.gender,
      status:        s.status,
      broker_number: s.broker_number,
      user_id:       s.user_id,
      created_at:    s.created_at
    }
  end

  def single_params
    params.permit(
      :first_name,
      :last_name,
      :phone,
      :email,
      :age,
      :gender,
      :status,
      :broker_number,
      :user_id
    )
  end
end
