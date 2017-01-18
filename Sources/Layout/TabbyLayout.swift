import UIKit

class TabbyLayout: UICollectionViewFlowLayout {

  override var collectionViewContentSize : CGSize {
    return CGSize(width: UIScreen.main.bounds.width,
                  height: Constant.Dimension.height)
  }

  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var attributes: [UICollectionViewLayoutAttributes] = []
    var offset: CGFloat = sectionInset.left

    guard let
      defaults = super.layoutAttributesForElements(in: rect),
      let collectionView = collectionView,
      let items = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: 0)
      else { return attributes }

    for attribute in defaults {
      guard let attribute = attribute.copy() as? UICollectionViewLayoutAttributes else { continue }

      attribute.frame.size.width = UIScreen.main.bounds.width / CGFloat(items)
      attribute.frame.size.height = Constant.Dimension.height
      attribute.frame.origin.x = offset
      offset += attribute.size.width + minimumInteritemSpacing

      attributes.append(attribute)
    }

    return attributes
  }
}
