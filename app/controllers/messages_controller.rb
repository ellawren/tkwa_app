class MessagesController < ApplicationController

    def index
        @messages = Message.all_messages(User.find(current_user.id).project_ids)
    end

    def show
        @message = Message.find(params[:id])
    end

    def new
        @message = Message.new
    end

    def create
        @message = Message.new(params[:message])
        if @message.save
            redirect_to messages_path
        else
            render 'new'
        end
    end

    def edit
        @message = Message.find(params[:id])
    end

    def update
        @message = Message.find(params[:id])
        if @message.update_attributes(params[:message])
            flash[:success] = "Message updated"
            redirect_to messages_path
        else
            render 'edit'
        end
    end

    def destroy
        Message.find(params[:id]).destroy
        flash[:success] = "Message destroyed."
        redirect_to messages_path
    end
    
end
