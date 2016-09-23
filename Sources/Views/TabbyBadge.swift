import UIKit

class TabbyBadge: UIView {

  var setNumber: Int = 0 {
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

  lazy var container: UIView = {
    let view = UIView()

    return view
  }()

  lazy var numberLabel: UILabel = {
    let label = UILabel()

    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Constraints

  func setupConstraints() {
    
  }
}
