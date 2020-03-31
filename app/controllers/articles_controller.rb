class ArticlesController < ApplicationController
	before_action :set_article, only: [:show, :edit, :update, :destroy] #corre set_Article antes de cualquier cosa en los metodos especificados
	before_action :require_user, except: [:index, :show]
	before_action :require_same_user, only: [:edit, :update, :destroy]

	def index
		@articles = Article.paginate(page: params[:page], per_page: 5) 
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
		@article = Article.new(article_params) #!!duda con params
		@article.user = current_user
		#render plain: @article.inspect
		if @article.save
			flash[:success] = "Article was created succesfully" #ayuda a mostrar mensajes
			#redirect_to article_path(@article)
			redirect_to @article #version corta
		else
			render 'new' #regresa la pagina "new"
		end
	end

	def update
		#render plain: params[:article]
		if @article.update(article_params) #llamamos el metodo para refactorizar codigo
			flash[:success] = "Article was updated succesfully"
			redirect_to @article
		else
			render 'edit'
		end

	end

	def destroy
		if @article.destroy
			flash[:danger] = "Article was deleted succesfully"
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

	def require_same_user
		if current_user != @article.user && !current_user.admin? #si no es el current user y no es admin no deja editar, con una que no se cumpla si entra al if
			flash[:danger] = "You can only edit or delete your own articles"
			redirect_to root_path
		end
	end

end