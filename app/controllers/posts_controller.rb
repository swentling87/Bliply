class PostsController < ApplicationController

  def new
    @post = Post.new
    @user = current_user
    id = params[:interest_id] || params[:location_id]
    if params[:interest_id]
      @interest = Interest.find(id)
    elsif params[:location_id]
      @location = Location.find(id)
    end
  end

  def create
    id = params[:interest_id] || params[:location_id] || params[:id]
    @user = current_user

    if params[:interest_id]
      @interest = Interest.find(id)
      @post = @interest.posts.build(post_params)
      @post.user_id = @user.id
      if @post.save
        @interest.posts << @post
        flash[:notice] = "Post saved successfully."
        redirect_to interest_path(@interest)
      else
        flash[:alert] = "Post failed to save."
        redirect_to interest_path(@interest)
      end
    elsif params[:location_id]
      @location = Location.find(id)
      @post = @location.posts.build(post_params)
      @post.user_id = @user.id
      if @post.save
        @location.posts << @post
        flash[:notice] = "Post saved successfully."
        redirect_to location_path(@location)
      else
        flash[:alert] = "Post failed to save."
        redirect_to location_path(@location)
      end
    elsif params[:id]
      @post = @user.posts.build(post_params)
      @post.user_id = @user.id
      if @post.save
        @user.posts << @post
        flash[:notice] = "Post saved successfully."
        redirect_to users_path(@user)
      else
        flash[:alert] = "Post failed to save."
        redirect_to users_path(@user)
      end
    end
  end

  def destroy
    id = params[:interest_id] || params[:location_id] || params[:id]
    @user = current_user

    if params[:interest_id]
      @interest = Interest.find(id)
      @post = @interest.posts.find(params[:id])
      if @post.destroy
        flash[:notice] = "Post deleted successfully."
        redirect_to interest_path(@interest)
      else
        flash[:alert] = "Post failed to delete."
        redirect_to interest_path(@interest)
      end
    elsif params[:location_id]
      @location = Location.find(id)
      @post = @location.posts.find(params[:id])
      if @post.destroy
        flash[:notice] = "Post deleted successfully."
        redirect_to location_path(@location)
      else
        flash[:alert] = "Post failed to delete."
        redirect_to location_path(@location)
      end
    elsif params[:id]
      @user = current_user
      @post= @user.posts.find(params[:id])
      if @post.destroy
        flash[:notice] = "Post deleted successfully."
        redirect_to users_path(@user)
      else
        flash[:alert] = "Post failed to delete."
        redirect_to users_path(@user)
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
