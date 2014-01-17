class CreateModels < ActiveRecord::Migration
  def change
    # One to one
    create_table :books do |t|
      t.string :title
    end

    create_table :covers do |t|
      t.references :book

      t.string :color
    end

    # One to many
    create_table :manufacturers do |t|
      t.string :name
    end

    create_table :vehicles do |t|
      t.references :manufacturer

      t.string :name
    end

    # One to many (sti)
    create_table :campaigns do |t|
      t.string :name
    end

    create_table :attachments do |t|
      t.references :campaign

      t.string :type
      t.string :name
    end
  end
end
