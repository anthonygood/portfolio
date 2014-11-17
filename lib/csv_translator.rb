require 'csv'

class CSVTranslator
  attr_accessor :csv, :model, :column_titles

  class << self
    def read file, model
      new(file, model)
    end
  end

  def initialize(file, model)
    @model = model
    @csv = CSV.read file
    @column_titles = csv.shift
  end

  def translate
    t = csv.collect do|row| 
      row.each_with_index.inject(Translation.new invalid_keys) do |hash,(value,index)| 
        hash[column_titles[index].to_sym] = value
        hash  
      end
    end
  end

  def valid_column_titles
    column_titles.select {|col| keys.include? col }
  end

  def invalid_column_titles
    column_titles - keys
  end

  def invalid_keys
    invalid_column_titles.collect(&:to_sym)
  end

  def invalid_column_indices
    @indices ||= column_titles.each_with_index.collect do |col, i|
      i unless keys.include? col
    end.compact
  end

  private

  def keys
    model.new.attributes.keys
  end


  class Translation < Hash
    attr_accessor :invalid_keys

    def initialize keys
      @invalid_keys = keys
    end

    def filter
      keep_if { |k, v| !invalid_keys.include? k }
    end

  end

end
