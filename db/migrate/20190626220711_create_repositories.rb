class CreateRepositories < ActiveRecord::Migration[5.1]
  def change
    create_table :repositories do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.string :description
      t.boolean :private, default: false
      t.integer :team_id
      t.boolean :has_issues, default: true
      t.boolean :has_projects, default: true
      t.boolean :has_wiki, default: true

      t.timestamps
    end
  end
end
