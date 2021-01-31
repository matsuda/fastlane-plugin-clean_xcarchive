require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class CleanXcarchiveHelper
      # class methods that you define here become available in your action
      # as `Helper::CleanXcarchiveHelper.your_method`
      #
      def self.archive_root
        File.expand_path("~/Library/Developer/Xcode/Archives/")
      end

      def self.is_default_archive_dir?(archive_dir)
        re = Regexp.new("\^#{archive_root}\/\\d{4}-\\d{2}-\\d{2}\$")
        re.match(archive_dir) != nil
      end
    end
  end
end
