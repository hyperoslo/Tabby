import UIKit

/**
 The protocol that will inform you when an item of the tab bar is tapped.
 */
public protocol TabbyDelegate: class {

  func tabbyDidPress(_ item: TabbyBarItem)
}

/**
 TabbyController is the controller that will contain all the other controllers.
 */
open class TabbyController: UIViewController, UINavigationControllerDelegate {

  var heightConstraint: NSLayoutConstraint?

  lazy var hiddenConstraint: NSLayoutConstraint = { [unowned self] in
    let constraint = NSLayoutConstraint(
      item: self.tabbyBar, attribute: .height,
      relatedBy: .equal, toItem: nil,
      attribute: .notAnAttribute,
      multiplier: 1, constant: 0)

    return constraint
    }()

  lazy var shownConstraint: NSLayoutConstraint = { [unowned self] in
    let constraint = NSLayoutConstraint(
      item: self.tabbyBar, attribute: .height,
      relatedBy: .equal, toItem: nil,
      attribute: .notAnAttribute,
      multiplier: 1, constant: Constant.Dimension.height)

    return constraint
    }()

  /**
   The actual tab bar that will contain the buttons, indicator, separator, etc.
   */
  open lazy var tabbyBar: TabbyBar = { [unowned self] in
    let tabby = TabbyBar(items: self.items)
    tabby.translatesAutoresizingMaskIntoConstraints = false
    tabby.delegate = self

    return tabby
    }()

  /**
   The current selected controller in the tab bar.
   */
  open var selectedController: UIViewController {
    return items[index].controller
  }

  /**
   Represents if the bar is hidden or not.
   */
  open var barHidden: Bool = false {
    didSet {
      // Delay necessary when changing the whole controller -> UIViewController
      // to UINavigationController for instance. The inner constraints change (and break).
      let when = DispatchTime.now() + 0.1
      DispatchQueue.main.asyncAfter(deadline: when) {
        self.hideBar()
      }
    }
  }

  /**
   An array of TabbyBarItems. The initializer contains the following parameters:

   - Parameter controller: The controller that you set as the one that will appear when tapping the view.
   - Parameter image: The image that will appear in the TabbyBarItem.
   */
  open var items: [TabbyBarItem] {
    didSet {
      let currentItem = index < tabbyBar.items.count
        ? tabbyBar.items[index]
        : items[index]

      if let index = items.index(of: currentItem) {
        self.index = index
      }

      tabbyBar.items = items
      setupDelegate()
    }
  }

  /**
   The property to set the current tab bar index.
   */
  open var setIndex = 0 {
    didSet {
      guard setIndex < items.count else { return }

      index = setIndex
      tabbyBar.selectedItem = index
    }
  }

  /**
   Weather the tab bar is translucent or not, this will make you to have to care about the offsets in your controller.
   */
  open var translucent: Bool = false {
    didSet {
      guard index < items.count else { return }

      prepareCurrentController()

      if !showSeparator {
        tabbyBar.layer.shadowOpacity = translucent ? 0 : 1
        tabbyBar.translucentView.layer.shadowOpacity = translucent ? 1 : 0
      }
    }
  }

  /**
   A property indicating weather the tab bar should be visible or not. True by default.
   */
  open var barVisible: Bool = true {
    didSet {
      tabbyBar.alpha = barVisible ? 1 : 0
      prepareCurrentController()
    }
  }

  /**
   Weather or not it should show the indicator or not to show in which tab the user is in.
   */
  open var showIndicator: Bool = true {
    didSet {
      tabbyBar.indicator.alpha = showIndicator ? 1 : 0
    }
  }

  /**
   Weather or not it should display a separator or a shadow.
   */
  open var showSeparator: Bool = true {
    didSet {
      tabbyBar.separator.alpha = showSeparator ? 1 : 0

      if showSeparator {
        tabbyBar.layer.shadowOpacity = 0
        tabbyBar.translucentView.layer.shadowOpacity = 0
      } else {
        if translucent {
          tabbyBar.translucentView.layer.shadowOpacity = 1
        } else {
          tabbyBar.layer.shadowOpacity = 1
        }
      }
    }
  }

  var heightConstant: CGFloat = 0

  /**
   The delegate that will tell you when a tab bar is tapped.
   */
  open weak var delegate: TabbyDelegate?

  // MARK: - Private variables

  fileprivate var index = 0

  // MARK: - Initializers

  /**
   Initializer with a touple of controllers and images for it.
   */
  public init(items: [TabbyBarItem]) {
    self.items = items

    super.init(nibName: nil, bundle: nil)

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
  open override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    tabbyButtonDidPress(index)
  }

  // MARK: - Configurations

  open func setBadge(_ value: Int, _ itemImage: String) {
    guard !items.filter({ $0.image == itemImage }).isEmpty else { return }

    tabbyBar.badges[itemImage] = value
  }

  // MARK: - Helper methods

  func setupDelegate() {
    for case let controller as UINavigationController in items.map({ $0.controller }) {
      controller.delegate = self
    }
  }

  func prepareCurrentController() {
    let controller = items[index].controller
    controller.removeFromParentViewController()
    controller.view.removeFromSuperview()
    controller.view.translatesAutoresizingMaskIntoConstraints = false

    addChildViewController(controller)
    view.insertSubview(controller.view, belowSubview: tabbyBar)
    tabbyBar.prepareTranslucency(translucent)
    applyNewConstraints(controller)
  }

  func hideBar() {
    animateNewConstraints()

    UIView.animate(withDuration: 0.3, animations: {
      self.tabbyBar.transform = self.barHidden
        ? .init(translationX: 0, y: self.tabbyBar.frame.height)
        : .identity
    }, completion: { _ in
      self.tabbyBar.positionIndicator(self.index)
    })
  }

  func animateNewConstraints() {
    UIView.animate(withDuration: 0.3, animations: {
      self.prepareCurrentController()
      self.view.layoutIfNeeded()
    })
  }

  func applyNewConstraints(_ controller: UIViewController) {
    var constant: CGFloat = 0

    if barVisible {
      constant = -Constant.Dimension.height
    }

    if translucent {
      constant = 0
    }

    if barHidden {
      constant = 0
    }

    heightConstant = constant

    view.constraint(controller.view, attributes: .leading, .trailing, .top)

    let constraint = NSLayoutConstraint(
      item: controller.view, attribute: .height,
      relatedBy: .equal, toItem: view,
      attribute: .height, multiplier: 1,
      constant: constant)

    view.addConstraints([constraint])
    heightConstraint = constraint
  }

  // MARK: - Constraints

  func setupConstraints() {
    view.constraint(tabbyBar, attributes: .leading, .trailing, .bottom)
    view.addConstraint(shownConstraint)
  }
}

extension TabbyController {

  public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
    var needsLayout = false
    let controller = items[index].controller

    if viewController.hidesBottomBarWhenPushed {
      if view.constraints.contains(shownConstraint) {
        heightConstraint?.constant = 0
        view.removeConstraint(shownConstraint)
        view.addConstraint(hiddenConstraint)
        tabbyBar.indicator.alpha = 0.0
        needsLayout = true
      }
    } else {
      if view.constraints.contains(hiddenConstraint) {
        view.removeConstraint(hiddenConstraint)
        view.addConstraint(shownConstraint)
        heightConstraint?.constant = -Constant.Dimension.height
        tabbyBar.indicator.alpha = showIndicator ? 1 : 0
        needsLayout = true
      }
    }

    if needsLayout {
      UIView.animate(withDuration: 0.3) {
        self.view.layoutIfNeeded()
      }
    }
  }
}

extension TabbyController: TabbyBarDelegate {

  /**
   The delegate method comming from the tab bar.

   - Parameter index: The index that was just tapped.
   */
  public func tabbyButtonDidPress(_ index: Int) {
    self.index = index

    guard index < items.count else { return }

    let item = items[index]
    let controller = item.controller

    delegate?.tabbyDidPress(item)

    guard item.selection == .systematic else { return }
    /// Check if it should do another action rather than removing the view.
    guard !view.subviews.contains(controller.view) else {
      if let navigationController = controller as? UINavigationController {
        navigationController.popViewController(animated: true)
      } else {
        for case let subview as UIScrollView in controller.view.subviews {
          subview.setContentOffset(CGPoint.zero, animated: true)
        }
      }

      return
    }

    items.forEach {
      $0.controller.removeFromParentViewController()
      $0.controller.view.removeFromSuperview()
    }

    controller.view.translatesAutoresizingMaskIntoConstraints = false

    addChildViewController(controller)
    view.insertSubview(controller.view, belowSubview: tabbyBar)

    applyNewConstraints(controller)
  }
}
