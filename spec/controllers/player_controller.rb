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
      expected_rect = CGRectMake(0, 20, 100, 32)
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

  describe "thumbnail" do
    before do
      @thumbnail = controller.instance_variable_get("@thumbnail")
    end

    it "should have a thumbnail view" do
      @thumbnail.should.not == nil
    end

    it "should be a descendant of the controller's view" do
      @thumbnail.isDescendantOfView(controller.view).should == true
    end

    it "should be in the correct position" do
      expected_rect = CGRectMake(0, 0, 320, 300)
      @thumbnail.frame.should == expected_rect
    end
  end

  describe "podcast_title" do
    before do
      @podcast_title = controller.instance_variable_get("@podcast_title")
    end

    it "should have a podcast_title view" do
      @podcast_title.should.not == nil
    end

    it "should be a descendant of the controller's view" do
      @podcast_title.isDescendantOfView(controller.view).should == true
    end

    it "should have the correct text" do
      @podcast_title.text.should == "How Did This Get Made"
      @podcast_title.styleClass.should == "h3"
    end

    it "should be in the correct position" do
      expected_rect = CGRectMake(20, 308, 280, 22)
      @podcast_title.frame.should == expected_rect
    end
  end

  describe "episode_title" do
    before do
      @episode_title = controller.instance_variable_get("@episode_title")
    end

    it "should have a episode_title view" do
      @episode_title.should.not == nil
    end

    it "should be a descendant of the controller's view" do
      @episode_title.isDescendantOfView(controller.view).should == true
    end

    it "should have the correct text" do
      @episode_title.text.should == "Wicker Man"
      @episode_title.styleClass.should == "h5"
    end

    it "should be in the correct position" do
      expected_rect = CGRectMake(20, 341, 280, 20)
      @episode_title.frame.should == expected_rect
    end
  end

  describe "playback_view" do
    before do
      @playback_view = controller.instance_variable_get("@playback_view")
    end

    it "should have a playback_view view" do
      @playback_view.should.not == nil
    end

    it "should be a descendant of the controller's view" do
      @playback_view.isDescendantOfView(controller.view).should == true
    end

    it "should be in the correct position" do
      expected_rect = CGRectMake(20, 369, 280, 72)
      @playback_view.frame.should == expected_rect
    end
  end

  describe "start_time" do
    before do
      @playback_view = controller.instance_variable_get("@playback_view")
      @start_time = controller.instance_variable_get("@start_time")
    end

    it "should have a start_time view" do
      @start_time.should.not == nil
    end

    it "should be a descendant of the controller's view" do
      @start_time.isDescendantOfView(@playback_view).should == true
    end

    it "should have the correct text" do
      @start_time.text.should == "00:00"
      @start_time.styleClass.should == "h5"
    end

    it "should be in the correct position" do
      expected_rect = CGRectMake(115, 50, 50, 20)
      @start_time.frame.should == expected_rect
    end
  end

  describe "end_time" do
    before do
      @playback_view = controller.instance_variable_get("@playback_view")
      @end_time = controller.instance_variable_get("@end_time")
    end

    it "should have a end_time view" do
      @end_time.should.not == nil
    end

    it "should be a descendant of the controller's view" do
      @end_time.isDescendantOfView(@playback_view).should == true
    end

    it "should have the correct text" do
      @end_time.text.should == "12:34"
      @end_time.styleClass.should == "h5"
    end

    it "should be in the correct position" do
      expected_rect = CGRectMake(210, 50, 50, 20)
      @end_time.frame.should == expected_rect
    end
  end

  describe "slider" do
    before do
      @playback_view = controller.instance_variable_get("@playback_view")
      @slider = controller.instance_variable_get("@slider")
    end

    it "should have a slider view" do
      @slider.should.not == nil
    end

    it "should be a descendant of the controller's view" do
      @slider.isDescendantOfView(@playback_view).should == true
    end

    it "should be in the correct position" do
      expected_rect = CGRectMake(113, 20, 169, 34)
      @slider.frame.should == expected_rect
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
