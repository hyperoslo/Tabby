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
    constraint(imageView, attributes: .CenterX)
    addConstraints([
      NSLayoutConstraint(item: imageView,
        attribute: .Width, relatedBy: .Equal,
        toItem: nil, attribute: .NotAnAttribute,
        multiplier: 1, constant: Constant.Dimension.Icon.width),

      NSLayoutConstraint(item: imageView,
        attribute: .Height, relatedBy: .Equal,
        toItem: nil, attribute: .NotAnAttribute,
        multiplier: 1, constant: Constant.Dimension.Icon.height),

      NSLayoutConstraint(item: imageView,
        attribute: .CenterY, relatedBy: .Equal,
        toItem: self, attribute: .CenterY,
        multiplier: 1, constant: -offset)
      ])

    label.translatesAutoresizingMaskIntoConstraints = false
    label.removeFromSuperview()

    addSubview(label)
    constraint(label, attributes: .CenterX)
    addConstraints([
      NSLayoutConstraint(item: label,
        attribute: .CenterY, relatedBy: .Equal,
        toItem: self, attribute: .CenterY,
        multiplier: 1, constant: offset + 4)
      ])
  }
}
