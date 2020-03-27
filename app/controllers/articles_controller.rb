class ArticlesController < ApplicationController
	
	def index
		@articles = Article.all
	end

	def show
		#byebug detiene el servidor y arroja una consola de debug
		@article = Article.find(params[:id])
	end

	def new
		@article = Article.new
	end

	def edit
		@article = Article.find(params[:id])
	end

	def create
		#render plain: params[:article] #otra forma de debuguear
		@article = Article.new(params.require(:article).permit(:title, :description)) #!!duda
		#render plain: @article.inspect
		if @article.save
			flash[:notice] = "Article was created succesfully" #ayuda a mostrar mensajes
			#redirect_to article_path(@article)
			redirect_to @article #version corta
		else
			render 'new' #regresa la pagina "new"
		end
	end

	def update
		@article = Article.find(params[:id])
		#render plain: params[:article]
		if @article.update(params.require(:article).permit(:title, :description))
			flash[:notice] = "Article was updated succesfully"
			redirect_to @article
		else
			render 'edit'
		end

	end

	def destroy
		@article = Article.find(params[:id])

		if @article.destroy
			redirect_to articles_path
		end
	end

end