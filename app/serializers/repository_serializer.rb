class RepositorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :private, :has_issues, :has_projects, :has_wiki

  belongs_to :user
end
