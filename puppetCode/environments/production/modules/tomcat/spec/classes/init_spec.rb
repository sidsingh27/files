require 'spec_helper'
describe 'tomcat' do
  context 'with default values for all parameters' do
    it { should contain_class('tomcat') }
  end
end
