import UIKit

public class TabbyController: UIViewController {

  lazy var tabbyBar: TabbyBar = { [unowned self] in
    let tabby = TabbyBar()
    tabby.translatesAutoresizingMaskIntoConstraints = false
    tabby.delegate = self

    return tabby
  }()

  public var controllers: [UIViewController] = [] {
    willSet {
      controllers.forEach { $0.view.removeFromSuperview() }
    }

    didSet {
      controllers.forEach { view.addSubview($0.view) }
      setupConstraints()
    }
  }

  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    view.addSubview(tabbyBar)
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
      controller.view.translatesAutoresizingMaskIntoConstraints = false
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
