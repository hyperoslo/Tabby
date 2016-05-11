import UIKit
import Tabby

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  lazy var mainController: TabbyController = { [unowned self] in
    let controller = TabbyController()
    controller.controllers = [
      (self.firstNavigation, nil),
      (self.secondController, nil),
      (self.thirdNavigation, nil)
    ]

    return controller
  }()

  lazy var firstNavigation: UINavigationController = {
    let controller = UINavigationController(rootViewController: self.firstController)
    controller.title = "First"
    
    return controller
  }()

  lazy var secondController: SecondController = {
    let controller = SecondController()
    controller.title = "Second"

    return controller
  }()

  lazy var thirdNavigation: UINavigationController = {
    let controller = UINavigationController(rootViewController: self.thirdController)
    controller.title = "Third"

    return controller
  }()

  lazy var firstController: FirstController = FirstController()
  lazy var thirdController: ThirdController = ThirdController()

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    window = UIWindow(frame: UIScreen.mainScreen().bounds)
    window?.rootViewController = mainController
    window?.makeKeyAndVisible()

    return true
  }
}
