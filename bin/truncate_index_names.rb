#!/usr/bin/env ruby

filename = ARGV[0]
unless File.exists? filename
  puts "File #{filename} doesn't exist"
  exit 1
end

lines = IO.readlines filename
modified_lines = []

lines.each do |line|
  if line !~ / +add_index/
    modified_lines << line
    next
  end

  matches = /:name => "([a-zA-Z0-9_]+)"/.match line
  if matches.nil? || matches[1].length < 63
    modified_lines << line
    next
  end

  puts "before: #{line}"

  index_name = matches[1]
  until index_name.length < 63
    index_name.sub!(/([^_])[^_]+/, '\1')
  end

  truncated_index_line = line.gsub(matches[1], index_name)
  puts "after: #{truncated_index_line}"

  modified_lines << truncated_index_line
end

File.open(filename, 'w') { |file| file.puts modified_lines }
