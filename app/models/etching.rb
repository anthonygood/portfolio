class Etching < ActiveRecord::Base
  attr_accessor :filetype

  validates :title, presence: true, string: true
  validates_with StringValidator, attributes: [:description, :notes, :large_img_url, :thumbnail_url], allow_blank: true
  validates_numericality_of :height, :width, :plates, :print_run, { only_integer: true, allow_blank: true }
  validates :date_created_before_type_cast, { year: true, allow_blank: true }

  before_save :set_urls

  private

  def set_urls
    title = to_filename(self.title)
    @filetype = 'jpg' unless @filetype

    self.thumbnail_url = "/#{title}_thumbnail.#{@filetype}"
    self.large_img_url = "/#{title}.#{@filetype}"
  end

  def to_filename(string)
    string.gsub(' ', '_').
    downcase
  end

end
