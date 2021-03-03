//
//  COCOCOllectionView.swift
//  COCO
//
//  Created by Tuyen Le on 3/2/21.
//

import UIKit
import RxDataSources

class COCOCollectionView: UICollectionView {
    let backgroundLabel: UILabel = UILabel()
    
    let cocoDataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, ImageResult>>(configureCell: { _, collectionView, indexPath, imageResult in

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? COCOCollectionViewCell else {
            fatalError("Expecting COCCollectionViewCell but found nil")
        }
        
        cell.display(imageResult: imageResult, at: indexPath)
        
        return cell
    })
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
    private func setup() {
        backgroundLabel.textAlignment = .center
        backgroundLabel.backgroundColor = .white
        backgroundLabel.textColor = .black
        backgroundView = backgroundLabel
        
        collectionViewLayout = UICollectionViewLayout.coco()
        register(UINib(nibName: String(describing: COCOFooterSupplementaryView.self), bundle: nil),
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                withReuseIdentifier: "footer")
        register(UINib(nibName: String(describing: COCOHeaderSupplementaryView.self), bundle: nil),
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: "header")
        
        register(UINib(nibName: String(describing: COCOCollectionViewCell.self), bundle: nil),
                 forCellWithReuseIdentifier: "cell")
        
        dataSource = nil
        
        cocoDataSource.configureSupplementaryView = { data, collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                       withReuseIdentifier: "header",
                                                                       for: indexPath) as! COCOHeaderSupplementaryView
            }
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                   withReuseIdentifier: "footer",
                                                                   for: indexPath) as! COCOFooterSupplementaryView
        }
    }
    
}
