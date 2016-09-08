import UIKit
import Tabby

class FirstController: GeneralController {

  lazy var blurView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.orangeColor()

    return view
  }()

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    title = "Cows".uppercaseString
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(blurView)

    titleLabel.text = "Here be cows"
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    blurView.frame = CGRect(x: 0, y: view.frame.height - 100, width: 100, height: 100)
  }

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesBegan(touches, withEvent: event)

    let controller = UIAlertController(title: "Alert", message: "This is an alert", preferredStyle: .Alert)
    let action = UIAlertAction(title: "Action", style: .Default, handler: nil)

    controller.addAction(action)

    presentViewController(controller, animated: true, completion: nil)
  }
}

