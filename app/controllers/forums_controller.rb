class ForumsController < ApplicationController
  before_action :forum_finding, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy, :like ]

  def index
    @forums = Forum.all.order("created_at DESC")
  end

  def show
    # ใช้ @forum ที่กำหนดใน before_action
  end

  def new
    @forum = current_user.forums.build
  end

  def create
    @forum = current_user.forums.build(forum_params)
    if @forum.save
      redirect_to root_path, notice: "Forum successfully created."
    else
      render "new"
    end
  end

  def edit
    # ใช้ @forum ที่กำหนดใน before_action
  end

  def update
    if @forum.update(forum_params)
      redirect_to @forum, notice: "Forum successfully updated."
    else
      render "edit"
    end
  end

  def destroy
    @forum.destroy
    redirect_to root_path, notice: "Forum successfully deleted."
  rescue ActiveRecord::RecordNotDestroyed => e
    redirect_to root_path, alert: "Failed to delete forum: #{e.message}"
  end

  def like
    @forum = Forum.find(params[:id])
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @forum.likes.create(user: current_user)
    end
    redirect_to forum_path(@forum)
  end

  private

  def forum_params
    params.require(:forum).permit(:thread, :content, :image)
  end

  def forum_finding
    @forum = Forum.find(params[:id])
  end

  def already_liked?
    Like.where(user: current_user, forum: @forum).exists?
  end
end
