# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:request_friend, :pending_friends]
  before_action :set_user, only: %i[show request_friend]

  def index
    @users = User.all.order(id: :desc)
    success_user_index
  end

  def show
    success_user_show
  end

  def request_friend
    if current_user.friend_request(@user)
      success_request_submitted
    else
      error_not_allowed
    end
  end

  def pending_friends
    @users = current_user.pending_friends
    success_user_index
  end

  protected

  def success_user_index
    render status: :ok, template: 'users/index.json.jbuilder'
  end

  def success_user_show
    render status: :ok, template: 'users/show.json.jbuilder'
  end

  def success_request_submitted
    render status: :ok, json: { message: "Your Request has been sent to #{@user.name}." }
  end

  def error_not_allowed
    render status: :forbidden, json: { errors: ['You are not allowed to do this request'] }
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
