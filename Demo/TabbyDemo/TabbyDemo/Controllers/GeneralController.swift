import UIKit

class GeneralController: UIViewController {

  lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .ScaleAspectFit

    return imageView
  }()

  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = UIFont.boldSystemFontOfSize(15)

    return label
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    [imageView, titleLabel].forEach { view.addSubview($0) }

    setupConstraints()
  }

  // MARK: - Constraint methods

  func setupConstraints() {
    constraint(titleLabel, attributes: [.CenterX, .CenterY])
    constraint(imageView, attributes: [.CenterX])

    view.addConstraint(NSLayoutConstraint(
      item: titleLabel, attribute: .Width,
      relatedBy: .Equal, toItem: self,
      attribute: .Width, multiplier: 1, constant: -200)
    )

    view.addConstraint(NSLayoutConstraint(
      item: imageView, attribute: .Bottom,
      relatedBy: .Equal, toItem: titleLabel,
      attribute: .Top, multiplier: 1, constant: -200)
    )
  }

  // MARK: - Helper methods

  func constraint(subview: UIView, attributes: [NSLayoutAttribute]) {
    for attribute in attributes {
      view.addConstraint(NSLayoutConstraint(
        item: subview, attribute: attribute,
        relatedBy: .Equal, toItem: self,
        attribute: attribute, multiplier: 1, constant: 0)
      )
    }
  }
}
