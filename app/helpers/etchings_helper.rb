module EtchingsHelper
  def colours_mentioned(string)
    colours = [/red/i, /blue/i, /yellow/i]

    colours.inject({}) do |hash, colour|
      hash.tap {|hash| hash[colour.source.to_sym] = string.scan(colour).count }
    end.reject { |k,v| v < 1 }
  end
end
