class Etching < ActiveRecord::Base
  attr_accessor :title, 
                :date, 
                :height, 
                :width, 
                :plates,
                :print_run,
                :description,
                :notes

  validates :title, presence: true, string: true
  validates_with StringValidator, attributes: [:description, :notes], allow_blank: true
  validates_numericality_of :date, :height, :width, :plates, :print_run, { only_integer: true }

  before_save :set_urls

  private

  def set_urls
    title = to_filename(self.title)
    self.thumbnail_url = "/images/#{title}_thumbnail.jpeg"
    self.large_img_url = "/images/#{title}.jpeg"
  end

  def to_filename(string)
    string.gsub!(' ', '_').
    downcase
  end


end
