# frozen_string_literal: true

require './gems_names_writer'
require 'yaml'

RSpec.describe GemsNamesWriter do
  let(:data) { { letter: 'b' } }
  let(:titles) { %w[b b001e B_123 b189877-1 b1_config] }
  let(:writer) { described_class.new(data[:letter], titles) }

  describe '#to_hash' do
    let(:hash) { writer.to_hash }

    it 'creates right object' do
      expect(hash).to include(
        1 => 'b', 2 => 'b001e', 3 => 'B_123',
        4 => 'b189877-1', 5 => 'b1_config'
      )
    end
  end

  describe '#to_yml(hash)' do
    let(:fake_file_name) { "spec/fixtures/gems_#{data[:letter]}_keeper.yml" }
    let(:file_content) { YAML.safe_load(File.open(fake_file_name)) }
    let(:hash) { writer.to_hash }

    before do
      writer.send(:gems_keeper=, fake_file_name)
      writer.to_yml(hash)
    end

    it 'writes expected content' do
      expect(file_content).to eq(hash)
    end
  end
end
