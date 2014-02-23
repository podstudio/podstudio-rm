class NowPlaying
  attr_accessor :player, :now_playing_info

  def initialize(params = {})
  end

  def self.sharedInstance
    Dispatch.once { @sharedInstance ||= new }
    @sharedInstance
  end

  def player(url = nil, &block)
    @player ||= BW::Media.play(url) do |player|
      block.call(player)
    end
  end

  def updateNowPlayingInfo(nowPlayingInfo = {})
    @now_playing_info = nowPlayingInfo
    MPNowPlayingInfoCenter.defaultCenter.nowPlayingInfo = @now_playing_info
  end
end
