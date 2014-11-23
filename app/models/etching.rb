class Etching < ActiveRecord::Base
  attr_accessor :filetype

  validates :title, presence: true, string: true
  validates_with StringValidator, attributes: [:long_description, :short_description, :notes], allow_blank: true
  validates_numericality_of :height, :width, :plates, :print_run, { only_integer: true, allow_blank: true }
  validates :year, { year: true, allow_blank: true }

  has_many :prints, dependent: :destroy

  scope :landscape, -> { where('width > height') }
  scope :portrait,  -> { where('height > width') }
  scope :listed,    -> { where(listed: true)     }
  scope :unlisted,  -> { where(listed: false)    }  

  class << self
    def create_with_prints(attributes={})
      raise ArgumentError, "You must specify how many prints to create" unless attributes[:versions]

      etching = create! attributes.except(:versions)

      attributes[:versions].each do |version|
        Print.create_with_image(etching, "jpg", version)
      end

      etching
    end
  end

  def orientation
    return nil unless width && height
    if width > height
      "landscape"
    else
      "portrait"
    end
  end
end
