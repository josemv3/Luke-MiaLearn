//
//  MiaTalksController.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/12/22.
//

import UIKit
import AVFoundation

private let reuseIdentifier = "miaTalksCell"

private var miatalksLowercaseLetters = [
    "a", "b", "c", "d", "e", "f"]
private var miaTAlksButtonText: [String: String] = ["a": "apple", "b": "burger", "c": "carrot", "d": "celery", "e": "cereal", "f": "banana"]

class MiaTalksController: UICollectionViewController {
    
    var player: AVAudioPlayer?
    var soundTypeSelected = "Human"
    var soundNameToPlay = "None"

    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!//SOURCE1
    static let sectionFooterElementKind = "section-footer-element-kind" //footerSetup1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.setCollectionViewLayout(generateLayout(), animated: false)
        
        collectionView.register(MiaTalksFooterView.self, forSupplementaryViewOfKind: MiaTalksController.sectionFooterElementKind, withReuseIdentifier: "Footer") //footerSetup2
        
        createDataSource()
        self.tabBarController?.tabBar.isHidden = true
        navigationItem.title = "Mia Talks"
    }

    //MARK: - Layout
    private func generateLayout() -> UICollectionViewLayout {
        //wlet spacing: CGFloat = 10
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
            heightDimension: .fractionalHeight(0.26)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: groupItemCount
        )
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
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
        
        //FooterSetup3
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(84)
        )
        
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: MiaTalksController.sectionFooterElementKind,
            alignment: .bottom)
        section.boundarySupplementaryItems = [sectionFooter]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        //had to mover layout after footer for footer to work. Imnitially had below.
        
        return layout
    }

    //MARK: - DataSource
    private func createDataSource() {
        ///CELL
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MiaTalksCell
            
            cell.miaTalkCellLabel.text = item
            //cell.miaTalksButton.setTitle(miaTAlksButtonText[item], for: .normal)
            //cell.miaTalksButton.imageView?.contentMode = UIView.ContentMode.
            cell.miaTalksButton.setImage(UIImage(named: miaTAlksButtonText[item]!), for: .normal)

            return cell
        })
        
        //FooterSetup4
        dataSource.supplementaryViewProvider = {collectionView, kind, indexPath -> UICollectionReusableView? in
            if kind == "section-footer-element-kind" {
                
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath) as! MiaTalksFooterView
                footer.backgroundColor = .systemGray5
                
                return footer
            }
            return nil
        }
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, String>()//SOURCE3
        //var initialSnapshot = NSDiffableDataSourceSnapshot<Int, String>()//SOURCE3
        
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(miatalksLowercaseLetters)
        
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        print(item.description)
        
    }
}
