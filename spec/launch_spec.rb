require 'spec_helper'
require 'fakefs/spec_helpers'

describe Launch do
  include FakeFS::SpecHelpers

  it 'has a version number' do
    expect(Launch::VERSION).not_to be nil
  end

  it 'creates a launchfile' do
    launcher = Launch::Launcher.new
    launcher.create_launchfile
    expect(File.exists?("Launchfile")).to eq(true)
  end

  it 'doesnt create a launchfile if create isnt called' do
    expect(File.exists?("Launchfile")).to eq(false)
  end

  it 'reads the Launchfile' do
    l = Launch::Launcher.new
    l.create_launchfile

    launcher = read_launchfile
    expect(launcher).to_not be nil
  end

  it 'reads the launch file with correct name' do
    l = Launch::Launcher.new
    l.create_launchfile

    launcher = read_launchfile
    expect(launcher.name).to eq("PROJECT_NAME")
  end

end
