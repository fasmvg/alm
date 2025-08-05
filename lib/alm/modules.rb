require 'fileutils'

module Modules
  class ADD
    def self.start(args)
      file_arg = args.first
      file_path = File.expand_path(file_arg, Dir.pwd)

      appimg_path = File.join(Dir.home, ".local", "appimage")

      begin
        unless File.directory?(appimg_path)
          puts "\e[33m- - - - [SUBP] - alm: No appimage directory founded\e[0m"
          puts "\e[33m- - - - [SUBP] - alm: Creating appimage directory on #{appimg_path}...\e[0m"
          FileUtils.mkdir_p(appimg_path)
          puts "\e[33m- - - - [SUBP] - alm: appimage directory created on #{appimg_path} successfully\e[0m"
        else
          puts "[P] - alm: Adding #{file_arg} to #{file_path}..."

          unless File.executable?(file_path)
            puts "\e[33m- - - - [SUBP] - alm: Securing Executable Permissions to #{file_arg}..."
            if system("chmod +x '#{file_path}'")
              puts "\e[33m- - - - [SUBP] - alm: Executable rights granted to the #{file_arg}Executable rights granted to #{file_arg}"
            else
              puts "[ERROR | RUNTIME_ERROR] - alm: Failed to grant executable rights to #{file_arg}"
            end
          end

          if system("mv '#{file_path}' #{appimg_path}")
            puts "[P+] - alm: #{file_arg} successfully added to destination"
          else
            puts "[ERROR | RUNTIME_ERROR] - alm: Failed to add #{file_arg} to destination"
          end
        end
      rescue Errno::EACCES
        puts "[ERROR | Errno::EACCES] - alm: Permission denied"
      rescue => e
        puts "[ERROR | Unexpected error]: #{e.class} - #{e.message}"
      end

    end
  end
end
