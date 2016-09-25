class SearchController < ApplicationController
    def show  
           @users = User.search(params[:id])
        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @user }
       
        end
    end 
     def showPost  
         @microposts = Micropost.search(params[:id])
          respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @micropost }
        end
    end 
end
