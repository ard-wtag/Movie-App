class UsersController < ApplicationController
      def index
        @users=User.all   
      end
    
      def show
        @user=User.find(params[:id])
        @reviews = @user.reviews
        @followers_count = @user.followers.count
        @followees_count = @user.followees.count
      end
    
      def edit
      end
    
      def new
      end
    
      def create
      end
    
      def delete
        @user=User.find(params[:id])
      end
    
      def destroy
        @user = User.find(params[:id])

        if @user.destroy 
          flash[:notice] = "User was successfully deleted."
          redirect_to users_path
        else 
          redirect_to users_path, alert: 'Failed to delete movie.'
        end
      end
end
