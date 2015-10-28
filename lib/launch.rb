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
    attr_accessor :name, :pattern, :replacement, :template_uri

    def initialize
      yield(self) if block_given?
    end

    # Parse the Launchfile into a Launcher object
    def create_launchfile
      File.open('Launchfile', 'a') do |out|
        out << "Launch::Launcher.new do |l|\n"
        out << "  l.name = \"PROJECT_NAME\"\n"
        out << "  l.template_uri = \"git@github.com:defunkt/fakefs.git\"\n"
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

    def clone_repo!
      Git.clone(self.uri, self.name)
    end

  end
end

# Parses the Launchfile into a Launcher object
def read_launchfile
  eval(File.read('Launchfile'))
end

# Parses the Launchfile, clones the repo, and replaces the working directory
def eval_launcfile
  launcher = read_launchfile
  launcher.clone_repo!
  launcher.replace!
end
