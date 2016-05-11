import UIKit

public protocol TabBarViewDelegate {

  func buttonDidPress(index: Int)
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

  public var controllers: [UIViewController]
  public var icons: [UIImage] = []
  public var selectedIcons: [UIImage] = []
  public var buttons: [UIButton] = []
  public var titles: [UILabel] = []
  public var delegate: TabBarViewDelegate?

  var selectedIndex = 0

  public init(controllers: [UIViewController], images: [UIImage?], selected: [UIImage?] = []) {
    self.controllers = controllers

    super.init(frame: CGRectZero)

    guard controllers.count == images.count else { return }

    for index in 0..<controllers.count {
      let button = UIButton()
      button.tag = index
      button.addTarget(self, action: #selector(buttonDidTouchDown(_:)), forControlEvents: .TouchDown)
      button.addTarget(self, action: #selector(buttonDidPress(_:)), forControlEvents: .TouchUpInside)
      button.adjustsImageWhenHighlighted = false

      let label = UILabel()
      label.font = Font.Tabs.title
      label.textColor = Color.TabBar.disabled
      label.text = controllers[index].title

      [button, label].forEach { addSubview($0) }

      if index == 1 {
        button.backgroundColor = Color.TabBar.background
        button.layer.cornerRadius = 5
        button.prepareShadow(Color.TabBar.whiteShadow)
        button.layer.shadowOffset.height = -10
        button.imageEdgeInsets.bottom = 5
      }

      buttons.append(button)
      titles.append(label)
    }

    for (index, image) in Image.enumerate() {
      guard let image = image else { break }


      icons.append(image)

      if selectedImage.isEmpty {
        let image = image.imageWithRenderingMode(.AlwaysTemplate)

        buttons[index].setImage(image, forState: .Normal)
        buttons[index].tintColor = Color.TabBar.disabled
      } else if let image = selectedImage[index] {
        selectedIcons.append(image)

        buttons[index].setImage(icons[index], forState: .Normal)
      }
    }

    prepareShadow(Color.TabBar.shadow, height: CGFloat(-3))
    layer.shadowRadius = 2
    setupConstraints()
    configureController(selectedController)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Action methods

  func buttonDidTouchDown(button: UIButton) {
    button.buttonDown()
  }

  func buttonDidPress(button: UIButton) {
    if selectedIcons.isEmpty {
      for button in buttons { button.tintColor = Color.TabBar.disabled }

      button.tintColor = Color.TabBar.selected
    } else {
      for (index, button) in buttons.enumerate() {
        button.setImage(icons[index], forState: .Normal)
      }

      button.setImage(selectedIcons[button.tag], forState: .Normal)
    }

    for label in titles { label.textColor = Color.TabBar.disabled }

    if let index = buttons.indexOf(button) where index < titles.count {
      titles[index].textColor = Color.TabBar.selected
    }

    delegate?.buttonDidPress(button.tag)
    selectedIndex = button.tag
  }

  // MARK: - Constraints

  func setupConstraints() {
    for (index, button) in buttons.enumerate() {
      let label = titles[index]
      let leftOffset = Dimensions.width * CGFloat(index) / CGFloat(buttons.count)

//      constrain(button, label) { button, label in
//        button.width == button.superview!.width / CGFloat(buttons.count)
//
//        label.centerX == button.centerX
//
//        if index == 1 {
//          button.height == button.superview!.height - 1.5
//          button.top == button.superview!.top - 7
//
//          label.bottom == label.superview!.bottom - 6
//        } else {
//          button.height == button.superview!.height
//          button.top == button.superview!.top - 6.5
//
//          label.bottom == label.superview!.bottom - 5
//        }
//
//        button.left == button.superview!.left + leftOffset
//      }
    }
  }
  
  // MARK: - Helper methods
  
  func configureController(index: Int) {
    guard index < buttons.count else { return }
    
    buttonDidPress(buttons[index])
  }
}
