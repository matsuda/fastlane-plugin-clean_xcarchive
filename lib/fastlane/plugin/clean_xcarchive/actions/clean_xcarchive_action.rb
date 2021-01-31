require 'fastlane/action'
require_relative '../helper/clean_xcarchive_helper'

module Fastlane
  module Actions
    class CleanXcarchiveAction < Action
      def self.run(params)

        # if default
        # e.g. :XCODEBUILD_ARCHIVE=>"/Users/xxx/Library/Developer/Xcode/Archives/2015-08-07/AppName 2015-08-07 14.49.12.xcarchive"
        unless archive_path = params[:archive_path] || Actions.lane_context[SharedValues::XCODEBUILD_ARCHIVE]
          UI.user_error!("The built archive is not specified or Please build with gym before")
          return
        end

        unless ( !archive_path.nil? && File.directory?(archive_path) )
          UI.user_error!("No such directory #{archive_path}")
          return
        end

        begin
          FileUtils.remove_dir(archive_path)
          UI.success("Successfully remove #{archive_path}")
        rescue => ex
          UI.error(ex)
          return
        end

        # e.g. /Users/xxx/Library/Developer/Xcode/Archives/2015-08-07
        archive_dir = File.dirname(archive_path)
        return unless Helper::CleanXcarchiveHelper.is_default_archive_dir?(archive_dir)
        return unless Dir.empty?(archive_dir)

        begin
          Dir.rmdir(archive_dir)
          UI.success("Successfully remove #{archive_dir}")
        rescue
        end

      end

      def self.description
        "Delete the archive created at build"
      end

      def self.authors
        ["matsuda"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        ""
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :archive_path,
                                  env_name: "CLEAN_XCARCHIVE_ARCHIVE_PATH",
                               description: "Archive path at build",
                                  optional: true,
                                      type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        [:ios].include?(platform)
      end
    end
  end
end
