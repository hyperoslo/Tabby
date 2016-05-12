import UIKit
import Tabby

class FirstController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.orangeColor()
    title = "Cows".uppercaseString

    let subview = UIView()
    subview.backgroundColor = UIColor.blackColor()
    subview.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(subview)

    view.addConstraints([
      NSLayoutConstraint(
        item: subview, attribute: .Width,
        relatedBy: .Equal, toItem: nil,
        attribute: .NotAnAttribute, multiplier: 1, constant: 50),

      NSLayoutConstraint(
        item: subview, attribute: .Height,
        relatedBy: .Equal, toItem: nil,
        attribute: .NotAnAttribute, multiplier: 1, constant: 50),

      NSLayoutConstraint(
        item: subview, attribute: .Bottom,
        relatedBy: .Equal, toItem: view,
        attribute: .Bottom, multiplier: 1, constant: 0),

      NSLayoutConstraint(
        item: subview, attribute: .Left,
        relatedBy: .Equal, toItem: view,
        attribute: .Left, multiplier: 1, constant: 0)
      ])
  }

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesBegan(touches, withEvent: event)

    navigationController?.pushViewController(SecondController(), animated: true)
  }
}

