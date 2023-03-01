//
//  ViewController.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/10/22.
//


import UIKit


class MenuController: UICollectionViewController {
    private let reuseIdentifier = "cell"
    private let mediumBorderSize: CGFloat = 4
    
    let lessonIconImage = ["miaLearnsLogo", "miABCQuizLogo", "miaTalksLogo", "learnWLukeLogo", "findMeLogo", "storyTimeLogo", "lukeTalksLogo"]
    let lessonLabelName: [String: String] = ["miaLearnsLogo": "Mia learns", "miABCQuizLogo": "Mia abc quiz", "miaTalksLogo": "Mia talks", "learnWLukeLogo": "Learn with Luke", "findMeLogo": "Find me", "storyTimeLogo": "Story Time", "lukeTalksLogo": "Luke Talks"]
    let lessonLabelAge : [String: String] = ["miaLearnsLogo": "Age: 2+", "miABCQuizLogo": "Age: 2+", "miaTalksLogo": "Age: 3+", "learnWLukeLogo": "Age: 4+", "findMeLogo": "Age: 5+", "storyTimeLogo": "Age 3+", "lukeTalksLogo": "Age 3+"]
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!//SOURCE1

    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.setCollectionViewLayout(generateLayout(), animated: false)
        createDataSource()
        navigationItem.title = "Menu"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(named: "mainBlue")
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as! MenuCell
            
            cell.menuImageview.image = UIImage(named: item.description)
            cell.menuLessonLabel.text = self.lessonLabelName[item.description]
            cell.menuAgeLabel.text = self.lessonLabelAge[item.description]

            cell.menuImageview.layer.borderWidth = self.mediumBorderSize
            cell.menuImageview.layer.borderColor = UIColor(named: "mainOrange")?.cgColor
            
            return cell
        })
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, String>()//SOURCE3
        
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(lessonIconImage)
        
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    //MARK: - DidSelectItemAt
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        print("menu", item.description)
       
        switch item {
        case "miaLearnsLogo":
            self.performSegue(withIdentifier: SegueId.goToMiaLearns.rawValue, sender: self)
        case "miABCQuizLogo":
            self.performSegue(withIdentifier: SegueId.goToMiabcQuiz.rawValue, sender: self)
        case "learnWLukeLogo":
            self.performSegue(withIdentifier: SegueId.goToLWLuke.rawValue, sender: self)
        case "miaTalksLogo":
            self.performSegue(withIdentifier: SegueId.gotoMiaTalksMenu.rawValue, sender: self)
        case "storyTimeLogo":
            self.performSegue(withIdentifier: SegueId.gotoStoryTimeMenu.rawValue, sender: self)
        case "lukeTalksLogo":
            self.performSegue(withIdentifier: SegueId.goToLukeTalks.rawValue, sender: self)
        default:
            self.performSegue(withIdentifier: SegueId.goToLukeTalks.rawValue, sender: self)
            //print("error") //replace with miABC
        }
    }
}

