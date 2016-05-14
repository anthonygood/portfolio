class RemoveRedundantFields < ActiveRecord::Migration

  def change
	  # REMOVE THEMES
	  drop_table :themes

	  # REMOVE ETCHING-THEMES JOIN TABLE
	  drop_table :etchings_themes

	  # ETCHINGS:
	  change_table :etchings do |t|
		  # remove width
		  # remove plates
		  # remove print_run
		  # remove year
		  # remove price
	  	t.remove :height, :width, :plates, :print_run, :year, :price
	  end

	  # PRINTS:
	  change_table :prints do |t|
		  # remove thumbnail_url
		  # remove tags
		  # remove medium_url
	  	t.remove :thumbnail_url, :tags, :medium_url
	  end
	end
end
