module Api
    module V1
        class PostsController < ApiController
            before_action :authorize_request

            def list_comments
                user_id = params[:user_id]
                post_id = params[:post_id]
                if user_id && post_id
                    comments = Comment.where(user_id: user_id, post_id: post_id)
                    render json: {status: 'SUCCESS', message: 'Loaded comments successfully', data: comments}, status: :ok
                else
                    render json: {status: 'ERROR', message: 'User or post not found'}, status: :not_found
                end
            end

            def add_comment
                user_id = current_user.id
                text = params[:text]
                post_id = params[:post_id]
                if user_id && text && post_id
                    comment = Comment.new(user_id: user_id, Text: text, post_id: post_id)
                    if comment.save
                        render json: {status: 'SUCCESS', message: 'Saved comment successfully', data: comment}, status: :ok
                    else
                        render json: {status: 'ERROR', message: 'Comment not saved', data: comment.errors}, status: :unprocessable_entity
                    end
                else
                    render json: {status: 'ERROR', message: 'Parameters incomplete'}, status: :not_found
                end
            end
        end
    end
end