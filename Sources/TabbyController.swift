import UIKit

public class TabbyController: UIViewController {

  lazy var tabbyBar: UIView = {
    let tabby = UIView()
    tabby.translatesAutoresizingMaskIntoConstraints = false

    return tabby
  }()

  var controllers: [UIViewController] = []

  public init(controllers: [UIViewController]) {
    self.controllers = controllers
    super.init(nibName: nil, bundle: nil)

    setupConstraints()
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Constraints

  func setupConstraints() {
    constraint(tabbyBar, attributes: [.Width, .Right, .Bottom])

    view.addConstraints([
      NSLayoutConstraint(
        item: tabbyBar, attribute: .Height,
        relatedBy: .Equal, toItem: view,
        attribute: .Width, multiplier: 1, constant: 0)
      ])

    for controller in controllers {
      constraint(controller.view, attributes: [.Width, .Right, .Bottom])
    }
  }

  // MARK: - Helper methods

  func constraint(subview: UIView, attributes: [NSLayoutAttribute]) {
    for attribute in attributes {
      view.addConstraint(NSLayoutConstraint(
        item: subview, attribute: attribute,
        relatedBy: .Equal, toItem: view,
        attribute: attribute, multiplier: 1, constant: 0)
      )
    }
  }
}
