class PostsController < ApplicationController
  def index
    @posts = Post.all.shuffle
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.assign_attributes(:user_id => session[:user_id])
    # @city = :city
    @post.assign_attributes(:map_url => "https://maps.googleapis.com/maps/api/staticmap?center=#{@post.city}&zoom=11&size=300x200")
    if @post.save
      flash[:newUser] = "Post: #{@post.title} successfully created"
      redirect_to "/posts/#{@post.id}"
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
      @post.update(:map_url => "https://maps.googleapis.com/maps/api/staticmap?center=#{@post.city}&zoom=11&size=300x200")
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
      p.title.split(/[\s,]+/).each {|w| array.push(w.downcase)}
      p.body.split(/[\s,]+/).each {|w| array.push(w.downcase)}
      p.city.split(/[\s,]+/).each {|w| array.push(w.downcase)}
      p.user.first_name.split(/[\s,]+/).each {|w| array.push(w.downcase)}
      @query.split(/[\s,]+/).each do |m|
        @match.push(p.id) if array.include?(m.downcase)
      end
    end

    @match.uniq!

  end

  private
    def post_params
      params.require(:post).permit(:title, :rate, :city, :profile_url, :image, :body)
    end

end
