class RepliesController < ApplicationController
  def index
    matching_replies = Reply.all

    @list_of_replies = matching_replies.order({ :created_at => :desc })

    render({ :template => "replies/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_replies = Reply.where({ :id => the_id })

    @the_reply = matching_replies.at(0)

    render({ :template => "replies/show" })
  end

  def create
    the_reply = Reply.new
    the_reply.post_id = params.fetch("query_post_id")
    the_reply.user_id = params.fetch("query_user_id")
    the_reply.content = params.fetch("query_content")
    the_reply.user_id = current_user.id

    if the_reply.valid?
      the_reply.save
      redirect_to("/posts/#{the_reply.post_id}", { :notice => "Reply created successfully." })
    else
      redirect_to("/replies", { :alert => the_reply.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_reply = Reply.where({ :id => the_id }).at(0)

    the_reply.post_id = params.fetch("query_post_id")
    the_reply.user_id = params.fetch("query_user_id")
    the_reply.content = params.fetch("query_content")

    if the_reply.valid?
      the_reply.save
      redirect_to("/replies/#{the_reply.id}", { :notice => "Reply updated successfully."} )
    else
      redirect_to("/replies/#{the_reply.id}", { :alert => the_reply.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_reply = Reply.where({ :id => the_id }).at(0)

    the_reply.destroy

    redirect_to("/replies", { :notice => "Reply deleted successfully."} )
  end
end
