import UIKit

public protocol TabbyBarDelegate {

  func tabbyButtonDidPress(index: Int)
}

public class TabbyBar: UIView {

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
  public var delegate: TabbyBarDelegate?

  var selectedIndex = 0

  // MARK: - Initializers

  public override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = Constant.Color.background
  }
  
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Action methods

  func buttonDidTouchDown(button: UIButton) {
//    button.buttonDown()
    // TODO: Perform the animation.
  }

  func buttonDidPress(button: UIButton) {
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

  // MARK: - Helper methods

  func configureController(index: Int) {
    guard index < buttons.count else { return }

    buttonDidPress(buttons[index])
  }

  func prepare(tuples: [(controller: UIViewController, image: UIImage?)]) {
    buttons = []
    titles = []
    icons = []

    for (index, tuple) in tuples.enumerate() {
      let button = UIButton()
      button.tag = index
      button.adjustsImageWhenHighlighted = false
      button.translatesAutoresizingMaskIntoConstraints = false
      button.addTarget(self, action: #selector(buttonDidTouchDown(_:)), forControlEvents: .TouchDown)
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
    }

    prepareShadow(Constant.Color.shadow, height: CGFloat(-2))
    setupConstraints()
    configureController(selectedController)
  }

  // MARK: - Constraints

  func setupConstraints() {
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
