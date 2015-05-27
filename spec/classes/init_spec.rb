require 'spec_helper'
describe 'puppet4' do

  context 'with defaults for all parameters' do
    it do
      should contain_class('puppet')
      should contain_class('puppet::params')
    end

    it do
      should compile.with_all_deps
    end
  end
end
