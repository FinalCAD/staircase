require 'spec_helper'

describe Composer::Lib::SafePath do
  [
    { initial_path: nil,                          resul_path: ''                              },
    { initial_path: '',                           resul_path: ''                              },
    { initial_path: '/a/path/',                   resul_path: '/a/path/'                      },
    { initial_path: '/a/path/need to be escaped', resul_path: '/a/path/need\ to\ be\ escaped' }
  ].each do |info|
    it { expect(described_class.new(info[:initial_path]).path).to eql(info[:resul_path]) }
  end
end
