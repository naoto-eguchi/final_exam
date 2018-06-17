class AddAudioToBlogs < ActiveRecord::Migration[5.1]
  def change
    add_column :blogs, :audio, :string
  end
end
