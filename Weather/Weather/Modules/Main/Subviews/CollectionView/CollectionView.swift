//
//  CollectionView.swift
//  Weather
//
//  Created by Ted on 2021/08/12.
//

import UIKit

class CollectionView: UICollectionView {
    
    // MARK: - Callback
    
    internal var headerDidLoad: ((HourlyCollectionReusableView) -> Void)?
    internal var firstCollectionCellDidLoad: ((DailyCell) -> Void)?
    internal var secondCollectionCellDidLoad: ((SummaryCell) -> Void)?
    internal var thirdCollectionCellDidLoad: ((SubInfoCell) -> Void)?
    
    //MARK: - UI Metrics
    
    private struct UI {
        static let dailyCellHeightRatio = CGFloat(0.4)
        static let summaryCellHeightRatio = CGFloat(0.1)
        static let subInfoCellHeightRatio = CGFloat(0.4)
    }
    
    //MARK: - Init
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        headerDidLoad = nil
        firstCollectionCellDidLoad = nil
        secondCollectionCellDidLoad = nil
        thirdCollectionCellDidLoad = nil
    }
    
}

//MARK: - Setup Views

extension CollectionView {
    
    private func setupViews() {
        dataSource = self
        delegate = self
        
        showsVerticalScrollIndicator = false
        backgroundColor = .white
        
        configureSubViews()
    }
    
    private func configureSubViews() {
        register(HourlyCollectionReusableView.self,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: HourlyCollectionReusableView.identifier)
        
        register(cell: DailyCell.self)
        register(cell: SummaryCell.self)
        register(cell: SubInfoCell.self)
    }
}

//MARK: - UICollectionViewDataSource

extension CollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HourlyCollectionReusableView.identifier, for: indexPath) as! HourlyCollectionReusableView
        
        if let headerDidLoad = headerDidLoad {
            headerDidLoad(header)
        } else {
            return header
        }
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeue(DailyCell.self, indexPath)
            if let firstCollectionCellDidLoad  = firstCollectionCellDidLoad {
                firstCollectionCellDidLoad(cell)
            } else {
                return cell
            }
            return cell
        case 1:
            let cell = collectionView.dequeue(SummaryCell.self, indexPath)
            if let secondCollectionCellDidLoad  = secondCollectionCellDidLoad {
                secondCollectionCellDidLoad(cell)
            } else {
                return cell
            }
            return cell
        case 2:
            let cell = collectionView.dequeue(SubInfoCell.self, indexPath)
            if let thirdCollectionCellDidLoad  = thirdCollectionCellDidLoad {
                thirdCollectionCellDidLoad(cell)
            } else {
                return cell
            }
            return cell
        default:
            break
        }
        
        return UICollectionViewCell()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension CollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.item {
        case 0:
            return CGSize(width: UIScreen.main.bounds.width,
                          height: UIScreen.main.bounds.height * UI.dailyCellHeightRatio)
        case 1:
            return CGSize(width: UIScreen.main.bounds.width,
                          height: UIScreen.main.bounds.height * UI.summaryCellHeightRatio)
        case 2:
            return CGSize(width: UIScreen.main.bounds.width,
                          height: UIScreen.main.bounds.height * UI.subInfoCellHeightRatio)
        default:
            break
        }
        
        return CGSize(width: UIScreen.main.bounds.width, height: 100)
    }
}