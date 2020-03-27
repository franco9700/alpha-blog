class ArticlesController < ApplicationController
	def index
		@articles = Article.all
	end

	def show
		#byebug detiene el servidor y arroja una consola de debug
		@article = Article.find(params[:id])
	end
end