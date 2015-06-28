#!/usr/bin/env ruby

# TODO: ask for backup disk, maybe have default?
drive = '/Volumes/feynman'
if !File.exists? drive
  drive = '/Volumes/yudkowsky'
  if !File.exists? drive
    puts 'Please insert your backup drive'
    exit 1
  end
end

backup_dir = "#{drive}/home"
puts "Backing up to #{backup_dir}..."

dirs = %w(books code Compositions Documents dotfiles emacs-book
Movies Music Pictures thoughts)

Dir.chdir(Dir.home) do
  dirs.each do |dir|
    if !Dir.exists?(dir)
      puts "~/#{dir} doesn't exist"
      next
    end

    puts '*' * 80
    puts "  backing up #{dir}..."
    puts '*' * 80

    # -vr: verbose, recursive
    # --size-only: don't copy files if dest and source are the same size
    # --delete: delete files in dest that aren't in source
    system("rsync -vr --size-only --delete #{Dir.home}/#{dir}/ #{backup_dir}/#{dir}")
  end
end
