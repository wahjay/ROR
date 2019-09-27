# A controller is simply a class that is defined to inherit from ApplicationController.
# It's inside this class that you'll define methods that will become the actions for this controller.
# These actions will perform CRUD operations on the articles within our system.

# controller (the class)

class ArticlesController < ApplicationController
  # actions

  # we want the user to be authenticated on every action except index and show,
  http_basic_authenticate_with name: "duhh", password: "secret", except: [:index, :show]

  # list all the articles
  def index
    @articles = Article.all
  end

  # show a specific article
  def show
   @article = Article.find(params[:id])
  end

  # display a form for new article
  def new
    @article = Article.new
  end

  # edit an article
  def edit
    @article = Article.find(params[:id])
  end

  # create the article and submit it to the databse
  # When a form is submitted, the fields of the form are sent to Rails as parameters.
  # These parameters can then be referenced inside the controller actions.
  #
  # The render method here is taking a very simple hash with a
  # key of :plain and value of params[:article].inspect.
  # The params method is the object which represents the parameters (or fields) coming in from the form.
  def create
    # We have to define our permitted controller parameters to prevent wrongful mass assignment.
    #  In this case, we want to both allow and require the title and text parameters for valid use of create.
    @article = Article.new(article_params)

    # save the model in the database
    if @article.save
      # redirect the user to the show action,
      redirect_to "/articles/#{@article.id}"
    else
      # The render method is used so that the @article object is passed back to the
      # new template when it is rendered. This rendering is done within the same request
      # as the form submission, whereas the redirect_to will tell the browser to issue another request.
      render :new
    end
  end

  # update a given article
  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to "/articles/#{@article.id}"
    else
      render :edit
    end
  end

  # destroy a given article
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    # articles_path retuns path '/articles'
    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end

end
