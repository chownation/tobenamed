class PostsController < ApplicationController
	http_basic_authenticate_with name: "michael", password: "password", except: [:index, :show]
	
	def new
		@post = Post.new
	end

	#takes respective attributes, saves to database
	def create
		@post = Post.new(params[:post].permit(:title, :text))
		
		#returns boolen of saved or not
		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def show 
		@post = Post.find(params[:id])
	end

	#show all
	def index
		@post = Post.all
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])

		if @post.update(params[:post].permit(:title, :text))
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy

		redirect_to posts_path
	end

	private 
		def post_params
			params.require(:post).permit(:title, :text)
		end
end 