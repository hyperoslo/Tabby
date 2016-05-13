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

    let controller = UIAlertController(title: "Alert", message: "This is an alert", preferredStyle: .Alert)
    let action = UIAlertAction(title: "Action", style: .Default, handler: nil)

    controller.addAction(action)

    presentViewController(controller, animated: true, completion: nil)
  }
}

