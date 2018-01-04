require 'spec_helper'

describe Composer::Converter::PdfToImage do
  let(:instance) { described_class.new(double(:file, path: 'file_path'), options) }
  let(:options) { {} }

  describe '#process' do
    subject { instance.process }
    let(:temp_args) { %w[input .png] }

    before do
      expect(Tempfile).to receive(:new).with(temp_args).and_return(double(:tempfile, path: 'temp_path'))
    end

    it 'calls the right command' do
      expect(described_class).to receive(:run_command).with('convert -alpha opaque -flatten file_path temp_path')
      subject
    end

    context 'with options' do
      let(:temp_args) { %w[input .ext] }
      let(:options) { { convert_options: %w[blah bah], extension: 'ext' } }

      it 'calls the right command' do
        expect(described_class).to receive(:run_command).with('convert -alpha opaque -flatten blah bah file_path temp_path')
        subject
      end
    end
  end
end
