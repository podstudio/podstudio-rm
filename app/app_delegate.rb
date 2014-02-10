class AppDelegate
  attr_reader :window

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    player_controller = PlayerController.new
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(player_controller)

    @window.styleMode = PXStylingNormal

    @window.makeKeyAndVisible
    true
  end
end
