import UIKit

class TabbyCell: UICollectionViewCell {

  static let reusableIdentifier = "TabbyCellReusableIdentifier"

  lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .ScaleAspectFit

    return imageView
  }()

  lazy var label: UILabel = {
    let label = UILabel()
    label.font = Constant.Font.title
    label.textColor = Constant.Color.disabled

    return label
  }()

  // MARK: - Initializers

  override init(frame: CGRect) {
    super.init(frame: frame)

    [imageView, label].forEach { addSubview($0) }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Configuration

  func configureCell(item: TabbyBarItem, selected: Bool = false) {
    let color = selected ? Constant.Color.selected : Constant.Color.disabled

    imageView.image = item.image?.imageWithRenderingMode(.AlwaysTemplate)
    imageView.tintColor = color

    label.text = item.controller.title
    label.textColor = color

    setupConstraints()
  }

  // MARK: - Constraints

  func setupConstraints() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    addConstraints([
      NSLayoutConstraint(item: imageView,
        attribute: .Width, relatedBy: .Equal,
        toItem: nil, attribute: .NotAnAttribute,
        multiplier: 1, constant: 20),

      NSLayoutConstraint(item: imageView,
        attribute: .Height, relatedBy: .Equal,
        toItem: nil, attribute: .NotAnAttribute,
        multiplier: 1, constant: 20),

      NSLayoutConstraint(item: imageView,
        attribute: .CenterX, relatedBy: .Equal,
        toItem: self, attribute: .CenterX,
        multiplier: 1, constant: 0),

      NSLayoutConstraint(item: imageView,
        attribute: .CenterY, relatedBy: .Equal,
        toItem: self, attribute: .CenterY,
        multiplier: 1, constant: 0)
      ])

    label.translatesAutoresizingMaskIntoConstraints = false
  }
}
