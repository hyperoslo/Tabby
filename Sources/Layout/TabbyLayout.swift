import UIKit

class TabbyLayout: UICollectionViewFlowLayout {

  override func collectionViewContentSize() -> CGSize {
    return CGSize(width: Constant.Dimension.width,
                  height: Constant.Dimension.height)
  }

  override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var attributes: [UICollectionViewLayoutAttributes] = []
    var offset: CGFloat = sectionInset.left

    guard let
      defaults = super.layoutAttributesForElementsInRect(rect),
      collectionView = collectionView,
      items = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: 0)
      else { return attributes }

    for attribute in defaults {
      guard let attribute = attribute.copy() as? UICollectionViewLayoutAttributes else { continue }

      attribute.frame.size.width = Constant.Dimension.width / CGFloat(items)
      attribute.frame.origin.x = offset
      offset += attribute.size.width + minimumInteritemSpacing

      attributes.append(attribute)
    }

    return attributes
  }
}
