Puppet::Functions.create_function(:'puppet4::make_boolean') do
  dispatch :make_boolean_from_string do
    param 'String', :value
  end

  dispatch :make_boolean_from_integer do
    param 'Integer', :value
  end

  dispatch :return_value do
    param 'Boolean', :value
  end

  dispatch :return_false do
    param 'Undef', :false
  end

  def return_value( value )
    return value
  end

  def return_false( value )
    return false
  end

  def make_boolean_from_integer( value )
    return value == 0 ? false : true
  end

  def make_boolean_from_string( value )
    case value
    when /^\s*(?i:false|no|n|off)\s*$/
      return false
    when ''
      return false
    when /^\s*0+\s*$/
      return false
    else
      return true
    end
  end
end
