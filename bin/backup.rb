#!/usr/bin/env ruby

backup_dir = '/media/mike/Backups\!/mike/home'

dirs = %w(books code Compositions Documents dotfiles emacs-book
Movies Music Pictures sheet-music thoughts)

Dir.chdir(ENV['HOME']) do
  dirs.each do |dir|
    if !Dir.exists?(dir)
      puts "~/#{dir} doesn't exist"
      next
    end

    system("rsync -vr --size-only #{ENV['HOME']}/#{dir}/ #{backup_dir}/#{dir}")
  end
end
