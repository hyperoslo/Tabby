import UIKit
import Tabby

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  lazy var items: [TabbyBarItem] = [
    TabbyBarItem(controller: self.firstNavigation, image: "cow"),
    TabbyBarItem(controller: self.secondController, image: "donut"),
    TabbyBarItem(controller: self.thirdNavigation, image: "fish")
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

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    Tabby.Constant.Color.background = UIColor.white
    Tabby.Constant.Color.selected = UIColor(red:0.22, green:0.81, blue:0.99, alpha:1.00)

    Tabby.Constant.Behavior.labelVisibility = .activeVisible

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = mainController
    window?.makeKeyAndVisible()

    return true
  }
}

extension AppDelegate: TabbyDelegate {

  func tabbyDidPress(_ item: TabbyBarItem) {
    // Do your awesome transformations!

    if items.index(of: item) == 1 {
      mainController.barHidden = true
    }

    let when = DispatchTime.now() + 2
    DispatchQueue.main.asyncAfter(deadline: when) {
      self.mainController.barHidden = false
    }
  }
}
