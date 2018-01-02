require 'spec_helper'

require 'ostruct'

describe Composer::Import do

  let(:klass) do
    Class.new do
      include Composer::Import
    end
  end

  context do
    let(:path)     { OpenStruct.new(current_path: current_path, index: -1) }
    let(:previous) { nil }
    let(:context)  {{}}

    subject do
      klass.next(path, context, previous)
    end

    context do
      let(:current_path) { 'whatever path' }

      it do
        expect(subject.source_path).to eql(current_path)
      end
    end
  end
end
