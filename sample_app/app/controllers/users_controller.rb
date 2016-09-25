class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    @publicposts = @user.microposts.where("ispublic = ?", true).paginate(page: params[:page])
  end
  
  def friends
    @user = User.find(params[:id])
    @friends = @user.friends.paginate(page: params[:page])
  end
  
  def requests
    @user = User.find(params[:id])
    @requests = @user.requested_friends.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @old = @user.profilepicture.url
    if @user.update_attributes(user_params)
          flash[:success] = "Profile updated"
          @new = @user.profilepicture.url
          if @old != @new
            @micropost = @user.microposts.build(caption: @user.firstname + " changed their profile picture", ispublic: false)
            @micropost.postpicture = @user.profilepicture
            @micropost.save
          end
          redirect_to @user
    else
      render 'edit'
    end
  end
  
  def removepp
    @user = User.find(params[:id])
    @user.remove_profilepicture!
    @user.save
    flash[:success] = "Picture removed"
    redirect_to @user
  end
  
  def add_friend
    @user1 = User.find(params[:id])
    @user2 = User.find(params[:f_id])
    @user1.friend_request(@user2)
    redirect_to  "/"
  end
  
  def remove_friend
    @user1 = User.find(params[:id])
    @user2 = User.find(params[:f_id])
    @user1.remove_friend(@user2)
    redirect_to  "/"
  end
  
  def accept_request
    @user1 = User.find(params[:id])
    @user2 = User.find(params[:f_id])
    @user1.accept_request(@user2)
    redirect_to  "/"
  end

  def decline_request
    @user1 = User.find(params[:id])
    @user2 = User.find(params[:f_id])
    @user1.decline_request(@user2)
    redirect_to  "/"
  end
  
  private

    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :password,
                                   :password_confirmation, :gender, :birthdate,
                                   :phone, :hometown, :bio, :maritalstatus, :profilepicture)
    end
    
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
