//
//  MiaTalksController.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/12/22.
//

import UIKit
import AVFoundation

class MiaTalksView: UICollectionViewController {
    var recieverString = PlaceHolder.human.rawValue
    var audioPlayer2 = AudioPlayer.shared
    var miaTalksData = MiaTalksData()
    var dataSource: UICollectionViewDiffableDataSource<Section, MiaTalksItem>!//SOURCE1
    static let sectionFooterElementKind = "section-footer-element-kind" //footerSetup1
    static let sectionHeaderElementKind = "section-header-element-kind"//headerSetup1
    var currentLesson: MiaTalksData.CurrentLesson = .iLike {
        didSet {
            updateDataSource()
        }
    }
    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //miaTalksData.lessonSet = miaTalksData.makeLessonSet(valueSet: MiaTalksData.ILike.self)
        collectionView.setCollectionViewLayout(generateLayout(), animated: false)
        collectionView.register(MiaTalksHeaderView.self, forSupplementaryViewOfKind: MiaTalksView.sectionHeaderElementKind, withReuseIdentifier: "Header")//headerSetup2
        collectionView.register(MiaTalksFooterView.self, forSupplementaryViewOfKind: MiaTalksView.sectionFooterElementKind, withReuseIdentifier: "Footer")//footerSetup2
        navigationItem.title = Title.MiaTalks.rawValue
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(choseLesson))
        createDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recieverString = PlaceHolder.human.rawValue
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
            heightDimension: .fractionalHeight(0.24)//26
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
            heightDimension: .estimated(64)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: MiaTalksView.sectionHeaderElementKind,
            alignment: .top)
        
        //FooterSetup3
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(94)
        )
        
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: MiaTalksView.sectionFooterElementKind,
            alignment: .bottom)
        
        //section.boundarySupplementaryItems = [sectionFooter] //before header
        section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        //had to mover layout after footer for footer to work. Imnitially had below.
        
        return layout
    }
    
    //MARK: - DataSource
    
    private func createDataSource() {
        ///CELL
        dataSource = UICollectionViewDiffableDataSource<Section, MiaTalksItem>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MiaTalksCell.reuseidentifier, for: indexPath) as! MiaTalksCell
            
            cell.miaTalkCellLabel.text = item.rawValue
            cell.miaTalksView.image = UIImage(named: item.rawValue)
            
            return cell
        })
        
        //FooterSetup4 & HeaderSetup4
        dataSource.supplementaryViewProvider = {collectionView, kind, indexPath -> UICollectionReusableView? in
            
            if kind == "section-footer-element-kind" {
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath) as! MiaTalksFooterView
                footer.backgroundColor = UIColor(named: Colors.miaTalksOrange.rawValue)
                footer.delegate = self
                
                return footer
            } else if kind == "section-header-element-kind" {
                
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! MiaTalksHeaderView
                
                header.miaTalksHeaderLabel.backgroundColor = UIColor(named: Colors.miaTalksOrange.rawValue)
                header.miaTalksHeaderLabel.text = "I Like..."
                header.miaTalksHeaderLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 20)
                
                return header
            }
            return nil
        }
        
        updateDataSource()
    }
    
    func updateDataSource() {
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, MiaTalksItem>()//SOURCE3
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(currentLesson.lessons)
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    //MARK: - Did Select Item At
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        
        if collectionView.indexPathsForSelectedItems != nil {
            collectionView.cellForItem(at: indexPath)?.alpha = 0.5
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                collectionView.cellForItem(at: indexPath)?.alpha = 1.0
            }
        }
        audioPlayer2.playSound(soundName: recieverString + (item.rawValue))
    }
    
    //MARK: - Alert Action
    
    @objc func choseLesson() {
        
        //Placeholder assets and text
        let alert = UIAlertController(title: "More Lessons", message: "Chose a lesson bellow!", preferredStyle: .alert)
        
        ///left image
        let imgTitle = UIImage(named:"blue.png")
        let imgViewTitle = UIImageView(frame: CGRect(x: 10, y: 82, width: 40, height: 40))
        imgViewTitle.image = imgTitle
        alert.view.addSubview(imgViewTitle)
        
        ///First Alt lesson:
        alert.addAction(UIAlertAction(title: "Colors", style: .default, handler: { (action) in
            
            print("Colors")
        }))
        ///right image
        let imageView = UIImageView(frame: CGRect(x: 220, y: 82, width: 40, height: 40))
        imageView.image = UIImage(named: "red.png")
        alert.view.addSubview(imageView)
        
        ///Second Alt lesson:
        alert.addAction(UIAlertAction(title: "ABC Objects", style: .default, handler: { (action) in
            print("ABC Objects")
        }))
        let imageView2 = UIImageView(frame: CGRect(x: 220, y: 127, width: 40, height: 40))
        imageView2.image = UIImage(named: "miABCLogo.svg")
        alert.view.addSubview(imageView2)
        
        ///Third Alt lesson:
        alert.addAction(UIAlertAction(title: "Shapes", style: .default, handler: { (action) in
            print("Shapes")
        }))
        let imageView3 = UIImageView(frame: CGRect(x: 220, y: 172, width: 40, height: 40))
        imageView3.image = UIImage(named: "heart.png")
        alert.view.addSubview(imageView3)
        
        self.present(alert, animated: true)
    }
}

extension MiaTalksView: MiaTalksFooterViewDelegate {
    func didSelectSoundType(_ soundType: String) {
        recieverString = soundType
    }
}
