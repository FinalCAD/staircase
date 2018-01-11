require 'spec_helper'

describe Composer::Lib::SafePath do
  [
    { initial_path: '',                           escaped_path: ''                              },
    { initial_path: '/a/path/',                   escaped_path: '/a/path/'                      },
    { initial_path: '/a/path/need to be escaped', escaped_path: '/a/path/need\ to\ be\ escaped' }
  ].each do |info|
    it do
      expect(described_class.new(info[:initial_path]).path.to_s).to eql(info[:initial_path])
      expect(described_class.new(info[:initial_path]).path.escaped).to eql(info[:escaped_path])
    end
  end
end
