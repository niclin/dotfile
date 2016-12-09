# encoding: UTF-8
require "rake"

desc "install dot files to $HOME directory"
task :install do
  puts "link files"
  puts

  files = Dir['.*'] - %w[. .. .DS_Store .git .gitignore .oh-my-zsh .config]
  files = files.flatten
  files.delete_if { |x| x.match(/\. \w+\.se[a-z]/) }

  link_file(files)
end

private

  def run(cmd)
    puts "\033[0;33m[Running]\033[0m #{cmd}"
    `#{cmd}`
  end

  def link_file(files)
    files.each do |file|
      source = "#{ENV["PWD"]}/#{file}"
      target = "#{ENV["HOME"]}/#{file}"

      run %{ln -sf #{source} #{target}}
    end
  end

