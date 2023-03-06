//
//  LearnWithLukeDetailCVController.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/28/22.
//

import UIKit

private let reuseIdentifier = "lwlDCell"

//"Scattered in orbits around the sun are bits and pieces of rock left over from the beginning of the solar system. Most of these objects are asteroids.",
//"The asteroid belt is located between Mars and Jupiter, the 4th and 5th planets in our solar system.",
//"Unlike Earths moon, asteroids are not made of cheese but are different types of rocks. ",
//"To be an asteroid you must be about 10 meters or over 32 feet! Thats bigger than a person, elephant, or Monster truck!"

class LearnWithLukeDetailCVController: UICollectionViewController {
    
    private var lwlLowercaseLetters = [
        "a", "b", "c", "d"]
    private var lwlButtonText: [String: String] = ["a": "1lwl", "b": "2lwl", "c": "3lwl", "d": "playlwl"]
    
    static let sectionFooterElementKind = "section-footer-element-kind" //footerSetup1
    static let sectionHeaderElementKind = "section-header-element-kind"//headerSetup1
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!//SOURCE1
    var learnWLukeLessonChoice = ""
    
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
            widthDimension: .fractionalWidth(0.45),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
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
            leading: 15,
            bottom: 0,
            trailing: 15
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
        sectionHeader.pinToVisibleBounds = true
        
        //FooterSetup3
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(64)
        )
        
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: LearnWithLukeDetailCVController.sectionFooterElementKind,
            alignment: .bottom)
        //sectionFooter.pinToVisibleBounds = true
        
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
            
            cell.layer.cornerRadius = 5
            cell.lwlDCellLabel.text = item
            cell.lwlDCellButton.setImage(UIImage(named: self.lwlButtonText[item]!), for: .normal)
            cell.lwlDCellButton.contentMode = .scaleAspectFit
            cell.lwlDCellButton.backgroundColor = UIColor(named: "learnWLukeGreen")
            cell.lwlDCellButton.layer.borderWidth = 4
            cell.lwlDCellButton.layer.borderColor = UIColor(named: "learnWLukePink")?.cgColor
            
            return cell
        })
        
        //FooterSetup4 & HeaderSetup4
        dataSource.supplementaryViewProvider = {collectionView, kind, indexPath -> UICollectionReusableView? in
            
            if kind == "section-footer-element-kind" {
                
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LWLFooter", for: indexPath) as! LWLDetailFooter
                footer.backgroundColor = .clear //UIColor(named: "mainBlue")
                
                return footer
        
            } else if kind == "section-header-element-kind" {
                
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LWLHeader", for: indexPath) as! LWLDetailHeader
                
                header.backgroundColor = .white
                header.lwlHeaderImage.backgroundColor = .cyan
                //header.lwlHeaderLabel.backgroundColor = .systemTeal
                
                header.lwlHeaderImage.image = UIImage(named: "asteroidBetween")
                header.lwlHeaderImage.contentMode = .scaleAspectFill
                
                header.lwlHeaderLabel.contentMode = .scaleToFill
                //header.lwlHeaderLabel.font = UIFont(name: "Chalkduster", size: 14)
                header.lwlHeaderLabel.textColor = UIColor(named: "learnWLukePurple")
                header.lwlHeaderLabel.numberOfLines = 4
                header.lwlHeaderLabel.text = "The asteroid belt is located between Mars and Jupiter, the 4th and 5th planets in our solar system."
                
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
