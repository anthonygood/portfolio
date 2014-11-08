class Print < ActiveRecord::Base
  belongs_to :etching

  validates_presence_of :etching

  class << self
    def create_with_image(filename, filetype="jpg")
      # can be called with ("filename.extension") or ("filename", "extension")
      # or just ("filename") 
      filename, filetype = filename.split(".") if filename.split(".").length > 1

      create(
        large_url: "/#{filename}.#{filetype}", 
        thumbnail_url: "/#{filename}_thumbnail.#{filetype}"
        )
    end
  end

end
