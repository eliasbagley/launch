require 'find'
require 'optparse'
#require "launch/version"

options = {}
OptionParser.new do |opt|
  opt.banner = "Usage: launch.rb [options]"

  opt.on('init', "Create a Launchfile") { |o|
    options[:init] = o
  }
end.parse!

def create_launchfile
  File.open('Launchfile', 'w') do |out|
    out << File.read('LaunchfileTemplate')
  end
end

module Launch
  class Launcher
    attr_accessor :name, :pattern, :replacement

    def initialize
      yield(self) if block_given?
    end


    def replace!
      Find.find("#{__dir__}").each do |filename|
        if not FileTest.directory?(filename)
          outdata = File.read(filename).gsub(/#{self.pattern}/, self.replacement)

          File.open(filename, 'w') do |out|
            out << outdata
          end
        end
      end

    end
  end
end

# puts "Evaling launchfile"
# launch = eval(File.read('Launchfile'))
# launch.replace!
#

#create_launchfile
