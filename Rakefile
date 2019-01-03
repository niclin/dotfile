# encoding: UTF-8

# mac 檢查 homebrew git oh-zshrc
require "rake"

GREEN = "\033[0;32m"
NONE  = "\033[0m"

desc "install dot files to $HOME directory"

task :install do
  welcome_message
  install_oh_my_zsh
  move_zsh_themes
  install_dotfile
end

private

def run(cmd)
  puts "\033[0;33m[Running]\033[0m #{cmd}"
  `#{cmd}`
end

def welcome_message
  puts GREEN + "░█▄─░█ ▀█▀ ░█▀▀█ ░█─── ▀█▀ ░█▄─░█ " + NONE
  puts GREEN + "░█░█░█ ░█─ ░█─── ░█─── ░█─ ░█░█░█ " + NONE
  puts GREEN + "░█──▀█ ▄█▄ ░█▄▄█ ░█▄▄█ ▄█▄ ░█──▀█" + NONE
  puts
  puts GREEN + "======================================================" + NONE
  puts GREEN + "Welcome to Nic Lin's DotFiles Installation."            + NONE
  puts GREEN + "======================================================" + NONE
  puts
end

def install_dotfile
  files = Dir['.*'] - %w[. .. .DS_Store .git .gitignore .oh-my-zsh .config]
  files << Dir.glob(".oh-my-zsh/custom/*")
  files << Dir.glob(".config/fish/*")
  files = files.flatten
  files.delete_if { |x| x.match(/\.\w+\.sw[a-z]/) }

  puts GREEN + "======================================================" + NONE
  puts GREEN + "Looking for existing config and backing up it..."       + NONE
  puts GREEN + "======================================================" + NONE
  puts
  backup_files(files)
end

def backup_files(files)
  run %{mkdir -p #{ENV["HOME"]}/.dotfiles_backup} unless File.exists?("#{ENV["HOME"]}/.dotfiles_backup")

  files.each do |file|
    target = "#{ENV["HOME"]}/#{file}"

    if File.exist?("#{target}")
      run %{rm -rf #{target}} if File.symlink?("#{target}")
      run %{mv #{target} #{ENV["HOME"]}/.dotfiles_backup} if File.file?("#{target}") || File.directory?("#{target}")
    end
  end
  link_files(files)
end

def link_files(files)
  puts
  puts GREEN + "======================================================" + NONE
  puts GREEN + "Setting up symbol link files..."                        + NONE
  puts GREEN + "======================================================" + NONE
  puts

  files.each do |file|
    source = "#{ENV["PWD"]}/#{file}"
    target = "#{ENV["HOME"]}/#{file}"

    run %{ln -s #{source} #{target}}
  end
  copy_setting_dirs_to_vim
end

def copy_setting_dirs_to_vim
  dirs = Dir["*"] -%w[README.md Rakefile untils images iTerm fonts]

  dirs.each do |dir|
    source = "#{Dir.pwd}/#{dir}"
    target = "#{Dir.home}/.vim/#{dir}"

    run %{ln -sF #{source} #{target}}
  end
  success_msg
end

def install_oh_my_zsh
  oh_my_zsh = "#{ENV["HOME"]}/.oh-my-zsh"
  unless File.exists?(oh_my_zsh)
    run %{curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh}
  else
    puts 'oh-my-zsh already to install'
  end
end

def move_zsh_themes
  source = "#{Dir.pwd}/.oh-my-zsh/themes/agnoster.zsh-theme"
  target = "#{Dir.home}/.oh-my-zsh/themes/agnoster.zsh-theme"

  run %{ rm -rf #{target}.backup} if File.exists?(target + ".backup")
  run %{ mv #{target} #{target}.backup}
  run %{ln -s #{source} #{target}}
end

def success_msg
  puts 'Nic dotfile intall done.'
end
