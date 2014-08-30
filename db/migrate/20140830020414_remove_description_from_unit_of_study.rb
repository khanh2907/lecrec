class RemoveDescriptionFromUnitOfStudy < ActiveRecord::Migration
  def change
    remove_column :unit_of_studies, :description
  end
end
