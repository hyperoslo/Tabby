import UIKit
import Tabby

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  lazy var items: [TabbyBarItem] = [
    TabbyBarItem(controller: self.firstNavigation, image: UIImage(named: "cow")),
    TabbyBarItem(controller: self.secondController, image: UIImage(named: "donut")),
    TabbyBarItem(controller: self.thirdNavigation, image: UIImage(named: "fish"))
  ]

  lazy var mainController: TabbyController = { [unowned self] in
    let controller = TabbyController(items: self.items)

    controller.delegate = self
    controller.translucent = true

    return controller
  }()

  lazy var firstNavigation: UINavigationController = UINavigationController(rootViewController: self.firstController)
  lazy var thirdNavigation: UINavigationController = UINavigationController(rootViewController: self.thirdController)

  lazy var firstController: FirstController = FirstController()
  lazy var secondController: SecondController = SecondController()
  lazy var thirdController: ThirdController = ThirdController()

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    Tabby.Constant.Color.background = UIColor.whiteColor()
    Tabby.Constant.Color.selected = UIColor(red:0.22, green:0.81, blue:0.99, alpha:1.00)

    window = UIWindow(frame: UIScreen.mainScreen().bounds)
    window?.rootViewController = mainController
    window?.makeKeyAndVisible()

    return true
  }
}

extension AppDelegate: TabbyDelegate {

  func tabbyDidPress(item: TabbyBarItem) {
    // Do your awesome transformations!
  }
}
