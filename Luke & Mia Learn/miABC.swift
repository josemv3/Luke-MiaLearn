//
//  miABC.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/10/22.

//Error after added AVAudioPLayer to play letter sounds:
// 2022-09-10 10:24:27.365873-0700 Luke & Mia Learn[12322:523929] [plugin] AddInstanceForFactory: No factory registered for id <CFUUID 0x6000020d98c0> F8BB1C28-BAE8-11D6-9C31-00039315CD46
//moved audioPlayer variable inside class to satissfy = error still there.


import UIKit
import AVFoundation


private var mainImages: [String: String] = [
    "a": "alligator", "b": "bat", "c": "cat",
    "d": "dinosaur", "e": "elephant", "f": "frog",
    "g": "giraffe", "h": "horse", "i": "iguana"]

private var lowercaseLetters = [
    "a", "b", "c", "d", "e", "f", "g", "h", "i"]

private var mainImageBackgrounds = ["mainBackImage1", "mainBackImage2"]

private var mainWordButtonTitle = ""

//MARK: - Class

class miABC: UIViewController, UICollectionViewDelegate {
    @IBOutlet var mainImageBack: UIImageView!
    @IBOutlet var mainImagebutton: UIButton!
    @IBOutlet var mainWordButton: UIButton!
    
    ///When adding CV to VC control drag CV to VC and make delegate, then add UICVDelegate to class
    @IBOutlet var collectionView: UICollectionView!
    
    var audioPlayer: AVAudioPlayer?
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!//SOURCE1
    //var dataSource: UICollectionViewDiffableDataSource<Int, String>!//SOURCE1
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = configureLayout()
        collectionView.layer.borderWidth = 2 //Magic number
        collectionView.layer.borderColor = UIColor(named: "mainBlue")?.cgColor
        
        mainImageBack.layer.borderWidth = 4 //magic number
        mainImageBack.layer.borderColor = UIColor(named: "mainOrange")?.cgColor
        
        configureDataSource()
        navigationItem.title = "miABC"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(choseLesson))
        mainWordButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 21)
        
    }
    
    //MARK: - Compositional CV LAYOUT
    func configureLayout() -> UICollectionViewCompositionalLayout {
        let spacing: CGFloat = 5
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.4),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.4))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize, subitem: item, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    //MARK: - Data Source (Cell)
    func configureDataSource() {//SOURCE2
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: miABCCell.reusidentifier, for: indexPath) as? miABCCell else {
                fatalError("Cannot create new cell")
            }
            
            cell.miABCCellLabel.text = item.description
            cell.miABCCellImage.image = UIImage(named: item.description)
            
            return cell
        }
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, String>()//SOURCE3
        //var initialSnapshot = NSDiffableDataSourceSnapshot<Int, String>()//SOURCE3
        
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(lowercaseLetters)
        
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
   
    //MARK: - Selected Item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        print(item)
    
        //mainLabel.text = mainImages[item]
        mainWordButtonTitle = mainImages[item] ?? "greeting"
        mainWordButton.setTitle(mainImages[item.description], for: .normal)
        mainImagebutton.setImage(UIImage(named: mainImages[item] ?? "greeting"), for: .normal)
        mainImageBack.image = UIImage(named: mainImageBackgrounds.randomElement() ?? "mainBackImage1")
        //trying to change background image each time:
//        if mainImageBack.image?.description == "mainBackImage1" {
//
//            mainImageBack.image = UIImage(named: "mainBackImage2")
//        } else {
//            mainImageBack.image = UIImage(named: "mainBackImage1")
//        }
        playSound(soundName: item)
    }
    
    
    //MARK: - Sound Player
    
    func playSound(soundName: String) {

            let urlString = Bundle.main.path(forResource: soundName, ofType: "mp3")
            //let pathToSound = Bundle.main.path(forResource: soundName, ofType: ".mp3") ?? "a.mp3"
            //let url = URL(fileURLWithPath: pathToSound)
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else {
                    return
                }
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                //audioPlayer = try AVAudioPlayer(contentsOf: url)
                //audioPlayer?.volume = 0.50
                //audioPlayer?.play()
                guard let audioPlayer = audioPlayer else {
                    return
                }
                audioPlayer.play()

            } catch {
                //error handling
                print("error")
            }
        }
    
    //MARK: - Main Image Button (top)
    @IBAction func mainImageButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func mainWordButton(_ sender: UIButton) {
        playSound(soundName: mainWordButtonTitle)
    }
    
    //MARK: - Alert Choices
    @objc func choseLesson() {
        let alert = UIAlertController(title: "More Lessons", message: "Chose A Lesson Bellow!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ABC Objects", style: .destructive, handler: { (action) in
            print("ABC Objects")
        }))
        alert.addAction(UIAlertAction(title: "Colors", style: .default, handler: { (action) in
            print("Colors")
        }))
        alert.addAction(UIAlertAction(title: "Shapes", style: .default, handler: { (action) in
            print("Shapes")
        }))
        alert.addAction(UIAlertAction(title: "Numbers", style: .destructive, handler: { (action) in
            print("Numbers")
        }))
        alert.addAction(UIAlertAction(title: "Instruments to Play", style: .destructive, handler: { (action) in
            print("Instruments to Play")
        }))
        alert.addAction(UIAlertAction(title: "Toys", style: .destructive, handler: { (action) in
            print("Toys")
        }))
        
        self.present(alert, animated: true)
    }
    
    
}
