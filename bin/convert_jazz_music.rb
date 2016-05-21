#!/usr/bin/env ruby

Dir.chdir('/Users/mike/Dropbox/Jazz band charts') do
  Dir.glob('*') do |filename|
    ext = File.extname(filename)

    # Skip pdfs that don't start with number
    next if ext == '.pdf' && filename =~ /\A[a-zA-Z]/

    # Move pictures into picture folder
    if %w(.png .jpg).include? File.extname(filename)
      print "Move #{filename} to pictures/#{filename}? "
      response = gets.chomp
      File.rename(filename, "pictures/#{filename}") if response == 'y'
    end

    # if pdf starts with number, ask to rename
    if ext == '.pdf' && filename =~ /\A[0-9]/
      new_filename = filename
      new_filename = new_filename[1..-1] while new_filename =~ /\A[^a-zA-Z]/
      new_filename.sub!(/Big-Band-(Score-)?/, '')

      print "Rename #{filename} to #{new_filename}? "

      response = gets.chomp
      File.rename(filename, new_filename) if response == 'y'
      next
    end
  end
end
