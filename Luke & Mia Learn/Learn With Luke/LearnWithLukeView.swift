//
//  LearnWithLukeController.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/12/22.
//

import UIKit

class LearnWithLukeView: UICollectionViewController {
    
    private let searchController = UISearchController()
    private lazy var filteredItems: [String] = lukeData.lessonItems
    private var dataSource: UICollectionViewDiffableDataSource<Character, String>!
    static let sectionHeaderElementKind = "section-header-element-kind"
    var itemChosen = ""
    var lukeData = LearnWLukeData()
    
    //Section in the Snampshot is a Character coming from initial letter in the for loop below:
    var filteredItemsSnapshot: NSDiffableDataSourceSnapshot<Character, String> {
        var snapshot = NSDiffableDataSourceSnapshot<Character, String>()
        
        for section in lukeData.initialLetters {
            snapshot.appendSections([section])
            snapshot.appendItems(lukeData.itemsByInitialLetter[section]!)
        }
        
        return snapshot
    }
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        lukeData.getLesson(lesson: LearnWLukeData.Space.self)
        collectionView.backgroundColor = UIColor(named: Colors.learnWLukeBlue.rawValue)
        collectionView.setCollectionViewLayout(generateLayout(), animated: false)
        collectionView.register(LearnWithLukeHeader.self,forSupplementaryViewOfKind: LearnWithLukeView.sectionHeaderElementKind,withReuseIdentifier: Title.ViewNames.Header.rawValue)
        navigationItem.title = Title.LearnWithLuke.rawValue
        
        //states = lessonItems
        lukeData.itemsByInitialLetter = lukeData.lessonItems.reduce([:]) { existing, element in
            return existing.merging([element.first!:[element]]) { old, new in
                return old + new
            }
        }
        lukeData.initialLetters = lukeData.itemsByInitialLetter.keys.sorted()
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        createDataSource()
    }
    
    //MARK: - Generate Layout
    private func generateLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 10
        
        // Item definition
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.50),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        // Group definition
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(175.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 2
        )
        group.contentInsets = NSDirectionalEdgeInsets(
            top: spacing,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        // Section and layout definition
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: spacing,
            leading: spacing,
            bottom: spacing,
            trailing: spacing
        )
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: LearnWithLukeView.sectionHeaderElementKind,
            alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    //MARK: - CreateDataSource
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Character, String>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LearnWithLukeCell.reuseIdentifier, for: indexPath) as! LearnWithLukeCell
            
            cell.layer.borderWidth = BorderSize.normal.size
            cell.layer.cornerRadius = CornerRadiusMod.small.size
            cell.layer.borderColor = UIColor(named: Colors.learnWLukePink.rawValue)?.cgColor
            cell.learnWithLukeCellLabel.text = item
            cell.learnWithLukeCellLabel.font = UIFont(name: Title.Font.Chalkduster.rawValue, size: 14)
            cell.learnWithLukeCellLabel.textColor = UIColor(named: Colors.learnWLukeGreen.rawValue)
            cell.learnWithLukeCellLabel.backgroundColor = UIColor(named: Colors.learnWLukePink.rawValue)
            cell.learnWithLukeCellLabel.layer.masksToBounds = true
            cell.learnWithLukeImage.image = UIImage(named: item)
            return cell
        })
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: Title.ViewNames.Header.rawValue, for: indexPath) as! LearnWithLukeHeader
            
            header.label.text = String(self.lukeData.initialLetters[indexPath.section])
            header.label.font = UIFont(name: Title.Font.Chalkduster.rawValue, size: 18)
            header.label.textColor = UIColor(named: Colors.learnWLukeGreen.rawValue)
            
            return header
        }
        
        dataSource.apply(filteredItemsSnapshot)
    }
    
    //MARK: - DidSelectItem
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        itemChosen = item
        
        //perform segue, use item to grab data
        
        if item == "Asteroid belt" {
            self.performSegue(withIdentifier: "lwLukeDetailView", sender: self)
        } else {
            print("no Segue")
        }
    }
    //change to new VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "lwLukeDetailView" {
            let destinationVC = segue.destination as! LWLukeDetailView
            destinationVC.learnWLukeLessonChoice = itemChosen
        }
    }
}

    //MARK: - Extension
extension LearnWithLukeView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text,
           searchString.isEmpty == false {
            filteredItems = lukeData.lessonItems.filter { item -> Bool in
                item.localizedCaseInsensitiveContains(searchString)
            }
        } else {
            filteredItems = lukeData.lessonItems
        }
        
        lukeData.itemsByInitialLetter = filteredItems.reduce([:]) { existing, element in
            return existing.merging([element.first!:[element]]) { old, new in
                return old + new
            }
        }
        lukeData.initialLetters = lukeData.itemsByInitialLetter.keys.sorted()
        dataSource.apply(filteredItemsSnapshot, animatingDifferences: true)
    }
    
    
}








//        "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware",
//        "Florida","Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky",
//        "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi",
//        "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico",
//        "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania",
//        "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont",
//        "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"
//    ]
