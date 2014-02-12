class PlayerController < UIViewController

  def viewDidLoad
    super

    rmq.stylesheet = PlayerControllerStylesheet
    rmq(self.view).apply_style :root_view

    self.title = "Player"

    @play_stop = rmq.append(UIButton, :play_stop).get
    @play_stop.setTitle("Play", forState: UIControlStateNormal)
    @play_stop.styleClass = "button"

    url = "http://streaming.osu.edu/wosu/classical101/In_the_Key_of_Danzmayr_Composer_Performer.mp3"
    @player = BW::Media.play(url) do |player|
     @play_stop.setTitle("Stop", forState: UIControlStateNormal)
    end

    Motion::Layout.new do |layout|
      layout.view self.view
      layout.subviews "play_stop" => @play_stop
      layout.vertical     "|-50-[play_stop]-(>=50)-|"
      layout.horizontal   "|-[play_stop]-|"
    end

    rmq(@play_stop).on(:tap) do
      if @player.playbackState == MPMoviePlaybackStatePlaying
        stopPlayer
      else
        startPlayer
      end
    end
  end

  # Remove if you are only supporting portrait
  def supportedInterfaceOrientations
    UIInterfaceOrientationMaskAll
  end

  # Remove if you are only supporting portrait
  def willAnimateRotationToInterfaceOrientation(orientation, duration: duration)
    rmq.all.reapply_styles
  end

  def stopPlayer
    @play_stop.setTitle("Play", forState: UIControlStateNormal)
    @player.stop
  end

  def startPlayer
    @play_stop.setTitle("Stop", forState: UIControlStateNormal)
    @player.play
  end
end
