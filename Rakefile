# encoding: UTF-8
require "rake"

desc "install dot files to $HOME directory"
task :install do
  puts "link files"
  puts

  files = Dir['.*'] - %w[. .. .DS_Store .git .gitignore .oh-my-zsh .config]
  files = files.flatten
  files.delete_if { |x| x.match(/\. \w+\.se[a-z]/) }
  
  backup_files(files)
  link_files(files)
end

private
  
  def backup_files(files)
    run %{mkdir -p #{ENV["HOME"]}/.dotfiles_backup} unless File.exists?("#{ENV["HOME"]}/.dotfiles_backup")

    files.each do |file|
      target = "#{ENV["HOME"]}/#{file}"

        if File.exist?("#{target}")
          run %{rm -rf #{target}} if File.symlink?("#{target}")
          run %{mv #{target} #{ENV["HOME"]}/.dotfiles_backup} if File.file?("#{target}") || File.directory?("#{target}")
        end
    end
  end

  def run(cmd)
    puts "\033[0;33m[Running]\033[0m #{cmd}"
    `#{cmd}`
  end

  def link_files(files)
    files.each do |file|
      source = "#{ENV["PWD"]}/#{file}"
      target = "#{ENV["HOME"]}/#{file}"

      run %{ln -s #{source} #{target}}
    end
  end

