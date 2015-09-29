class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.users << User.find(session[:user_id])
    if @post.save
      flash[:newUser] = "Post: successfully Added"
      redirect_to "/users/#{session[:user_id]}"
    else
      render "/posts/new"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:newUser] = "Post: #{@post.title} successfully updated"
      redirect_to "/posts/#{@post.id}"
    else
      flash[:notice] = "Post: #{@post.title} was not successfully updated. Missing parameters."
      redirect_to "/posts/#{@post.id}"
    end
  end

  def show
    @post = Post.find(params[:id])
  end


  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:newUser] = "Post: #{@post.title} successfully deleted"
      redirect_to "/posts"
    end
  end

  def search
    @query = params[:query]
    @posts = Post.all
    @match = []

    @posts.each do |p|
      array = []
      p.artist.split(/[\s,]+/).each {|w| array.push(w.downcase)}
      p.comments.split(/[\s,]+/).each {|w| array.push(w.downcase)}
      p.users.each { |u|
        u.first_name.split(/[\s,]+/).each {|w| array.push(w.downcase)}
      }
      @query.split(/[\s,]+/).each do |m|
        @match.push(p.id) if array.include?(m.downcase)
      end
    end

    @match.uniq!

  end

  private
    def post_params
      params.require(:post).permit(:artist, :year, :image_url, :comments, :image)
    end

end
