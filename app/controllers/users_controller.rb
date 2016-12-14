class UsersController < ApplicationController
  http_basic_authenticate_with name: 'admin', password: 'password', except: :user_activation

  before_action :set_user, only: [:show]

  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(:page => params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        # Send activation mail if not suppressed
        # Else mark suppressed
        UserActivationJob.perform_later(@user.id)
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def user_activation
    @user = User.find_by(token: params[:token])
    if @user.blank?
      redirect_to :root, alert: 'Invalid Activation token.'
    else
      @user.activated_at = Time.current
      @user.save
      redirect_to :root, notice: 'Successfully activated'
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :name)
  end
end
