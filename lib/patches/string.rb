class String
  ##
  # Convert to camel case.
  #
  #   "foo_bar".camel_case          #=> "fooBar"
  #
  # @return [String] Receiver converted to camel case.
  #
  # @api public
  def camel_case
    return self if self !~ /_/ && self =~ /[A-Z]+.*/
    split('_').map{|e| e.capitalize}.join.uncapitalize
  end

  def uncapitalize 
    self[0, 1].downcase + self[1..-1]
  end

  # converts a camel_cased string to a underscore string
  # subs spaces with underscores, strips whitespace
  def underscore
    self.to_s.strip.
      gsub(' ', '_').
      gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      squeeze("_").
      downcase
  end  
end