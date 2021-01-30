describe Fastlane::Actions::CleanXcarchiveAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The clean_xcarchive plugin is working!")

      Fastlane::Actions::CleanXcarchiveAction.run(nil)
    end
  end
end
