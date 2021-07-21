# README

- Create a login route
  `post 'login', to: 'authentication#login'`

- Create a login controller and action
  `rails g controller authentication`

  ```
  def login
  end
  ```

- Look up user (by their username)

```
def login
    @user = User.find_by({ username: params[:username] })

    if !@user
        render json: { error: 'No user by that name.' }, status: :unauthorized
    else
    end
end
```

- Authenticate the user (check that their password is okay)

```
def login
    <!-- We look up the user -->
    @user = User.find_by({ username: params[:username] })

    <!-- If we don't find them, we throw an error -->
    if !@user
        render json: { error: 'No user by that name.' }, status: :unauthorized
    else
        <!-- If their password is wrong, we throw an error -->
        if !@user.authenticate params[:password]
            render json: { error: 'Wrong password brah!' }, status: :unauthorized
        else
            <!-- Otherwise, we're good to go -->
            render json: { message: 'Right on bud!' }, status: :created
        end
    end
end
```

- Create a token

  - Sign it
  - Send it

```
def login
    @user = User.find_by({ username: params[:username] })

    if !@user
        render json: { error: 'No user by that name.' }, status: :unauthorized
    else
        if !@user.authenticate params[:password]
            render json: { error: 'Wrong password brah!' }, status: :unauthorized
        else
            payload = {
                <!-- iat: Time.now.to_i, -->
                user_id: @user.id
            }

            secret = 'topsecret'

            token = JWT.encode payload, secret

            <!-- render json: { message: 'Right on bud!' }, status: :created -->
            render json: { token: token }, status: :created
        end
    end
  end

```
