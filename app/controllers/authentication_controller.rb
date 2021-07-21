class AuthenticationController < ApplicationController
    def login
        @user = User.find_by({ username: params[:username] })

        if !@user
            render json: { error: 'Invalid username' }, status: :unauthorized
        else
            if !@user.authenticate params[:password]
                render json: { error: 'Invalid password' }, status: :unauthorized
            else
                payload = {
                    user_id: @user.id
                }

                secret = 'topsecret'

                token = JWT.encode payload, secret

                render json: { token: token }, status: :created
            end
        end
    end
end
