//
//  LearnWithLukeDetailCVController.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/28/22.
//

import UIKit

private let reuseIdentifier = "lwlDCell"

class LearnWithLukeDetailCVController: UICollectionViewController {
    
    private var lwlLowercaseLetters = [
        "a", "b", "c", "d"]
    private var lwlButtonText: [String: String] = ["a": "apple", "b": "burger", "c": "carrot", "d": "celery"]
    
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!//SOURCE1
    static let sectionFooterElementKind = "section-footer-element-kind" //footerSetup1
    static let sectionHeaderElementKind = "section-header-element-kind"//headerSetup1
    
    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.setCollectionViewLayout(generateLayout(), animated: false)
        
        collectionView.register(LWLDetailHeader.self, forSupplementaryViewOfKind: LearnWithLukeDetailCVController.sectionHeaderElementKind, withReuseIdentifier: "LWLHeader")
        collectionView.register(LWLDetailFooter.self, forSupplementaryViewOfKind: LearnWithLukeDetailCVController.sectionFooterElementKind, withReuseIdentifier: "LWLFooter")
        
        createDataSource()
    }

    //MARK: - Layout
    func generateLayout() -> UICollectionViewLayout {
        let groupItemCount = 2
        
        // Item definition
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.50),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 5)
        
        // Group definition
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.20)//26
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: groupItemCount
        )
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 1,
            leading: 5,
            bottom: 0,
            trailing: 0
        )
        // Section and layout definition
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 1,
            bottom: 1,
            trailing: 1
        )
        // HeaderSetup3
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(350)//.estimated(400)//364
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: LearnWithLukeDetailCVController.sectionHeaderElementKind,
            alignment: .top)
        
        //FooterSetup3
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(34)
        )
        
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: LearnWithLukeDetailCVController.sectionFooterElementKind,
            alignment: .bottom)
        
        //section.boundarySupplementaryItems = [sectionFooter] //before header
        section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        //had to mover layout after footer for footer to work. Imnitially had below.
        
        return layout
    }
    
    
    // MARK: DataSource

    func createDataSource() {
        ///CELL
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LWLDetailCell
            
            cell.lwlDCellLabel.text = item
            cell.lwlDCellButton.setImage(UIImage(named: self.lwlButtonText[item]!), for: .normal)
            cell.lwlDCellButton.backgroundColor = .orange
            
            return cell
        })
        
        //FooterSetup4 & HeaderSetup4
        dataSource.supplementaryViewProvider = {collectionView, kind, indexPath -> UICollectionReusableView? in
            
            if kind == "section-footer-element-kind" {
                
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LWLFooter", for: indexPath) as! LWLDetailFooter
                footer.backgroundColor = UIColor(named: "miaTalksOrange")
                
                return footer
        
            } else if kind == "section-header-element-kind" {
                
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LWLHeader", for: indexPath) as! LWLDetailHeader
                
                header.backgroundColor = .blue
                header.lwlHeaderImage.backgroundColor = .cyan
                header.lwlHeaderLabel.backgroundColor = .systemTeal
                
                return header
            }
            return nil
        }
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, String>()//SOURCE3
        
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(lwlLowercaseLetters)
        
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    //MARK: - didSelectItemAt

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        print("yes", item.description)
    }
   

}
