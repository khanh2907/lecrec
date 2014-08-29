class CreateUnitOfStudies < ActiveRecord::Migration
  def change
    create_table :unit_of_studies do |t|
      t.string :title
      t.string :alpha_code
      t.text :description

      t.timestamps
    end
  end
end
