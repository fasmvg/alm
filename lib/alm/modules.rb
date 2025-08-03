module Modules
  class ADD
    def self.start(args)
      file_arg = args.first
      file_path = File.expand_path(file_arg, Dir.pwd)
    end
  end
end
