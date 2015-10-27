require 'find'
require 'optparse'
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
        out << "l.name = \"PROJECT_NAME\"\n"
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

# puts "Evaling launchfile"
# launch = eval(File.read('Launchfile'))
# launch.replace!
#
#
def eval_launchfile
  launch = eval(File.read('Launchfile'))
end

#create_launchfile
