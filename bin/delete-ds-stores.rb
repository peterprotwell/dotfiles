#!/usr/bin/env ruby

def delete_ds_store(path)
  ds_store = "#{path}/.DS_Store"

  if File.exists? ds_store
    puts "Deleting #{ds_store}"
    File.delete ds_store
  end

  Dir.foreach(path) do |entry|
    next if entry =~ /\.\.?/

    delete_ds_store("#{path}/#{entry}") if File.directory?("#{path}/#{entry}")
  end
end

delete_ds_store Dir.home
