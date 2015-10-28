require 'find'
require 'optparse'
require 'git'
#require "launch/version"

# options = {}
# OptionParser.new do |opt|
#   opt.banner = "Usage: launch.rb [options]"

#   opt.on('init', "Create a Launchfile") { |o|
#     options[:init] = o
#   }
# end.parse!


module Launch
  class Launcher
    attr_accessor :name, :pattern, :replacement

    def initialize
      yield(self) if block_given?
    end

    def create_launchfile
      File.open('Launchfile', 'a') do |out|
        # out << File.read('LaunchfileTemplate')
        out << "Launch::Launcher.new do |l|\n"
        out << "  l.name = \"PROJECT_NAME\"\n"
        out << "end\n"
      end
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

# Parses the Launchfile into a Launcher object
def read_launchfile
  eval(File.read('Launchfile'))
end

# Parses the Launchfile and replaces the working directory
def eval_launcfile
  launcher = read_launchfile
  launcher.replace!
end

#TODO
def clone_repo
end

#create_launchfile
