class PlayerController < UIViewController

  def viewDidLoad
    super

    rmq.stylesheet = PlayerControllerStylesheet
    rmq(self.view).apply_style :root_view

    self.title = "Player"

    AVAudioSession.sharedInstance.setDelegate(self)
    AVAudioSession.sharedInstance.setCategory(AVAudioSessionCategoryPlayback, error:nil)
    UIApplication.sharedApplication.beginReceivingRemoteControlEvents
    AVAudioSession.sharedInstance.setActive(true, error:nil)

    @thumbnail = rmq.append(UIImageView, :thumbnail).get
    @thumbnail.backgroundColor = UIColor.blackColor
    @thumbnail.url = "http://cdn.earwolf.com/wp-content/uploads/2011/04/HDTGMFULL.jpg"

    @podcast_title = rmq.append(UILabel, :podcast_title).get
    @podcast_title.text = "How Did This Get Made"
    @podcast_title.styleClass = "h3"

    @episode_title = rmq.append(UILabel, :episode_title).get
    @episode_title.text = "Wicker Man"
    @episode_title.styleClass = "h5"

    @playback_view = rmq.append(UIView, :playback_view).get

    @play_stop = rmq(@playback_view).append(UIButton, :play_stop).get
    @play_stop.setTitle("Play", forState: UIControlStateNormal)
    @play_stop.styleClass = "button"

    @start_time = rmq(@playback_view).append(UILabel, :start_time).get
    @start_time.text = "00:00"
    @start_time.styleClass = "h5"

    @end_time = rmq(@playback_view).append(UILabel, :end_time).get
    @end_time.text = "12:34"
    @end_time.styleClass = "h5"

    @slider = rmq(@playback_view).append(UISlider, :slider).get
    @slider.continuous = false
    rmq(@slider).on(:change) do
      seekToValue(@slider.value)
    end

    url = "http://feeds.soundcloud.com/stream/133946490-hdtgm-82-double-team-w-owen-burke.mp3"
    @player = BW::Media.play(url) do |player|
      @play_stop.setTitle("STOP", forState: UIControlStateNormal)
      startTimer
    end

    @duration_observer = App.notification_center.observe 'MPMovieDurationAvailableNotification' do |notification|
      duration = @player.duration
      @slider.maximumValue = duration
      @end_time.text = formatted_time(duration)
      updateNowPlayingInfo(@player)
    end

    Motion::Layout.new do |layout|
      layout.view self.view
      layout.subviews "thumbnail" => @thumbnail, "podcast_title" => @podcast_title,
                      "episode_title" => @episode_title, "playback_view" => @playback_view
      layout.metrics "zero" => 0, "thumbnail_height" => 300
      layout.vertical     "|-zero-[thumbnail(thumbnail_height)]-[podcast_title]-[episode_title]-[playback_view]-(>=zero)-|"
      layout.horizontal   "|-zero-[thumbnail]-zero-|"
      layout.horizontal   "|-[podcast_title]-|"
      layout.horizontal   "|-[episode_title]-|"
      layout.horizontal   "|-[playback_view]-|"
    end

    Motion::Layout.new do |layout|
      layout.view @playback_view
      layout.subviews "play_stop" => @play_stop, "start_time" => @start_time,
                      "end_time" => @end_time, "slider" => @slider
      layout.metrics "zero" => 0, "top" => 50, "button_size" => 100, "button_size_with_margin" => 115, "text_width" => 60
      layout.vertical  "|-[play_stop]-|"
      layout.vertical  "|-[slider]-(>=zero)-|"
      layout.vertical  "|-top-[start_time]-(>=zero)-|"
      layout.vertical  "|-top-[end_time]-(>=zero)-|"
      layout.horizontal "|-zero-[play_stop(==button_size)]-(>=zero)-|"
      layout.horizontal "|-button_size_with_margin-[slider]-(<=zero)-|"
      layout.horizontal "|-button_size_with_margin-[start_time(==text_width)]-(>=zero)-[end_time(==text_width)]-zero-|"
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

  def viewWillDisappear(animated)
    App.notification_center.unobserve @duration_observer
    stopTimer
  end

  def remoteControlReceivedWithEvent(event)
    case event.subtype
    when UIEventSubtypeRemoteControlPlay
      startPlayer
    when UIEventSubtypeRemoteControlPause
      stopPlayer
    when UIEventSubtypeRemoteControlNextTrack
      seekToValue(@player.currentPlaybackTime + 15)
    when UIEventSubtypeRemoteControlPreviousTrack
      seekToValue(@player.currentPlaybackTime - 15)
    end
  end

  def stopPlayer
    @play_stop.setTitle("Play", forState: UIControlStateNormal)
    @player.pause
    stopTimer
  end

  def startPlayer
    @play_stop.setTitle("Stop", forState: UIControlStateNormal)
    @player.play
    startTimer
  end

  def startTimer
    @timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target:self, selector:'playerTick', userInfo:nil, repeats:true)
  end

  def stopTimer
    if !@timer.nil?
      @timer.invalidate
      @timer = nil
    end
  end

  def playerTick
    current_time = @player.currentPlaybackTime

    @slider.value = current_time
    @start_time.text = formatted_time(current_time)
  end

  def seekToValue(value)
    @player.currentPlaybackTime = value
  end

  def updateNowPlayingInfo(player)
    nowPlayingInfo = {
      MPMediaItemPropertyTitle => "Wicker Man",
      MPMediaItemPropertyArtist => "How Did This Get Made",
      MPMediaItemPropertyPlaybackDuration => player.duration,
      MPNowPlayingInfoPropertyElapsedPlaybackTime => player.currentPlaybackTime,
      MPNowPlayingInfoPropertyPlaybackRate => player.currentPlaybackRate
    }

    if !@thumbnail.image.nil?
      nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork.alloc.initWithImage(@thumbnail.image)
    end

    MPNowPlayingInfoCenter.defaultCenter.nowPlayingInfo = nowPlayingInfo
  end

  def formatted_time(total_seconds)
    return "00:00:00" if total_seconds.nil? || total_seconds.nan?
    seconds = (total_seconds % 60) || 0
    minutes = (total_seconds / 60) % 60 || 0
    hours = total_seconds / 3600 || 0

    formatted_seconds = "%02d" % seconds
    formatted_minutes = "%02d" % minutes
    formatted_hours = "%02d" % hours
    "#{formatted_hours}:#{formatted_minutes}:#{formatted_seconds}"
  end
end
