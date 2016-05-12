import UIKit
import Tabby

class FirstController: GeneralController {

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Cows".uppercaseString
    titleLabel.text = "Here be cows"
  }

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesBegan(touches, withEvent: event)

    navigationController?.pushViewController(SecondController(), animated: true)
  }
}

