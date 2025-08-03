module Verifications
  # Add Verification Process
  class AVP
    def self.process(path)
      return :AVP_NEXIST unless File.exist?(path)
      return :AVP_NAPPIMG unless path.downcase.end_with?(".appimage") || File.read(path, 4)&.start_with?("\x7FELF")
      :AVP_PPR # Add Verification Process (Positive Process Return)
    end
  end
end
