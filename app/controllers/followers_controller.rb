class FollowersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def follow
    current_user.followed_friend_lists.create(followee: @user)
    @origin_user = User.find(params[:origin_user])
    origin_view = params[:origin_view]
    redirect_based_on_origin(@origin_user, origin_view)
    #redirect_to user_path(current_user.id), notice: 'You are following this user.'

  end

  def unfollow
    follow_record = current_user.followed_friend_lists.find_by(followee: @user)
    follow_record.destroy if follow_record

    @origin_user = User.find(params[:origin_user])
    origin_view = params[:origin_view]
    redirect_based_on_origin(@origin_user, origin_view)
    #redirect_to user_path(current_user.id), notice: 'You are no longer following this user.'
  end

  def followerlist
  
    @followers=@user.followers    
  end

  def followeelist
    @followees=@user.followees 
  end

  private 
  def set_user
    @user=User.find(params[:id])
  end 

  def redirect_based_on_origin(origin_user, origin_view)
    case origin_view
    when 'user'
      redirect_to user_path(origin_user), notice: 'Action performed successfully'
    when 'followerlist'
      redirect_to followerlist_follower_path(origin_user), notice: 'Action performed successfully'
    when 'followeelist'
      redirect_to followeelist_follower_path(origin_user), notice: 'Action performed successfully'
    else
      redirect_to root_path, alert: 'Something went wrong'
    end
  end


end
