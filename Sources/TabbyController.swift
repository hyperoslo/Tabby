import UIKit

/**
 The protocol that will inform you when an item of the tab bar is tapped.
 */
public protocol TabbyDelegate: class {

  func tabbyDidPress(item: TabbyBarItem)
}

/**
 TabbyController is the controller that will contain all the other controllers.
 */
public class TabbyController: UIViewController {

  /**
   The actual tab bar that will contain the buttons, indicator, separator, etc.
   */
  public lazy var tabbyBar: TabbyBar = { [unowned self] in
    let tabby = TabbyBar(items: self.items)
    tabby.translatesAutoresizingMaskIntoConstraints = false
    tabby.delegate = self

    return tabby
  }()

  public var selectedController: UIViewController {
    return items[index].controller
  }

  /**
   An array of TabbyBarItems. The initializer contains the following parameters:

   - Parameter controller: The controller that you set as the one that will appear when tapping the view.
   - Parameter image: The image that will appear in the TabbyBarItem.
   */
  public var items: [TabbyBarItem] {
    didSet {
      var currentItem = index < tabbyBar.items.count
        ? tabbyBar.items[index]
        : items[index]

      if let index = items.indexOf(currentItem) {
        self.index = index
      }

      tabbyBar.items = items
    }
  }

  /**
   The property to set the current tab bar index.
   */
  public var setIndex = 0 {
    didSet {
      guard setIndex < items.count else { return }

      index = setIndex
      tabbyBar.selectedItem = index
    }
  }

  /**
   Weather the tab bar is translucent or not, this will make you to have to care about the offsets in your controller.
   */
  public var translucent: Bool = false {
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
  public var barVisible: Bool = true {
    didSet {
      tabbyBar.alpha = barVisible ? 1 : 0
      prepareCurrentController()
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

  /**
   The delegate that will tell you when a tab bar is tapped.
   */
  public weak var delegate: TabbyDelegate?

  // MARK: - Private variables

  private var index = 0

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
  public override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    tabbyButtonDidPress(index)
  }

  // MARK: - Helper methods

  func prepareCurrentController() {
    let controller = items[index].controller
    controller.removeFromParentViewController()
    controller.view.removeFromSuperview()
    controller.view.translatesAutoresizingMaskIntoConstraints = false

    addChildViewController(controller)
    view.insertSubview(controller.view, belowSubview: tabbyBar)
    tabbyBar.prepareTranslucency(translucent)
    applyNewConstraints(controller.view)
  }

  func applyNewConstraints(subview: UIView) {
    view.constraint(subview, attributes: .Leading, .Trailing, .Top)
    view.addConstraints([
      NSLayoutConstraint(
        item: subview, attribute: .Height,
        relatedBy: .Equal, toItem: view,
        attribute: .Height, multiplier: 1,
        constant: barVisible ? translucent ? 0 : -Constant.Dimension.height : 0)
      ])
  }

  // MARK: - Constraints

  func setupConstraints() {
    view.constraint(tabbyBar, attributes: .Leading, .Trailing, .Bottom)
    view.addConstraints([
      NSLayoutConstraint(
        item: tabbyBar, attribute: .Height,
        relatedBy: .Equal, toItem: nil,
        attribute: .NotAnAttribute,
        multiplier: 1, constant: Constant.Dimension.height)
      ])
  }
}

extension TabbyController: TabbyBarDelegate {

  /**
   The delegate method comming from the tab bar.

   - Parameter index: The index that was just tapped.
   */
  public func tabbyButtonDidPress(index: Int) {
    self.index = index

    guard index < items.count else { return }

    let controller = items[index].controller

    delegate?.tabbyDidPress(items[index])

    /// Check if it should do another action rather than removing the view.
    guard !view.subviews.contains(controller.view) else {
      if let navigationController = controller as? UINavigationController {
        navigationController.popViewControllerAnimated(true)
      } else {
        for case let subview as UIScrollView in controller.view.subviews {
          subview.setContentOffset(CGPointZero, animated: true)
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

    applyNewConstraints(controller.view)
  }
}
