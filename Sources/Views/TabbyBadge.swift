import UIKit

class TabbyBadge: UIView {

  lazy var numberLabel: UILabel = {
    let label = UILabel()
    label.font = Constant.Font.badge
    label.textColor = Constant.Color.Badge.text
    label.textAlignment = .center

    return label
  }()

  var number: Int = 0 {
    didSet {
      var text = "\(number)"
      if number >= 99 {
        text = "+99"
      }

      visible = number > 0
      numberLabel.text = text

      setupConstraints()
    }
  }

  var visible: Bool = false {
    didSet {
      alpha = visible ? 1 : 0
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    defer {
      number = 0
    }

    backgroundColor = Constant.Color.Badge.background
    
    layer.cornerRadius = Constant.Dimension.Badge.size / 2
    layer.borderColor = UIColor.white.cgColor
    layer.borderWidth = 2

    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Constraints

  func setupConstraints() {
    numberLabel.translatesAutoresizingMaskIntoConstraints = false
    numberLabel.removeFromSuperview()

    addSubview(numberLabel)
    constraint(numberLabel, attributes: .centerX, .centerY)

    numberLabel.sizeToFit()
  }
}
