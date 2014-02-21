class AppDelegate
  attr_reader :window

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    return true if RUBYMOTION_ENV == 'test'
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    search_controller = SearchController.new
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(search_controller)

    @window.styleMode = PXStylingNormal

    @window.makeKeyAndVisible
    true
  end
end
