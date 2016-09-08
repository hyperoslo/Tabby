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

  // MARK: - Configuration

  func configureCell(item: TabbyBarItem, selected: Bool = false) {
    let color = selected ? Constant.Color.selected : Constant.Color.disabled

    imageView.image = item.image?.imageWithRenderingMode(.AlwaysTemplate)
    imageView.tintColor = color

    label.text = item.controller.title
    label.textColor = color

    if selected {
      TabbyAnimation.animate(imageView, kind: item.animation)
    }

    setupConstraints()
  }

  // MARK: - Constraints

  func setupConstraints() {
    let offset: CGFloat = label.alpha == 1 ? 8 : 0

    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.removeFromSuperview()

    addSubview(imageView)
    addConstraints([
      NSLayoutConstraint(item: imageView,
        attribute: .Width, relatedBy: .Equal,
        toItem: nil, attribute: .NotAnAttribute,
        multiplier: 1, constant: 22.5),

      NSLayoutConstraint(item: imageView,
        attribute: .Height, relatedBy: .Equal,
        toItem: nil, attribute: .NotAnAttribute,
        multiplier: 1, constant: 22.5),

      NSLayoutConstraint(item: imageView,
        attribute: .CenterX, relatedBy: .Equal,
        toItem: self, attribute: .CenterX,
        multiplier: 1, constant: 0),

      NSLayoutConstraint(item: imageView,
        attribute: .CenterY, relatedBy: .Equal,
        toItem: self, attribute: .CenterY,
        multiplier: 1, constant: -offset)
      ])

    label.translatesAutoresizingMaskIntoConstraints = false
    label.removeFromSuperview()

    addSubview(label)
    addConstraints([
      NSLayoutConstraint(item: label,
        attribute: .CenterX, relatedBy: .Equal,
        toItem: self, attribute: .CenterX,
        multiplier: 1, constant: 0),

      NSLayoutConstraint(item: label,
        attribute: .CenterY, relatedBy: .Equal,
        toItem: self, attribute: .CenterY,
        multiplier: 1, constant: offset + 4)
      ])
  }
}
