require 'fileutils'

module Modules
  class ADD
    def self.start(args)
      file_arg = args.first
      return unless file_arg

      file_path = File.expand_path(file_arg, Dir.pwd)
      appimg_path = File.join(Dir.home, ".local", "appimage")
      dest_path = File.join(appimg_path, File.basename(file_path))

      begin
        unless File.directory?(appimg_path)
          puts "\e[33m - - - [SUBP] - alm: No appimage directory found\e[0m"
          puts "\e[33m - - - [SUBP] - alm: Creating appimage directory on #{appimg_path}...\e[0m"
          FileUtils.mkdir_p(appimg_path)
          puts "\e[33m - - - [SUBP] - alm: Appimage directory created successfully\e[0m"
        end

        puts "\n>>> - alm: Adding #{file_arg} to #{dest_path}...\n"

        unless File.executable?(file_path)
          puts "\e[33m - - - [SUBP] - alm: Securing executable permissions for #{file_arg}...\e[0m"
          if system("chmod +x '#{file_path}'")
            puts "\e[33m - - - [SUBP] - alm: Executable rights granted to #{file_arg}\e[0m"
          else
            puts "\e[31m[ERROR | RUNTIME_ERROR] - alm: Failed to grant executable rights to #{file_arg}\e[0m"
            return
          end
        end

        if system("mv '#{file_path}' '#{appimg_path}'")
          puts "\n>>> - alm: #{file_arg} successfully added to #{appimg_path}\n"
        else
          puts "\e[31m[ERROR | RUNTIME_ERROR] - alm: Failed to move #{file_arg} to #{appimg_path}\e[0m"
        end

      rescue Errno::EACCES
        puts "\e[31m[ERROR | PERMISSION] - alm: Permission denied while accessing #{appimg_path}\e[0m"
      rescue => e
        puts "\e[31m[ERROR | UNEXPECTED] - alm: #{e.class} - #{e.message}\e[0m"
      end
    end
  end

  class REMOVE
    def self.start(args)
      file_arg = args.first
      return unless file_arg

      appimg_path = File.join(Dir.home, ".local", "appimage")
      file_path = File.join(appimg_path, File.basename(file_arg))

      begin
        if File.exist?(file_path)
          File.delete(file_path)
          puts "\n>>> - alm: #{File.basename(file_arg)} successfully removed from #{appimg_path}\n"
        else
          puts "\e[31m[ERROR] - alm: File #{File.basename(file_arg)} not found in #{appimg_path}\e[0m"
        end
      rescue Errno::EACCES
        puts "\e[31m[ERROR | PERMISSION] - alm: Permission denied while trying to delete #{file_path}\e[0m"
      rescue => e
        puts "\e[31m[ERROR | UNEXPECTED] - alm: #{e.class} - #{e.message}\e[0m"
      end
    end
  end
end
