class Print < ActiveRecord::Base
  belongs_to :etching

  validates_presence_of :etching

  class << self
    def create_with_image(etching, filetype="jpg", notes=nil)
      filename  = to_snake_case(etching.title)
      increment = incrementor(etching)
      filename << increment if increment

      create!(
        etching:       etching,
        large_url:     "/#{filename}.#{filetype}", 
        thumbnail_url: "/#{filename}_thumbnail.#{filetype}",
        notes:         notes
        )
    end

    def to_snake_case(string)
      string.tr(' ', '_').downcase
    end

    def incrementor(etching)
      "_#{etching.prints.count + 1}" if etching.prints.count > 0
    end
  end

end
