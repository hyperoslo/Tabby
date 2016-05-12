import UIKit

public protocol TabbyDelegate {

  func tabbyDidPress(button: UIButton, _ label: UILabel)
}

public class TabbyController: UIViewController {

  public lazy var tabbyBar: TabbyBar = { [unowned self] in
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

  public var index = 0 {
    didSet {
      tabbyBar.selectedController = index
    }
  }

  public var translucent: Bool = false {
    didSet {
      let controller = controllers[tabbyBar.selectedIndex].controller
      controller.view.removeFromSuperview()

      view.insertSubview(controller.view, belowSubview: tabbyBar)
      tabbyBar.prepareTranslucency(translucent)
      applyNewConstraints(controller.view)
    }
  }

  public var showIndicator: Bool = true {
    didSet {
      tabbyBar.indicator.alpha = 0
    }
  }

  public var delegate: TabbyDelegate?

  // MARK: - Initializers

  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    view.addSubview(tabbyBar)

    setupConstraints()
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View lifecycle

  public override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    tabbyBar.indicator.center.x = tabbyBar.buttons[tabbyBar.selectedIndex].center.x
  }

  // MARK: - Constraints

  func setupConstraints() {
    constraint(tabbyBar, attributes: [.Width, .Right, .Bottom])

    view.addConstraints([
      NSLayoutConstraint(
        item: tabbyBar, attribute: .Height,
        relatedBy: .Equal, toItem: nil,
        attribute: .NotAnAttribute, multiplier: 1, constant: Constant.Dimension.height)
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

  func applyNewConstraints(subview: UIView) {
    constraint(subview, attributes: [.Width, .Top, .Right])

    view.addConstraints([
      NSLayoutConstraint(
        item: subview, attribute: .Height,
        relatedBy: .Equal, toItem: view,
        attribute: .Height, multiplier: 1, constant: translucent ? 0 : -Constant.Dimension.height)
      ])
  }
}

extension TabbyController: TabbyBarDelegate {

  public func tabbyButtonDidPress(index: Int) {
    guard index < controllers.count else { return }

    let button = tabbyBar.buttons[index]

    delegate?.tabbyDidPress(button, tabbyBar.titles[index])
    TabbyAnimation.animate(button, kind: Constant.Animation.initial)

    guard !view.subviews.contains(controllers[index].controller.view) else { return }

    controllers.forEach { $0.controller.view.removeFromSuperview() }

    let controller = controllers[index].controller
    controller.view.translatesAutoresizingMaskIntoConstraints = false

    view.insertSubview(controller.view, belowSubview: tabbyBar)

    applyNewConstraints(controller.view)
  }
}
