//
//  LukeTalksViewController2.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 2/9/23.
//

import UIKit

class LukeTalksViewController2: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var lessonVideo: UIImageView!
    @IBOutlet weak var lessonTextLabel: UILabel!
    @IBOutlet weak var lessonTextView: UIView!
    @IBOutlet weak var lessonPromptsCV: UICollectionView!
    @IBOutlet weak var humanVoiceButton: UIButton!
    @IBOutlet weak var robotVoiceButton: UIButton!
    @IBOutlet weak var monsterVoiceButton: UIButton!
    @IBOutlet weak var monsterVoiceImage: UIImageView!
    @IBOutlet weak var humanVoiceImage: UIImageView!
    @IBOutlet weak var robotVoiceImage: UIImageView!
    //enum make array, then make dict
    private var lwlLowercaseLetters = ["1", "2", "3", "4"]
    private var lukeTalksLesson: [String: String] = [
        "1": "apple", "2": "banana", "3": "draw", "4": "aquarium"
    ]
    private var cellImages = ["apple", "banana", "draw", "aquarium"]
    private var lessonText: [String: String] = [
        "1": "Give me an APPLE DUDE!",
        "2": "Bananna, now now now now, do it now!",
        "3": "Im gonna draw until my arm falls off!!! DRAWING!",
        "4": "I like the aquarium. Can we visit the aquarium and see the fishies please?"
    ]
    let videoPlayer = VideoPlayer.shared
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!//SOURCE1
    enum voiceSelection: String {
        case human, monster, robot
    }
    var voiceSelected = voiceSelection.human.rawValue
    
    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lessonVideo.backgroundColor = .black
        lessonVideo.layer.borderWidth = BorderSize.normal.size
        lessonVideo.layer.cornerRadius = CornerRadiusMod.small.size
        lessonVideo.layer.borderColor  = UIColor(named: Colors.mainBlue.rawValue)?.cgColor
        
        lessonPromptsCV.layer.borderWidth = BorderSize.normal.size
        lessonPromptsCV.layer.cornerRadius = CornerRadiusMod.small.size
        lessonPromptsCV.layer.borderColor = UIColor(named: Colors.mainBlue.rawValue)?.cgColor
        lessonPromptsCV.collectionViewLayout = configureLayout()
        
        lessonTextLabel.font = UIFont(name: "Chalkduster", size: 19)
        lessonTextLabel.textColor = UIColor(named: Colors.mainBlue.rawValue)
        //lessonTextLabel.attributedText
        
        lessonTextView.layer.borderWidth = BorderSize.normal.size
        lessonTextView.layer.borderColor = UIColor(named: Colors.mainOrange.rawValue)?.cgColor
        lessonTextView.layer.cornerRadius = CornerRadiusMod.small.size
        
        monsterVoiceImage.layer.cornerRadius = CornerRadiusMod.small.size
        robotVoiceImage.layer.cornerRadius = CornerRadiusMod.small.size
        humanVoiceImage.layer.cornerRadius = CornerRadiusMod.small.size
        
        navigationItem.title = "Luke Talks"
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(named: Colors.mainBlue.rawValue)
        
        configureDataSource()
    }
    override func viewDidDisappear(_ animated: Bool) {
        videoPlayer.playerLayer.player?.pause()
    }
   
    func configureLayout() -> UICollectionViewCompositionalLayout {
        let groupItemCount = 2
        
        // Item definition
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.47),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        // Group definition
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.47)//26
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
        let layout = UICollectionViewCompositionalLayout(section: section)
        //had to mover layout after footer for footer to work. Imnitially had below.
        
        return layout
    }
    
    func configureDataSource() {
        ///CELL
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: lessonPromptsCV, cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LukeTalksCell2.reuseidentifier, for: indexPath) as! LukeTalksCell2
            
            cell.layer.cornerRadius = CornerRadiusMod.small.size
            cell.lukeTalksCellLabel2.text = item
            cell.lukeTalksCellImage2.image = UIImage(named: self.lukeTalksLesson[item]!)
            //cell.lukeTalksCellImage.setImage(UIImage(named: self.lwlButtonText[item]!), for: .normal)
            cell.lukeTalksCellImage2.contentMode = .scaleAspectFit
            cell.lukeTalksCellImage2.backgroundColor = UIColor(named: Colors.miaTalksAltBG.rawValue)
            cell.lukeTalksCellImage2.layer.borderWidth = BorderSize.normal.size
            cell.lukeTalksCellImage2.layer.borderColor = UIColor(named: Colors.mainBlue.rawValue)?.cgColor
            
            return cell
        })
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, String>()//SOURCE3
        
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(lwlLowercaseLetters)
        
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        
        lessonTextLabel.text = lessonText[item]
        let lessonVideoPlay = lukeTalksLesson[item] ?? "apple"
        let videoURLString = voiceSelected + "_" + lessonVideoPlay
        videoPlayer.playVideo(videoName: videoURLString, viewPlayer: lessonVideo)
        
        print(item.description)
    }
    
    @IBAction func voiceButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            clearVoiceUI()
            voiceSelected = voiceSelection.monster.rawValue
            monsterVoiceImage.backgroundColor = .systemGray
        case 2:
            clearVoiceUI()
            voiceSelected = voiceSelection.human.rawValue
            humanVoiceImage.backgroundColor = .systemGray
        case 3:
            clearVoiceUI()
            voiceSelected = voiceSelection.robot.rawValue
            robotVoiceImage.backgroundColor = .systemGray
        default:
            break
        }
    }
    
    func clearVoiceUI() {
        monsterVoiceImage.backgroundColor = UIColor(named: Colors.mainOrange.rawValue)
        humanVoiceImage.backgroundColor = UIColor(named: Colors.mainOrange.rawValue)
        robotVoiceImage.backgroundColor = UIColor(named: Colors.mainOrange.rawValue)
    }
    
}
