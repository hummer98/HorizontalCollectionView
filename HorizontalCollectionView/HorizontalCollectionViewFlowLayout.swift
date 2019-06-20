//
//  HorizontalCollectionViewFlowLayout.swift
//  HorizontalCollectionView
//
//  Created by kdg-developer on 2019/06/19.
//

import UIKit

public class HorizontalCollectionViewFlowLayout: UICollectionViewFlowLayout {
    /// Used to ignore bounds change when auto scrolling to certain cell
    var ignoringBoundsChange: Bool = false
    
    private var height: CGFloat {
        return collectionView!.bounds.height
    }
    private var numberOfItems: Int {
        return collectionView!.numberOfItems(inSection: 0)
    }
    
    /// Dragging offset (used to calculate which cell is selected)
    private let cellSize: CGSize
    
    // FIXME: OrderedSetのほうが早い?
    private var cache = [UICollectionViewLayoutAttributes]()
    
    public init(cellSize: CGSize){
        self.cellSize = cellSize
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateLayout(forBounds: CGRect) {
        cache.forEach { attribute in
            let origin = CGPoint(x: CGFloat(attribute.indexPath.row) * cellSize.width, y: 0 )
            attribute.frame = CGRect(origin: origin, size: cellSize)
        }
    }
}

extension HorizontalCollectionViewFlowLayout {
    override public var collectionViewContentSize: CGSize {
        return CGSize(width: CGFloat(numberOfItems) * cellSize.width, height: height)
    }
    
    override public func prepare() {
        if cache.isEmpty || cache.count != numberOfItems {
            // FIXME: appendで大丈夫なの?
            cache += (0..<numberOfItems).map { IndexPath(item: $0, section: 0) }.map (UICollectionViewLayoutAttributes.init)
            updateLayout(forBounds: (collectionView?.bounds)!)
        }
    }
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        updateLayout(forBounds: newBounds)
        return !ignoringBoundsChange
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter { $0.frame.intersects(rect) }
    }
}
