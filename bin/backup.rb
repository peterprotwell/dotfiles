#!/usr/bin/env ruby

def find_backup_drive
  %w(yudkowsky feynman Tyson).each do |disk|
    return disk if File.exists? "/Volumes/#{disk}"
  end

  puts 'Please insert your backup drive' and exit 1
end

drive = find_backup_drive
backup_dir = "/Volumes/#{drive}/home"
puts "Backing up to #{backup_dir}..."

dirs = %w(books code Compositions Documents dotfiles emacs-book
Movies Music Pictures thoughts)

system("mkdir -p #{backup_dir}")
Dir.chdir(Dir.home) do
  dirs.each do |dir|
    puts "~/#{dir} doesn't exist" and next if !Dir.exists?(dir)

    puts '*' * 80
    puts "  backing up #{dir}..."
    puts '*' * 80

    # -vr: verbose, recursive
    # --size-only: don't copy files if dest and source are the same size
    # --delete: delete files in dest that aren't in source
    system("rsync -vr --size-only --delete #{Dir.home}/#{dir}/ #{backup_dir}/#{dir}")
  end
end
