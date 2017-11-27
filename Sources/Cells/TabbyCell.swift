import UIKit

public protocol TabbyCell: class {
  func configureCell(_ item: TabbyBarItem, at index: Int, selected: Bool, count: Int?)
}

public extension TabbyCell {
  static var reusableIdentifier: String  {
    return "TabbyCellReusableIdentifier"
  }

  var collectionViewCell: UICollectionViewCell {
    return self as? UICollectionViewCell ?? UICollectionViewCell()
  }
}

open class TabbyDefaultCell: UICollectionViewCell, TabbyCell {

  public lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit

    return imageView
  }()

  public lazy var label: UILabel = {
    let label = UILabel()
    label.font = Constant.Font.title
    label.textColor = Constant.Color.disabled

    return label
  }()

  public lazy var badge: TabbyBadge = TabbyBadge()

  // MARK: - Configuration

  open func configureCell(_ item: TabbyBarItem, at index: Int, selected: Bool = false, count: Int?) {
    let color = selected ? Constant.Color.selected : Constant.Color.disabled

    imageView.image = UIImage(named: item.image)?.withRenderingMode(.alwaysTemplate)
    imageView.tintColor = color

    label.text = item.controller.title
    label.textColor = color

    if selected {
      Constant.tapItemAnimation(imageView)
    }

    handleBadge(count)
    handleBehaviors(selected)
    setupConstraints()

    label.font = Constant.Font.title
  }

  // MARK: - Helper methods

  open func handleBadge(_ count: Int?) {
    guard badge.number != count else { badge.number = count ?? 0; return }

    badge.number = count ?? 0
    badge.transform = count == 0 ? .identity : .init(scaleX: 0, y: 0)

    UIView.animate(
      withDuration: 0.5, delay: 0,
      usingSpringWithDamping: 0.6,
      initialSpringVelocity: 0.6,
      options: [], animations: {
        self.badge.transform = count == 0 ? .init(scaleX: 0, y: 0) : .identity
      }, completion: nil)
  }

  open func handleBehaviors(_ selected: Bool) {
    switch Constant.Behavior.labelVisibility {
    case .invisible:
      label.alpha = 0
    case .activeVisible:
      label.alpha = selected ? 1 : 0
    default:
      label.alpha = 1
    }
  }

  // MARK: - Constraints

  open func setupConstraints() {
    let offset: CGFloat = label.alpha == 1 ? 8 : 0

    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.removeFromSuperview()

    addSubview(imageView)

    constraint(imageView, attributes: .centerX)
    addConstraints([
      NSLayoutConstraint(item: imageView,
        attribute: .width, relatedBy: .equal,
        toItem: nil, attribute: .notAnAttribute,
        multiplier: 1, constant: Constant.Dimension.Icon.width),

      NSLayoutConstraint(item: imageView,
        attribute: .height, relatedBy: .equal,
        toItem: nil, attribute: .notAnAttribute,
        multiplier: 1, constant: Constant.Dimension.Icon.height),

      NSLayoutConstraint(item: imageView,
        attribute: .centerY, relatedBy: .equal,
        toItem: self, attribute: .centerY,
        multiplier: 1, constant: -offset)
    ])

    label.translatesAutoresizingMaskIntoConstraints = false
    label.removeFromSuperview()

    addSubview(label)

    constraint(label, attributes: .centerX)
    addConstraint(NSLayoutConstraint(item: label,
      attribute: .centerY, relatedBy: .equal,
      toItem: self, attribute: .centerY,
      multiplier: 1, constant: offset + 5)
    )

    badge.translatesAutoresizingMaskIntoConstraints = false
    badge.removeFromSuperview()

    addSubview(badge)
    addConstraints([
      NSLayoutConstraint(item: badge,
        attribute: .centerY, relatedBy: .equal,
        toItem: imageView, attribute: .top,
        multiplier: 1, constant: 1),

      NSLayoutConstraint(item: badge,
        attribute: .centerX, relatedBy: .equal,
        toItem: imageView, attribute: .right,
        multiplier: 1, constant: 0)
    ])
  }
}
