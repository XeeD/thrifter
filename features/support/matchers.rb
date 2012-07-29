require 'digest/md5'

RSpec::Matchers.define :be_the_same_file_as do |expected|
  match do |actual|
    hexdigest(actual) == hexdigest(expected)
  end

  def hexdigest(filename)
    Digest::MD5.hexdigest(File.read(filename))
  end
end