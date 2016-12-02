import UIKit

class SecondController: GeneralController {

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    title = "Donut".uppercased()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    titleLabel.text = "Who doesn't like some donuts?"
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)

    let controller = UIAlertController(title: "Alert", message: "This is an alert", preferredStyle: .alert)
    let action = UIAlertAction(title: "Action", style: .default, handler: nil)

    controller.addAction(action)

    present(controller, animated: true, completion: nil)
  }
}
