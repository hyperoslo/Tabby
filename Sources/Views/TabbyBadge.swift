import UIKit

class TabbyBadge: UIView {

  lazy var containerView: UIView = UIView()

  lazy var numberLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = Constant.Font.badge
    label.textColor = Constant.Color.Badge.text

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

    backgroundColor = Constant.Color.Badge.border
    containerView.backgroundColor = Constant.Color.Badge.background

    setupConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Constraints

  func setupConstraints() {
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.removeFromSuperview()

    addSubview(containerView)
    constraint(containerView, attributes: .centerX, .centerY)
    addConstraints([
      NSLayoutConstraint(item: self,
        attribute: .width, relatedBy: .equal,
        toItem: containerView, attribute: .width,
        multiplier: 1, constant: Constant.Dimension.Badge.border * 2),

      NSLayoutConstraint(item: self,
        attribute: .height, relatedBy: .equal,
        toItem: containerView, attribute: .height,
        multiplier: 1, constant: Constant.Dimension.Badge.border * 2)
      ])

    numberLabel.translatesAutoresizingMaskIntoConstraints = false
    numberLabel.removeFromSuperview()

    containerView.addSubview(numberLabel)
    containerView.constraint(numberLabel, attributes: .centerX, .centerY)

    numberLabel.sizeToFit()

    addConstraints([
      NSLayoutConstraint(item: containerView,
       attribute: .width, relatedBy: .equal,
       toItem: numberLabel, attribute: .width,
       multiplier: 1, constant: 6),

      NSLayoutConstraint(item: containerView,
       attribute: .height, relatedBy: .equal,
       toItem: numberLabel, attribute: .height,
       multiplier: 1, constant: 1)
      ])

    containerView.layer.cornerRadius = (numberLabel.frame.height + 1) / 2
    layer.cornerRadius = containerView.layer.cornerRadius + Constant.Dimension.Badge.border
  }
}
