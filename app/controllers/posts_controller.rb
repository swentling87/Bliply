class PostsController < ApplicationController

  def new
    @post = Post.new
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
    if params[:id]
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
    else
      if params[:interest_id]
        @postable = Interest.find(id)
      elsif params[:location_id]
        @postable = Location.find(id)
      end
      @post = @postable.posts.build(post_params)
      @post.user_id = @user.id
      if @post.save
        @postable.posts << @post
        flash[:notice] = "Post saved successfully."
      else
        flash[:alert] = "Post failed to save."
      end

      if params[:interest_id]
        redirect_to interest_path(@postable)
      elsif params[:location_id]
        redirect_to location_path(@postable)
      end
    end
  end

  def destroy
    id = params[:interest_id] || params[:location_id] || params[:id]
    @user = current_user

    if params[:interest_id]
      @postable = Interest.find(id)
    elsif params[:location_id]
      @postable = Location.find(id)
    elsif params[:id]
      @postable = current_user
    end

    @post = @postable.posts.find(params[:id])
    if @post.destroy
      flash[:notice] = "Post deleted successfully."
      redirect_to :back
    else
      flash[:alert] = "Post failed to delete."
      redirect_to :back
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
