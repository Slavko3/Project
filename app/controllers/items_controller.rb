class ItemsController < ApplicationController
	before_action :authenticate_user!, only:[:new,:create,:update,:edit,:destroy]
	before_action :get_item,  only: [:show,:update,:edit,:destroy,:positiv_vote,:negativ_vote]

	def index
		@items=(Item.all).order(created_at: :DESC)
	end

	def show

	end

	def rating
		@items=(Item.all).order(score: :DESC)
	end

	def new
		@categories=Category.all
		@item=Item.new		
	end

	def create
		@categories=Category.find(params[:category_ids])
		@item = Item.create(item_params)
		if @item.save
  			@item.categories << @categories
  			redirect_to item_path(@item.id)
  		else
  			render 'new'
  		end
	end

	def edit
		
	end

	def positiv_vote
		@vote = Vote.where(user_id: current_user.id,item_id: @item.id).first
		if current_user.id != @user
			if @vote==nil
				@vote=Vote.create(user_id: current_user.id,item_id: @item.id,score: 1)
	    	else	
	    		@item.score-=@vote.score
	    		if @vote.score == -1
	    	    	@vote.update(score: 0)
	        	else
	        		@vote.update(score: 1)
	        	end
	    	end
	    end
	    @item.update(score: Vote.where(item_id: @item.id).sum(:score))
	    redirect_back(fallback_location: root_path)
	end

	def negativ_vote
		@vote = Vote.where(user_id: current_user.id,item_id: @item.id).first
		if current_user.id != @user
			if @vote==nil
		    	@vote=Vote.create(user_id: current_user.id,item_id: @item.id,score: -1)
		    else
	    		@item.score-=@vote.score
	    		if @vote.score == 1
		    	    @vote.update(score: 0)
	    	    else
	        		@vote.update(score: -1)
		        end
		    end
	    end
	   	@item.update(score: Vote.where(item_id: @item.id).sum(:score))
	    redirect_back(fallback_location: root_path)
	end

	def update
		@item.update(item_params)
		redirect_to item_path(@item.id)
	end

	def destroy
		@item.destroy
		redirect_to root_path
	end

	private

	def item_params
		params.require(:item).permit(:name, :description, :cost, :count, {photos: []})
	end

	def get_item
		@item = Item.find(params[:id])
	end

	# def get_user
	# 	@user=@item.user_id
	# 	@vote=Vote.find_by(user_id: current_user.id, item_id: @item.id)
	# end

end
