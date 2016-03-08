Puppet::Functions.create_function(:'puppet4::get_subnet') do
  def get_subnet( address, netmask )
    if !address.nil?
      ip = IPAddr.new( address )
      return ip.mask( netmask ).to_s
    end
  end
end

