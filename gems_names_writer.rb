# frozen_string_literal: true

class GemsNamesWriter
  def initialize(letter, gems)
    @letter = letter
    @gems = gems
    @gems_keeper = "yamls/gems_#{letter.downcase}_keeper.yml"
  end

  def to_hash
    gems.map.with_index.with_object({}) { |(item, index), hash| hash[index + 1] = item }
  end

  def to_yml(hash)
    File.write(gems_keeper, hash.to_yaml)
  end

  private

  attr_reader :result, :gems
  attr_accessor :gems_keeper
end
