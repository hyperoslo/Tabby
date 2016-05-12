import UIKit
import Tabby

class FirstController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.orangeColor()
    title = "Cows".uppercaseString
  }

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesBegan(touches, withEvent: event)

    navigationController?.pushViewController(SecondController(), animated: true)
  }
}

