#!/usr/bin/env ruby

$files = {}

def recursive_copy(root)
  Dir.foreach(root) do |entry|
    next if entry =~ /^\./

    full_path = "#{root}/#{entry}"

    if File.directory?(full_path)
      recursive_copy full_path
    else
      if entry =~ /(mp3|m4a|m4p|wav)$/i
        # puts "Moving #{full_path}..."
        entry = entry[1..-1] while entry =~ /^[0-9-_]/
        entry.strip!
        # puts entry

        dest_filename = "/home/mike/Music/m/#{entry}"

        if $files[dest_filename]
          puts "duplicate file: #{dest_filename}"
        else
          $files[dest_filename] = true
          # all good
        end
        # system("echo 'mv #{full_path} /home/mike/Music/m/#{entry}'")
      elsif entry =~ /(itc|itl|ipa)$/
        # Nope
      else
        # puts entry
      end
    end

  end
end

recursive_copy "/home/mike/Music/iTunes"
