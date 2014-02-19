# -*- coding: utf-8 -*-
$:.unshift('/Library/RubyMotion/lib')
require 'motion/project/template/ios'
require 'bundler'
Bundler.require

require 'ruby_motion_query'
require 'rubygems'
require 'motion-pixate'
require 'bubble-wrap'
require 'bubble-wrap/all'
require 'motion-layout'
require "awesome_print_motion"
require "motion-facon"

Motion::Project::App.setup do |app|

  app.name = 'podstudio-rm'
  app.identifier = 'com.your_domain_here.podstudio-rm'
  app.short_version = '0.1.0'
  app.version = app.short_version

  app.sdk_version = '7.0'
  app.deployment_target = '7.0'
  # Or for iOS 6
  #app.sdk_version = '6.1'
  #app.deployment_target = '6.0'

  app.icons = ["icon@2x.png", "icon-29@2x.png", "icon-40@2x.png", "icon-60@2x.png", "icon-76@2x.png", "icon-512@2x.png"]

  # prerendered_icon is only needed in iOS 6
  #app.prerendered_icon = true

  app.pixate.user = 'naderhen@gmail.com'
  app.pixate.key  = 'TU9Q1-69073-D0G71-7HSPE-3H0B6-GPPBH-AJK0K-39I44-OGM0O-TA3PR-F3UMO-RN2HI-D09V7-TKKNG-G0OOT-1M'
  app.pixate.framework = 'vendor/Pixate.framework'

  app.frameworks << 'AVFoundation'
  app.frameworks << 'AudioToolbox'
  app.background_modes = [:audio]

  app.device_family = [:iphone, :ipad]
  app.interface_orientations = [:portrait, :landscape_left, :landscape_right, :portrait_upside_down]

  app.files += Dir.glob(File.join(app.project_dir, 'lib/**/*.rb'))

  app.entitlements['keychain-access-groups'] = [
    app.seed_id + '.' + app.identifier
  ]

  # Use `rake config' to see complete project settings, here are some examples:
  #
  # app.fonts = ['Oswald-Regular.ttf', 'FontAwesome.otf'] # These go in /resources
  # app.frameworks += %w(QuartzCore CoreGraphics MediaPlayer MessageUI CoreData)
  #
  # app.vendor_project('vendor/Flurry', :static)
  # app.vendor_project('vendor/DSLCalendarView', :static, :cflags => '-fobjc-arc') # Using arc
  #
  # app.pods do
  #   pod 'AFNetworking'
  # end
  app.redgreen_style = :full
end

task :"build:simulator" => :"pixate:sass"
task :"build:device" => :"pixate:sass"
