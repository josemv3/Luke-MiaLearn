//
//  LukeTalksCollectionView.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 12/9/22.
//

import UIKit
import AVFoundation
import AVKit

class LukeTalksViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var lukeTalksCollectionView: UICollectionView!
    
    private var lwlLowercaseLetters = ["a", "b", "c", "d"]
    private var lwlButtonText: [String: String] = ["a": "apple", "b": "banana", "c": "draw", "d": "aquarium"]
    private var cellImages = ["apple", "banana", "draw", "aquarium"]
    private var lessonText = ["I like the aquarium. Can we visit the aquarium and see the fishies please?"]
    
    
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!//SOURCE1
    static let sectionFooterElementKind = "section-footer-element-kind" //footerSetup1
    static let sectionHeaderElementKind = "section-header-element-kind"//headerSetup1
    //let videoplayer = VideoPlayer.shared
    //var playerLayer = AVPlayerLayer()
    
    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lukeTalksCollectionView.collectionViewLayout = configureLayout()
        
        lukeTalksCollectionView.register(LukeTalksHeader.self, forSupplementaryViewOfKind: LukeTalksViewController.sectionHeaderElementKind, withReuseIdentifier: "LukeTalksHeader")
        lukeTalksCollectionView.register(LukeTalksFooter.self, forSupplementaryViewOfKind: LukeTalksViewController.sectionFooterElementKind, withReuseIdentifier: "LukeTalksFooter")
        configureDataSource()
        
    }
    
    func configureLayout() -> UICollectionViewCompositionalLayout {
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
            heightDimension: .absolute(310)//.estimated(400)//364 Was 350
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: LukeTalksViewController.sectionHeaderElementKind,
            alignment: .top)
        sectionHeader.pinToVisibleBounds = true
        
        //FooterSetup3
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(94) //64
        )
        
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: LukeTalksViewController.sectionFooterElementKind,
            alignment: .bottom)
        sectionFooter.pinToVisibleBounds = true
        
        //section.boundarySupplementaryItems = [sectionFooter] //before header
        section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        //had to mover layout after footer for footer to work. Imnitially had below.
        
        return layout
    }
    
    func configureDataSource() {
        ///CELL
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: lukeTalksCollectionView, cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LukeTalksCell.reuseidentifier, for: indexPath) as! LukeTalksCell
            
            cell.layer.cornerRadius = 5
            cell.lukeTalksCellLabel.text = item
            cell.lukeTalksCellImage.image = UIImage(named: self.lwlButtonText[item]!)
            //cell.lukeTalksCellImage.setImage(UIImage(named: self.lwlButtonText[item]!), for: .normal)
            cell.lukeTalksCellImage.contentMode = .scaleAspectFit
            cell.lukeTalksCellImage.backgroundColor = UIColor(named: "learnWLukeGreen")
            cell.lukeTalksCellImage.layer.borderWidth = 4
            cell.lukeTalksCellImage.layer.borderColor = UIColor(named: "learnWLukePink")?.cgColor
            
            return cell
        })
        
        //FooterSetup4 & HeaderSetup4
        dataSource.supplementaryViewProvider = {collectionView, kind, indexPath -> UICollectionReusableView? in
            
            if kind == "section-footer-element-kind" {
                
                let footer = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind, withReuseIdentifier: "LukeTalksFooter",
                    for: indexPath) as! LukeTalksFooter
                
                footer.backgroundColor = UIColor(named: "mainBlue")
                
                return footer
        
            } else if kind == "section-header-element-kind" {
                
                let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind, withReuseIdentifier: "LukeTalksHeader",
                    for: indexPath) as! LukeTalksHeader

                header.backgroundColor = .white
                header.lukeTalksHeaderImage.backgroundColor = .black
                header.lukeTalksHeaderImage.contentMode = .scaleToFill
                header.lukeTalksHeaderImage.layer.borderWidth = 5
                header.lukeTalksHeaderImage.layer.cornerRadius = 5
                header.lukeTalksHeaderImage.layer.borderColor = UIColor(named: "learnWLukePurple")?.cgColor
            
                header.lukeTalksHeaderLabel.contentMode = .scaleToFill
                header.lukeTalksHeaderLabel.font = UIFont(name: "Chalkduster", size: 17)
                header.lukeTalksHeaderLabel.textColor = UIColor(named: "learnWLukePurple")
                header.lukeTalksHeaderLabel.numberOfLines = 4
                header.lukeTalksHeaderLabel.text = self.lessonText[0]
                
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        print("yes", item.description)
        
        
        guard let header = (collectionView.supplementaryView(
            forElementKind: "section-header-element-kind",
            at: IndexPath(item: 0, section: 0)) as? LukeTalksHeader) else { return }
        header.playVideo()
    }
}







//in  didSelectItem
//        let supplementaryView = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: indexPath)
//
//        if let headerView = supplementaryView as? LukeTalksHeader {
//            // Update the image view within the header view
//            headerView.headerCurrentVideo = "human_draw"
//            headerView.LukeTalksHeaderImage.image = UIImage(named: headerView.headerCurrentVideo)
//            //videoplayer.playVideo(songName: headerView.headerCurrentVideo, viewPlayer: headerView.LukeTalksHeaderImage)
//            print(headerView.headerCurrentVideo)
//
//        } else if let footerView = supplementaryView as? LukeTalksFooter {
//            // You can do the same for the footer,
//            //Or you can just update the state or content of the footerView if you want
//        }
