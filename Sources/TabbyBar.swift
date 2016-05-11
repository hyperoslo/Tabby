import UIKit

public protocol TabbyBarDelegate {

  func tabbyButtonDidPress(index: Int)
}

public class TabbyBar: UIView {

  lazy var backgroundView: UIView = {
    let view = UIView()
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
  public var delegate: TabbyBarDelegate?

  var selectedIndex = 0

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

    for (index, tuple) in tuples.enumerate() {
      let button = UIButton()
      button.tag = index
      button.addTarget(self, action: #selector(buttonDidTouchDown(_:)), forControlEvents: .TouchDown)
      button.addTarget(self, action: #selector(buttonDidPress(_:)), forControlEvents: .TouchUpInside)
      button.adjustsImageWhenHighlighted = false

      let label = UILabel()
      label.font = Constant.Font.title
      label.textColor = Constant.Color.disabled
      label.text = tuple.controller.title

      [button, label].forEach { addSubview($0) }

      buttons.append(button)
      titles.append(label)

      if let image = tuple.image {
        icons.append(image)

        button.setImage(image.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
        button.tintColor = Constant.Color.disabled
      }
    }

    //prepareShadow(Constant.Color.shadow, height: CGFloat(-3))
    layer.shadowRadius = 2
    setupConstraints()
    configureController(selectedController)
  }

  // MARK: - Constraints

  func setupConstraints() {
    for (index, button) in buttons.enumerate() {
      let label = titles[index]
      let leftOffset = Constant.Dimension.width * CGFloat(index) / CGFloat(buttons.count)

      

      constrain(button, label) { button, label in
        button.width == button.superview!.width / CGFloat(buttons.count)

        label.centerX == button.centerX

        if index == 1 {
          button.height == button.superview!.height - 1.5
          button.top == button.superview!.top - 7

          label.bottom == label.superview!.bottom - 6
        } else {
          button.height == button.superview!.height
          button.top == button.superview!.top - 6.5

          label.bottom == label.superview!.bottom - 5
        }

        button.left == button.superview!.left + leftOffset
      }
    }
  }
}
