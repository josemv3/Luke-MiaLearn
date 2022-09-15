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
private let smallBorderSize: CGFloat = 2
private let mediumBorderSize: CGFloat = 4

//MARK: - Class

class miABC: UIViewController, UICollectionViewDelegate {
    @IBOutlet var mainImageBack: UIImageView!
    @IBOutlet var mainImagebutton: UIButton!
    @IBOutlet var mainWordButton: UIButton!
    ///When adding CV to VC control drag CV to VC and make delegate, then add UICVDelegate to class
    @IBOutlet var collectionView: UICollectionView!
    
    var currentAnimation = 0
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
        collectionView.layer.borderWidth = smallBorderSize //2
        collectionView.layer.borderColor = UIColor(named: "mainBlue")?.cgColor
        
        mainImageBack.layer.borderWidth = mediumBorderSize //4
        mainImageBack.layer.borderColor = UIColor(named: "mainOrange")?.cgColor
        
        configureDataSource()
        navigationItem.title = "miABC"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(choseLesson))
        mainWordButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 21)//doesnt work
        
    }
    
    //MARK: - Compositional CV LAYOUT
    func configureLayout() -> UICollectionViewCompositionalLayout {
        let spacing: CGFloat = 5
        let grouItemCount = 3
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
            layoutSize: groupSize, subitem: item, count: grouItemCount)
        
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
        self.mainImagebutton.transform = .identity //read bellow:
        currentAnimation = 0 //this resets animation on mainImage if another letter is pressed.
        //mainWordButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 16) //not working
        
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
                print("error")
            }
        }
    
    //MARK: - Main Image Button (top)
    @IBAction func mainImageButtonPressed(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.20, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 25, options: [], animations: {
            
            switch self.currentAnimation {
            case 0:self.mainImagebutton.transform = CGAffineTransform(scaleX: 2, y: 2)
                break
            case 1:
                self.mainImagebutton.transform = .identity
            case 2:
                self.mainImagebutton.transform = CGAffineTransform(rotationAngle: .pi)
            case 3:
                self.mainImagebutton.transform = .identity
           
            default:
                break
            }
            self.currentAnimation += 1
            
            if self.currentAnimation > 3 {
                self.currentAnimation = 0
            }
        })
    }
    
    @IBAction func mainWordButton(_ sender: UIButton) {
        playSound(soundName: mainWordButtonTitle)
    }
    
    //MARK: - Alert Choices
    @objc func choseLesson() {
        let alert = UIAlertController(title: "More Lessons", message: "Chose A Lesson Bellow!", preferredStyle: .alert)
        
        //let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        let imgTitle = UIImage(named:"gQuiz.svg")
        let imgViewTitle = UIImageView(frame: CGRect(x: 10, y: 87, width: 30, height: 30))
        imgViewTitle.image = imgTitle

        alert.view.addSubview(imgViewTitle)
        //alert.addAction(action)
        
        alert.addAction(UIAlertAction(title: "ABC Objects", style: .destructive, handler: { (action) in
            print("ABC Objects")
        
        }))
        let imageView = UIImageView(frame: CGRect(x: 220, y: 92, width: 30, height: 30))
        imageView.image = UIImage(named: "aQuiz.svg")
        alert.view.addSubview(imageView)
    
        alert.addAction(UIAlertAction(title: "Colors", style: .default, handler: { (action) in
            print("Colors")
        }))
        let imageView2 = UIImageView(frame: CGRect(x: 220, y: 136, width: 30, height: 30))
        imageView2.image = UIImage(named: "bQuiz.svg")
        alert.view.addSubview(imageView2)
        
        alert.addAction(UIAlertAction(title: "Shapes", style: .default, handler: { (action) in
            print("Shapes")
        }))
        let imageView3 = UIImageView(frame: CGRect(x: 220, y: 180, width: 30, height: 30))
        imageView3.image = UIImage(named: "cQuiz.svg")
        alert.view.addSubview(imageView3)
        
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
