class QuestionsController < ApplicationController
    before_action :authenticate_user!, only: [:show, :new, :create, :edit, :update, :delete]
    
    def index
        @questions = Question.all
    end

    def new
        @question = Question.new
    end

    def create
        @question = Question.create(question_params)
        if @question.save
            redirect_to root_path
        else
            render :new
        end
    end

    private
    def set_question
        @question = Question.find
    end
    
    def question_params
        params.require(:question).permit(:title, :content).merge(user_id: current_user.id)
    end
end
