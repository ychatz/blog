module Util
  def self.load_config(c, options = {})
    y = YAML.load_file(File.join(Rails.root, "config", "#{c}.yml"))
    if (options[:key])
      return y[Rails.env][options[:key].to_s]
    end
    y[Rails.env]
  end
end
