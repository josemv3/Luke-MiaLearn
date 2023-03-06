//
//  ViewController.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/10/22.
//


import UIKit


class MenuView: UICollectionViewController {
    private let mediumBorderSize: CGFloat = 4
    let soundPlayer = SystemSoundPlayer()
    var menuData = MenuData()
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!//SOURCE1
    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.setCollectionViewLayout(generateLayout(), animated: false)
        createDataSource()
        navigationItem.title = Title.Menu.rawValue
        menuData.menuDataFinal = menuData.buildMenuDictionary()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(named: Colors.mainBlue.rawValue)
    }
    
    //MARK: - Layout
    
    private func generateLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 10
        let groupItemCount = 1
        
        // Item definition
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 5)
        
        // Group definition
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.15)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: groupItemCount
        )
        group.contentInsets = NSDirectionalEdgeInsets(
            top: spacing,
            leading: 5,
            bottom: 5,
            trailing: 5
        )
        // Section and layout definition
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: spacing,
            leading: spacing,
            bottom: spacing,
            trailing: spacing
        )
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    //MARK: - DataSOurce
    
    private func createDataSource() {
        ///CELL
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.reuseidentifier, for: indexPath) as! MenuCell
            
            cell.menuImageview.image = UIImage(named: item.description)
            cell.menuLessonLabel.text = self.menuData.menuDataFinal[item.description]?.displayName
            cell.menuAgeLabel.text = self.menuData.menuDataFinal[item.description]?.age
            cell.menuImageview.layer.borderWidth = self.mediumBorderSize
            cell.menuImageview.layer.borderColor = UIColor(named: Colors.mainOrange.rawValue)?.cgColor
            
            return cell
        })
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, String>()//SOURCE3
        
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(menuData.snapShotItems)
        
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    //MARK: - DidSelectItemAt
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        //print("menu", item.description)
       
        switch item {
        case String(describing: MenuData.MenuIcons.miaLearnsLogo):
            self.performSegue(withIdentifier: SegueId.goToMiaLearns.rawValue, sender: self)
        case String(describing: MenuData.MenuIcons.miABCQuizLogo):
            self.performSegue(withIdentifier: SegueId.goToMiabcQuiz.rawValue, sender: self)
        case String(describing: MenuData.MenuIcons.learnWLukeLogo):
            self.performSegue(withIdentifier: SegueId.goToLWLuke.rawValue, sender: self)
        case String(describing: MenuData.MenuIcons.miaTalksLogo):
            self.performSegue(withIdentifier: SegueId.goToMiaTalksMenu.rawValue, sender: self)
        case String(describing: MenuData.MenuIcons.storyTimeLogo):
            self.performSegue(withIdentifier: SegueId.goToStoryTimeMenu.rawValue, sender: self)
        case String(describing: MenuData.MenuIcons.findMeLogo):
            self.performSegue(withIdentifier: SegueId.goToFindMeMenu.rawValue, sender: self)
        default:
            self.performSegue(withIdentifier: SegueId.goToLukeTalks.rawValue, sender: self)
        }
        soundPlayer.clickSound()
    }
}

