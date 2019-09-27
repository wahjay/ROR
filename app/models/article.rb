class Article < ApplicationRecord
  # you can retrieve all the comments belonging to an article as an array using @article.comments.
  # the 'dependent: :destor'y will delete all the asoociated objects, for example:
  # when we delete an article, all its comments should also be deleted, too.
  has_many :comments, dependent: :destroy
  # Rails includes methods to help you validate the data that you send to models.
  # Validations are used to ensure that only valid data is saved into your database.
  # presence :true use to validate if an input is unique
  validates :title, presence: true, length: { minimum: 5 }
end
