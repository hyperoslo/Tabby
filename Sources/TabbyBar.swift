import UIKit

public protocol TabbyBarDelegate {

  func tabbyButtonDidPress(index: Int)
}

public class TabbyBar: UIView {

  public lazy var translucentView: UIVisualEffectView = {
    let view = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()

  public lazy var indicator: UIView = {
    let view = UIView()
    view.backgroundColor = Constant.Color.indicator
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()

  public lazy var separator: UIView = {
    let view = UIView()
    view.backgroundColor = Constant.Color.separator
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
  }()

  public var selectedController = 0 {
    didSet {
      configureController(selectedController)
      selectedIndex = selectedController
    }
  }

  public var icons: [UIImage] = []
  public var selectedIcons: [UIImage] = []
  public var buttons: [UIButton] = []
  public var titles: [UILabel] = []
  public var animations : [TabbyAnimation.Kind] = []
  public var delegate: TabbyBarDelegate?

  var selectedIndex = 0 {
    didSet {
      animateIndicator(selectedIndex)
    }
  }

  // MARK: - Initializers

  public override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = Constant.Color.background

    [indicator, separator].forEach { addSubview($0) }
  }
  
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Action methods

  func buttonDidTouchDown(button: UIButton) {
    UIView.animateWithDuration(0.1, animations: {
      button.transform = CGAffineTransformMakeScale(0.8, 0.8)
    })
  }

  func buttonDidCancel(button: UIButton) {
    UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [.CurveEaseInOut], animations: {
      button.transform = CGAffineTransformIdentity
      }, completion: nil)
  }

  func buttonDidPress(button: UIButton) {
    buttonDidCancel(button)

    if selectedIcons.isEmpty {
      for button in buttons { button.tintColor = Constant.Color.disabled }

      button.tintColor = Constant.Color.selected
    } else {
      for (index, button) in buttons.enumerate() {
        button.setImage(icons[index], forState: .Normal)
      }

      button.setImage(selectedIcons[button.tag], forState: .Normal)
    }

    for label in titles { label.textColor = Constant.Color.disabled }

    if let index = buttons.indexOf(button) where index < titles.count {
      titles[index].textColor = Constant.Color.selected
    }

    delegate?.tabbyButtonDidPress(button.tag)
    selectedIndex = button.tag
  }

  // MARK: - Animations

  func animateIndicator(index: Int) {
    UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [.CurveEaseIn], animations: {
      self.indicator.center.x = self.buttons[index].center.x
      }, completion: nil)
  }

  // MARK: - Helper methods

  func configureController(index: Int) {
    guard index < buttons.count else { return }
    buttonDidPress(buttons[index])
  }

  func prepareTranslucency(translucent: Bool) {
    translucentView.removeFromSuperview()

    if translucent {
      insertSubview(translucentView, atIndex: 0)
      constraint(translucentView, attributes: [.Width, .Height, .Top, .Left])
      backgroundColor = Constant.Color.background.colorWithAlphaComponent(0.85)
    } else {
      backgroundColor = Constant.Color.background
    }
  }

  func prepare(tuples: [(controller: UIViewController, image: UIImage?)]) {
    buttons = []
    titles = []
    icons = []
    animations = []

    for (index, tuple) in tuples.enumerate() {
      let button = UIButton()
      button.tag = index
      button.adjustsImageWhenHighlighted = false
      button.translatesAutoresizingMaskIntoConstraints = false
      button.addTarget(self, action: #selector(buttonDidTouchDown(_:)), forControlEvents: .TouchDown)
      button.addTarget(self, action: #selector(buttonDidTouchDown(_:)), forControlEvents: .TouchDragEnter)
      button.addTarget(self, action: #selector(buttonDidCancel(_:)), forControlEvents: .TouchCancel)
      button.addTarget(self, action: #selector(buttonDidCancel(_:)), forControlEvents: .TouchDragExit)
      button.addTarget(self, action: #selector(buttonDidPress(_:)), forControlEvents: .TouchUpInside)

      let label = UILabel()
      label.text = tuple.controller.title
      label.font = Constant.Font.title
      label.textColor = Constant.Color.disabled
      label.translatesAutoresizingMaskIntoConstraints = false

      if let image = tuple.image {
        let icon = image.imageWithRenderingMode(.AlwaysTemplate)
        icons.append(icon)

        button.setImage(icon, forState: .Normal)
        button.tintColor = Constant.Color.disabled
      }

      [button, label].forEach { addSubview($0) }

      buttons.append(button)
      titles.append(label)
      animations.append(Constant.Animation.initial)
    }

    prepareShadow(Constant.Color.shadow, height: CGFloat(-2))
    setupConstraints()
    configureController(selectedController)
  }

  func constraint(subview: UIView, attributes: [NSLayoutAttribute]) {
    for attribute in attributes {
      addConstraint(NSLayoutConstraint(
        item: subview, attribute: attribute,
        relatedBy: .Equal, toItem: self,
        attribute: attribute, multiplier: 1, constant: 0)
      )
    }
  }

  // MARK: - Constraints

  func setupConstraints() {
    constraint(indicator, attributes: [.Left, .Bottom])
    constraint(separator, attributes: [.Width, .Top, .Right])

    addConstraints([
      NSLayoutConstraint(
        item: indicator, attribute: .Width,
        relatedBy: .Equal, toItem: nil,
        attribute: .NotAnAttribute, multiplier: 1, constant: Constant.Dimension.Indicator.width),

      NSLayoutConstraint(
        item: indicator, attribute: .Height,
        relatedBy: .Equal, toItem: nil,
        attribute: .NotAnAttribute, multiplier: 1, constant: Constant.Dimension.Indicator.height),

      NSLayoutConstraint(
        item: separator, attribute: .Height,
        relatedBy: .Equal, toItem: nil,
        attribute: .NotAnAttribute, multiplier: 1, constant: Constant.Dimension.Separator.height)
      ])

    for (index, button) in buttons.enumerate() {
      let label = titles[index]
      let leftOffset = Constant.Dimension.width * CGFloat(index) / CGFloat(buttons.count)

      addConstraints([
        NSLayoutConstraint(
          item: button, attribute: .Width,
          relatedBy: .Equal, toItem: self,
          attribute: .Width, multiplier: 1 / CGFloat(buttons.count), constant: 0),

        NSLayoutConstraint(
          item: button, attribute: .Height,
          relatedBy: .Equal, toItem: self,
          attribute: .Height, multiplier: 1, constant: 0),

        NSLayoutConstraint(
          item: button, attribute: .Top,
          relatedBy: .Equal, toItem: self,
          attribute: .Top, multiplier: 1, constant: label.text == nil ? 0 : -6.5),

        NSLayoutConstraint(
          item: button, attribute: .Left,
          relatedBy: .Equal, toItem: self,
          attribute: .Left, multiplier: 1, constant: leftOffset),

        NSLayoutConstraint(
          item: label, attribute: .CenterX,
          relatedBy: .Equal, toItem: button,
          attribute: .CenterX, multiplier: 1, constant: 0),

        NSLayoutConstraint(
          item: label, attribute: .Bottom,
          relatedBy: .Equal, toItem: self,
          attribute: .Bottom, multiplier: 1, constant: -5)
        ])
    }
  }
}
