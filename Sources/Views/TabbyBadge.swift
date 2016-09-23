import UIKit

class TabbyBadge: UIView {

  var setNumber: Int = 0 {
    didSet {
      var text = "\(setNumber)"
      if setNumber >= 99 {
        text = "+99"
      }

      visible = setNumber > 0
      numberLabel.text = text

      setupConstraints()
    }
  }

  var visible: Bool = false {
    didSet {
      alpha = visible ? 1 : 0
    }
  }

  lazy var numberLabel: UILabel = {
    let label = UILabel()
    label.font = Constant.Font.badge
    label.textColor = Constant.Color.Badge.text
    label.textAlignment = .center
    label.text = "0"

    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

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
