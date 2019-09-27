class CommentsController < ApplicationController
  # You'll see a bit more complexity here than you did in the controller for articles.
  # That's a side-effect of the nesting that you've set up.
  # Each request for a comment has to keep track of the article to which the comment is attached,
  # thus the initial call to the find method of the Article model to get the article in question.
  http_basic_authenticate_with name: "duhh", password: "secret", only: :destroy

  # edit comments
  def edit
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
  end

  # create comments
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    #redirect_to article_path(@article)
    redirect_to "/articles/#{@article.id}"
  end

  # update comments
  def update
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])

    if @comment.update(comment_params)
      redirect_to "/articles/#{@article.id}"
    else
      render "comments/edit"
    end
  end

  # The destroy action will find the article we are looking at,
  #  locate the comment within the @article.comments collection,
  # and then remove it from the database and send us back to the show action for the article.
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to "/articles/#{@article.id}"
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
