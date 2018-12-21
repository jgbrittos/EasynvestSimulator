require "appium_lib"

appium_txt = File.join(Dir.pwd, "features/config/appium.txt")

caps = Appium.load_appium_txt file: appium_txt, verbose: true

Appium::Driver.new(caps, true)
Appium.promote_appium_methods Object
