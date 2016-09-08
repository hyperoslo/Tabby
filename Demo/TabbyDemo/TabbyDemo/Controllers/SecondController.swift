import UIKit

class SecondController: GeneralController {

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    title = "Donut".uppercaseString
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    titleLabel.text = "Who doesn't like some donuts?"
  }

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesBegan(touches, withEvent: event)

    let controller = UIAlertController(title: "Alert", message: "This is an alert", preferredStyle: .Alert)
    let action = UIAlertAction(title: "Action", style: .Default, handler: nil)

    controller.addAction(action)

    presentViewController(controller, animated: true, completion: nil)
  }
}
