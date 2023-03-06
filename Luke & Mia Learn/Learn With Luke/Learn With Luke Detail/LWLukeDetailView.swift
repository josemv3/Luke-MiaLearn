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
    //, "c": "1lwl", "d": "2lwl"
    private var lwlLowercaseLetters = [
        "a", "b", "c", "d"]
    private var lwlButtonText: [String: String] = ["a": "1lwl", "b": "2lwl", "c": "3lwl", "d": "playlwl"]
    private let videos = ["a": "asteroid1", "b": "asteroid2"]
    private let lessonText: [String: String] = [
        "a": "Scattered in orbits around the sun are bits and pieces of rock left over from the beginning of the solar system. Most of these objects are asteroids.",
        "b": "Unlike Earths moon, asteroids are not made of cheese but are different types of rocks.",
        "c":"The asteroid belt is located between Mars and Jupiter, the 4th and 5th planets in our solar system.",
        "d":"To be an asteroid you must be about 10 meters or over 32 feet! Thats bigger than a person, elephant, or Monster truck!"]
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!//SOURCE1
    var learnWLukeLessonChoice = ""
    let videoPlayer = VideoPlayer2.shared
    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lwLukeCV.setCollectionViewLayout(generateLayout(), animated: false)
        createDataSource()
        lwLukeCV.layer.borderWidth = BorderSize.normal.size
        lwLukeCV.layer.borderColor = UIColor(named: Colors.learnWLukePink.rawValue)?.cgColor
        lwlLabelView.layer.borderWidth = BorderSize.normal.size
        lwlLabelView.layer.borderColor = UIColor(named: Colors.learnWLukePink.rawValue)?.cgColor
        lwlMainView.layer.borderWidth = BorderSize.normal.size
        lwlMainView.layer.borderColor = UIColor(named: Colors.learnWLukePink.rawValue)?.cgColor
        lwlMainLabel.text = lessonText["a"]
        videoPlayer.playVideo(videoName: videos["a"] ?? "a", viewPlayer: lwlMainView)
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
            
            cell.cellImageView.image = UIImage(named: self.lwlButtonText[item] ?? "1lwl")
            cell.layer.borderWidth = BorderSize.normal.size
            cell.layer.borderColor = UIColor(named: Colors.learnWLukePink.rawValue)?.cgColor
            cell.cellImageView.layer.backgroundColor = UIColor(named: Colors.mainBlue.rawValue)?.cgColor
            return cell
        })
       
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, String>()//SOURCE3
        
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(lwlLowercaseLetters)
        
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        print(item)
        
        switch item {
        case "a":
            removeVideoPlayer()
            lwlMainView.image = nil
            videoPlayer.playVideo(videoName: videos[item] ?? "a", viewPlayer: lwlMainView)
            lwlMainLabel.text = lessonText["a"]
        case "b":
            removeVideoPlayer()
            lwlMainView.image = nil
            videoPlayer.playVideo(videoName: videos[item] ?? "a", viewPlayer: lwlMainView)
            lwlMainLabel.text = lessonText["b"]
        case "c":
            removeVideoPlayer()
            lwlMainView.image = UIImage(named: "asteroidBetween")
            lwlMainLabel.text = lessonText["c"]
        default:
            removeVideoPlayer()
            lwlMainView.image = UIImage(named: "asteroidSize")
            lwlMainLabel.text = lessonText["d"]
        }
        
    }
    
//    func playVideo() {
//        videoPlayer.playVideo(videoName: "myVideo", viewPlayer: lwlMainView)
//    }
    
    func removeVideoPlayer() {
        videoPlayer.player?.pause()
        videoPlayer.player = nil
        videoPlayer.playerLayer.removeFromSuperlayer()
        //myImageView.image = UIImage(named: "myImage")
    }
}
