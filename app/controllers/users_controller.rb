# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:request_friend, :pending_friends, :all_friends]
  before_action :set_user, only: [:show, :request_friend, :accept_request, :decline_request, :remove_friend]

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
    show_pending_friends
  end
def accept_request
current_user.accept_request(@user)
request_accepted
end
def decline_request
  current_user.decline_request(@user)
request_rejected
end
def remove_friend
current_user.remove_friend(@user)
success_unfriend
end
def requested_friends
@user.requested_friends
show_requested_friends
end

def all_friends 
  @users = current_user.friends
  show_all_friends
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

def succes_friend_request_accepted
  render status: :ok, json:{message: "you have successfully friend to #{@user.name}."}
end
def error_friend_request_decline
  render status: :forbidden, json:{errors: ['you have decline the request']}
end
def show_pending_friends
  render status: :ok, template: 'users/index.json.jbuilder'
  end
  def request_accepted
render status: :ok, json:{message: "you have successfully friend to #{@user.name}."}
  end
  def request_rejected
    render status: :ok, json:{message: "you have rejected friend to #{@user.name}."}
  end
  def success_unfriend
    render status: :ok, json:{message: "yor have unfriend to #{@user.name}."}
  end
  def show_all_friends
    render status: :ok, template: 'users/index.json.jbuilder'
  end
def show_requested_friends
render status: :ok, template: 'user/index.json.jbuilder'
end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
