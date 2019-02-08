# frozen_string_literal: true

json.array! @users, partial: 'users/user.json.jbuilder', as: :user
