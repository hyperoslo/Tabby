import UIKit

public class TabbyController: UIViewController {

  lazy var tabbyBar: TabbyBar = { [unowned self] in
    let tabby = TabbyBar()
    tabby.translatesAutoresizingMaskIntoConstraints = false
    tabby.delegate = self

    return tabby
  }()

  public var controllers: [(controller: UIViewController, image: UIImage?)] = [] {
    didSet {
      tabbyBar.prepare(controllers)
    }
  }

  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    view.addSubview(tabbyBar)

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

extension TabbyController: TabbyBarDelegate {

  public func tabbyButtonDidPress(index: Int) {
    controllers.forEach { $0.controller.view.removeFromSuperview() }

    guard index < controllers.count else { return }

    let controller = controllers[index].controller
    controller.view.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(controller.view)

    constraint(controller.view, attributes: [.Width, .Top, .Right])

    view.addConstraints([
      NSLayoutConstraint(
        item: controller.view, attribute: .Height,
        relatedBy: .Equal, toItem: view,
        attribute: .Height, multiplier: 1, constant: -Constant.Dimension.height)
      ])
  }
}
