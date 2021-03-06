require 'pp'
require 'irb/completion'
require 'rubygems'
begin
  require 'what_methods'

  # wirble is amazing
  require 'wirble'
  Wirble.init
  Wirble.colorize
rescue LoadError
  # bundle console
end

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 9999

# from http://themomorohoax.com/2009/03/27/irb-tip-load-files-faster
def ls
  %x{ls}.split("\n")
end

def cd(dir)
  Dir.chdir(dir)
  Dir.pwd
end

def pwd
  Dir.pwd
end

def meth(thing)
  (thing.methods - Object.methods).sort
end

# also from http://themomorohoax.com/2009/03/27/irb-tip-load-files-faster
def reload(file_name = nil)
  if file_name.nil?
    if !@recent.nil?
      reload(@recent)
    else
      puts "No recent file to reload"
    end
  else
    file_name += '.rb' unless file_name =~ /\.rb/
    @recent = file_name
    load "#{file_name}"
  end
end
