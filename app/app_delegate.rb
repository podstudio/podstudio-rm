class AppDelegate
  include CDQ
  attr_reader :window

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    return true if RUBYMOTION_ENV == 'test'
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    cdq.setup

    search_controller = SearchController.new
    player_controller = PlayerController.new
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(player_controller)

    @window.styleMode = PXStylingNormal

    @window.makeKeyAndVisible
    true
  end
end
