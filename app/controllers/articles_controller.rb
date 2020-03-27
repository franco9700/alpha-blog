class ArticlesController < ApplicationController
	before_action :set_article, only: [:show, :edit, :update, :destroy] #corre set_Article antes de cualquier cosa en los metodos especificados


	def index
		@articles = Article.all
	end

	def show
		#byebug detiene el servidor y arroja una consola de debug
	end

	def new
		@article = Article.new
	end

	def edit
	end

	def create
		#render plain: params[:article] #otra forma de debuguear
		@article = Article.new(article_params) #!!duda
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
		#render plain: params[:article]
		if @article.update(article_params) #llamamos el metodo para refactorizar codigo
			flash[:notice] = "Article was updated succesfully"
			redirect_to @article
		else
			render 'edit'
		end

	end

	def destroy
		if @article.destroy
			redirect_to articles_path
		end
	end

	private #Nada fuera de el controlador podra usar los siguientes metodos, no necesita end y siempre debe ir despues de todos los metodos
	def set_article
		@article = Article.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title, :description)
	end

end