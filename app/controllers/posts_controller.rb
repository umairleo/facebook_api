class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :authorize_user, only: [:update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.order(id: :desc)
    success_post_index
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    success_post_show
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      success_post_create
    else
      error_post_save
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if @post.update(post_params)
      success_post_show
    else
      error_post_save
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    success_post_destroy
  end
  protected
  def error_forbidden
render status: :forbidden, json: {errors: ['yor are not authorized to perform that action']}
  end
  def success_post_index
render status: :ok, template: 'posts/index.json.jbuilder'
  end

  def success_post_show
    render status: :ok, template: 'posts/show.json.jbuilder'
  end

  def success_post_create
    render status: :created, template: 'posts/show.json.jbuilder'
  end
  def success_post_destroy
    render status: :no_content, json:{}
  end
def error_post_save
  render status: :unprocessable_entity, json:{errors: @post.errors.full_messages}
end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.permit(:content, :image_name)
    end
def authorize_user
error_forbidden if @post.user != current_user
end
  end

