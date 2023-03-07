//
//  LWLukeDetailView.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 3/3/23.
//

import UIKit

class LWLukeDetailView: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var lwlLabelView: UIView!
    @IBOutlet weak var lwLukeCV: UICollectionView!
    @IBOutlet weak var lwlMainView: UIImageView!
    @IBOutlet weak var lwlMainLabel: UILabel!
    var lwlData = LearnWLukeData()
    var lwlText = LearnWLukeText()
   
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!//SOURCE1
    var learnWLukeLessonChoice = ""
    let videoPlayer = VideoPlayer2.shared
    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lwlData.getButtonMedia() //Also calls getItems() = snapshot
        lwlData.getMediaNames(category: "Asteroid belt")
       
        lwLukeCV.setCollectionViewLayout(generateLayout(), animated: false)
        createDataSource()
        lwLukeCV.layer.borderWidth = BorderSize.normal.size
        lwLukeCV.layer.borderColor = UIColor(named: Colors.learnWLukePink.rawValue)?.cgColor
        lwlLabelView.layer.borderWidth = BorderSize.normal.size
        lwlLabelView.layer.borderColor = UIColor(named: Colors.learnWLukePink.rawValue)?.cgColor
        lwlMainView.layer.borderWidth = BorderSize.normal.size
        lwlMainView.layer.borderColor = UIColor(named: Colors.learnWLukePink.rawValue)?.cgColor
        
        //used in didSelectItemAt (Convert in one place to use later)
        let enumValue = LearnWLukeData.Space(rawValue: learnWLukeLessonChoice.replacingOccurrences(of: " ", with: "_")) //.Asteroid_belt
        lwlMainLabel.text = lwlText.lessonText[enumValue ?? .Asteroid_belt]?[0]
        
        videoPlayer.playVideo(videoName: lwlData.mediaNames["a"] ?? "a", viewPlayer: lwlMainView)
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
            heightDimension: .fractionalHeight(0.75)//26
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: groupItemCount
        )
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 15,
            bottom: 0,
            trailing: 15
        )
        // Section and layout definition
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 15,
            leading: 1,
            bottom: 1,
            trailing: 1
        )

        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    // MARK: DataSource

    func createDataSource() {
        ///CELL
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: lwLukeCV, cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: lwLukeDetailCell.reusidentifier, for: indexPath) as! lwLukeDetailCell
            
            cell.cellImageView.image = UIImage(named: self.lwlData.buttonMedia[item] ?? "1lwl")
            cell.layer.borderWidth = BorderSize.normal.size
            cell.layer.borderColor = UIColor(named: Colors.learnWLukePink.rawValue)?.cgColor
            cell.cellImageView.layer.backgroundColor = UIColor(named: Colors.mainBlue.rawValue)?.cgColor
            return cell
        })
       
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, String>()//SOURCE3
        
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(lwlData.items)
        
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        print(item)
        
        let enumValue = LearnWLukeData.Space(rawValue: learnWLukeLessonChoice.replacingOccurrences(of: " ", with: "_")) //.Asteroid_belt
            
        switch item {
        case "a":
            removeVideoPlayer()
            lwlMainView.image = nil
            videoPlayer.playVideo(videoName: lwlData.mediaNames[item] ?? "a", viewPlayer: lwlMainView)
            lwlMainLabel.text = lwlText.lessonText[enumValue ?? .Asteroid_belt]?[0]
        case "b":
            removeVideoPlayer()
            lwlMainView.image = nil
            videoPlayer.playVideo(videoName: lwlData.mediaNames[item] ?? "a", viewPlayer: lwlMainView)
            lwlMainLabel.text = lwlText.lessonText[enumValue ?? .Asteroid_belt]?[1]
        case "c":
            removeVideoPlayer()
            lwlMainView.image = UIImage(named: lwlData.mediaNames[item]!)
            lwlMainLabel.text = lwlText.lessonText[enumValue ?? .Asteroid_belt]?[2]
        default:
            removeVideoPlayer()
            lwlMainView.image = UIImage(named: lwlData.mediaNames[item]!)
            lwlMainLabel.text = lwlText.lessonText[enumValue ?? .Asteroid_belt]?[3]
        }
    }
    
    func removeVideoPlayer() {
        videoPlayer.player?.pause()
        videoPlayer.player = nil
        videoPlayer.playerLayer.removeFromSuperlayer()
        //myImageView.image = UIImage(named: "myImage")
    }
}
