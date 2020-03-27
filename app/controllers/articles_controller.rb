class ArticlesController < ApplicationController
	
	def index
		@articles = Article.all
	end

	def show
		#byebug detiene el servidor y arroja una consola de debug
		@article = Article.find(params[:id])
	end

	def new
	end

	def create
		#render plain: params[:article] #otra forma de debuguear
		@article = Article.new(params.require(:article).permit(:title, :description))
		#render plain: @article.inspect
		@article.save
		#redirect_to article_path(@article)
		redirect_to @article #version corta
	end

end