import UIKit

class TabbyBadge: UIView {

  var setNumber: Int = 1 {
    didSet {
      var text = "\(setNumber)"
      if setNumber >= 99 {
        text = "Dude, what the?"
      }

      visible = setNumber > 0
      numberLabel.text = text
    }
  }

  var visible: Bool = true {
    didSet {
      alpha = visible ? 1 : 0
    }
  }

  lazy var numberLabel: UILabel = {
    let label = UILabel()

    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    backgroundColor = UIColor.orange
    layer.cornerRadius = Constant.Dimension.Badge.size / 2
    layer.borderColor = UIColor.white.cgColor
    layer.borderWidth = 2
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Constraints

  func setupConstraints() {
    
  }
}
