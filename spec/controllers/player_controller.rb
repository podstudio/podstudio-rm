describe 'PlayerController' do
  tests PlayerController
  extend Facon::SpecHelpers

  before do
  end

  after do
  end

  describe "viewDidLoad" do
    it "should have the correct title" do
      controller.title.should == "Player"
    end
  end

  describe "play_stop button" do
    before do
      @play_stop_button = controller.instance_variable_get("@play_stop")
    end

    it "should have a play_stop button" do
      @play_stop_button.should.not == nil
    end

    it "should be a descendant of the controller's view" do
      @play_stop_button.isDescendantOfView(controller.view).should == true
    end

    it "should have the correct title" do
      @play_stop_button.currentTitle.should == "STOP"
    end

    it "should be in the correct position" do
      expected_rect = CGRectMake(20, 50, 280, 32)
      @play_stop_button.frame.should == expected_rect
    end

    it "should call stopPlayer when audio is playing" do
      controller.should.receive(:stopPlayer)

      @player = controller.instance_variable_get("@player")
      @player.play
      tap @play_stop_button
    end

    it "should call startPlayer when audio is stopped" do
      controller.should.receive(:startPlayer)

      @player = controller.instance_variable_get("@player")
      @player.stop
      tap @play_stop_button
    end
  end

  describe "AVAudioSession" do
    it "should set the delegate" do
      AVAudioSession.sharedInstance.delegate.should == controller
    end

    it "should set the category" do
      AVAudioSession.sharedInstance.category.should == AVAudioSessionCategoryPlayback
    end
  end

  describe "stopPlayer" do
    before do
      @player = controller.instance_variable_get("@player")
      @play_stop_button = controller.instance_variable_get("@play_stop")
    end

    it "should set the button title" do
      controller.stopPlayer
      @play_stop_button.currentTitle.should == "Play"
    end

    it "should stop the player" do
      controller.stopPlayer
      @player.playbackState.should == MPMoviePlaybackStateStopped
    end
  end

  describe "startPlayer" do
    before do
      @player = controller.instance_variable_get("@player")
      @play_stop_button = controller.instance_variable_get("@play_stop")
    end

    it "should set the button title" do
      controller.startPlayer
      @play_stop_button.currentTitle.should == "Stop"
    end

    it "should stop the player" do
      controller.startPlayer
      @player.playbackState.should == MPMoviePlaybackStatePlaying
    end
  end
end
