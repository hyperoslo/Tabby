import UIKit

/**
 The protocol that will inform you when an item of the tab bar is tapped.
 */
public protocol TabbyDelegate {

  func tabbyDidPress(button: UIButton, _ label: UILabel)
}

/**
 TabbyController is the controller that will contain all the other controllers.
 */
public class TabbyController: UIViewController {

  /**
   The actual tab bar that will contain the buttons, indicator, separator, etc.
   */
  public lazy var tabbyBar: TabbyBar = { [unowned self] in
    let tabby = TabbyBar()
    tabby.translatesAutoresizingMaskIntoConstraints = false
    tabby.delegate = self

    return tabby
  }()

  /**
   An array of tuples with multiple parameters that will create and build the tab bar.

   For the tuple:

   - Parameter controller: The actual controller, can be any.
   - Parameter kind: The image that will appear in the tab bar.
   */
  public var controllers: [(controller: UIViewController, image: UIImage?)] = [] {
    didSet {
      tabbyBar.prepare(controllers)
    }
  }

  /**
   The property to set the current tab bar index.
   */
  public var setIndex = 0 {
    didSet {
      tabbyBar.selectedController = setIndex
    }
  }

  /**
   Weather the tab bar is translucent or not, this will make you to have to care about the offsets in your controller.
   */
  public var translucent: Bool = false {
    didSet {
      let controller = controllers[tabbyBar.selectedIndex].controller
      controller.removeFromParentViewController()
      controller.view.removeFromSuperview()

      addChildViewController(controller)
      view.insertSubview(controller.view, belowSubview: tabbyBar)
      tabbyBar.prepareTranslucency(translucent)
      applyNewConstraints(controller.view)
    }
  }

  /**
   Weather or not it should show the indicator or not to show in which tab the user is in.
   */
  public var showIndicator: Bool = true {
    didSet {
      tabbyBar.indicator.alpha = showIndicator ? 1 : 0
    }
  }

  /**
   Weather or not it should display a separator or a shadow.
   */
  public var showSeparator: Bool = true {
    didSet {
      tabbyBar.separator.alpha = showSeparator ? 1 : 0
      tabbyBar.layer.shadowOpacity = showSeparator ? 0 : 1
    }
  }

  /**
   The animations that the tab bar will use when tapping the items.
   */
  public var animations: [TabbyAnimation.Kind] = [] {
    didSet {
      tabbyBar.animations = animations
    }
  }

  /**
   The delegate that will tell you when a tab bar is tapped.
   */
  public var delegate: TabbyDelegate?

  // MARK: - Initializers

  /**
   Initialier.
   */
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    view.addSubview(tabbyBar)

    setupConstraints()
  }

  /**
   Initializer.
   */
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View lifecycle

  /**
   Did appear.
   */
  public override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    guard tabbyBar.selectedIndex < controllers.count else { return }
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

  /**
   The delegate method comming from the tab bar.
   - Parameter index: The index that was just tapped.
   */
  public func tabbyButtonDidPress(index: Int) {
    guard index < controllers.count else { return }

    let button = tabbyBar.buttons[index]

    delegate?.tabbyDidPress(button, tabbyBar.titles[index])
    TabbyAnimation.animate(button, kind: tabbyBar.animations.count != controllers.count
      ? Constant.Animation.initial : tabbyBar.animations[index])

    guard !view.subviews.contains(controllers[index].controller.view) else {
      if let navigationController = controllers[index].controller as? UINavigationController {
        navigationController.popViewControllerAnimated(true)
      } else {
        for case let subview as UIScrollView in controllers[index].controller.view.subviews {
          subview.setContentOffset(CGPointZero, animated: true)
        }
      }

      return
    }

    controllers.forEach {
      $0.controller.removeFromParentViewController()
      $0.controller.view.removeFromSuperview()
    }

    let controller = controllers[index].controller
    controller.view.translatesAutoresizingMaskIntoConstraints = false

    addChildViewController(controller)
    view.insertSubview(controller.view, belowSubview: tabbyBar)

    applyNewConstraints(controller.view)
  }
}
