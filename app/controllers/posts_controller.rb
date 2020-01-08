class PostsController < ApplicationController
    http_basic_authenticate_with name: "bc2mighty", password: "1234", except: [:index, :show]
    def index
        @posts = Post.order(id: :DESC)
    end

    def show
        @post = Post.find(params[:id])
    end

    def new
        @post = Post.new
    end

    def create
        # render plain: params[:post].inspect
        # render plain: params[:post]['body'].class
        # render plain: post_params
        @post = Post.new(post_params)
        if (@post.save)
            # redirect_to @post
            redirect_to posts_path
        else
            render 'new'
        end
        # params = ActionController::Parameters.new(post: {title: 'Francesco', body: 'admin'})
        # render plain: params.inspect
        # render plain: permitted = params.require(:mandrill_event).permit(:name, :age) }
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        if (@post.update(post_params))
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
            # params.require(:post).permit!
            #That's because 
            params.require(:post).permit(:title, :body)
        end
end
