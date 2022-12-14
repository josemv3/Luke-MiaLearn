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

private let instrumentsMainVideo: [String: String] = ["instruments": "Quiz"]
private let instrumentsTest = ["instruments"]

//MARK: - Class

class MiaLearnsViewController: UIViewController, UICollectionViewDelegate {
    @IBOutlet var mainImageBack: UIImageView!
    @IBOutlet var mainImagebutton: UIButton!
    @IBOutlet var mainWordButton: UIButton!
    ///When adding CV to VC control drag CV to VC and make delegate, then add UICVDelegate to class
    @IBOutlet var collectionView: UICollectionView!
    
    //var miaABCBrain = MiaAbcBrain()
    var miaLearnsData = MiaLearnsData()
    var currentAnimation = 0
    var audioPlayer: AVAudioPlayer?
    var playerLayer = AVPlayerLayer()
    var currentItemBackgroundColor: UIColor =  UIColor(named: "mainOrange") ?? .black
    var cellItemBorderColor = "mainOrange"
    private var mainWordButtonTitle = ""
    private let smallBorderSize: CGFloat = 2
    private let mediumBorderSize: CGFloat = 4
    
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!//SOURCE1
    
    enum Section {
        case main
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Mia Learns"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(choseLesson))
        navigationController?.navigationBar.backgroundColor = UIColor.systemBlue
        
        mainImagebutton.setImage(UIImage(named: "greeting"), for: .normal)
        
        miaLearnsData.lesson = .animal
        miaLearnsData.getLesson()
        collectionView.collectionViewLayout = configureLayout()
        collectionView.layer.borderWidth = smallBorderSize //2
        collectionView.layer.borderColor = UIColor(named: "mainBlue")?.cgColor
        view.backgroundColor = .systemGroupedBackground
        
        mainImageBack.layer.borderWidth = mediumBorderSize //4
        mainImageBack.layer.borderColor = UIColor(named: "mainOrange")?.cgColor
        mainImageBack.backgroundColor = UIColor(named: "mainBlue")
        mainWordButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 21)//doesnt work
        mainWordButton.layer.borderWidth = mediumBorderSize
        mainWordButton.layer.borderColor = UIColor(named: "mainOrange")?.cgColor
        configureDataSource()
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
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MiaLearnsCell.reusidentifier, for: indexPath) as? MiaLearnsCell else {
                fatalError("Cannot create new cell")
            }
            cell.miABCCellLabel.text = item.description
            cell.miABCCellImage.image = UIImage(named: item.description)
            cell.miABCCellImage.backgroundColor = self.currentItemBackgroundColor
            cell.miABCCellImage.layer.borderColor = UIColor(named: self.cellItemBorderColor)?.cgColor
            cell.miABCCellImage.layer.borderWidth = 4
            
            return cell
        }
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, String>()//SOURCE3
        
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(miaLearnsData.lessonPromptSet)
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    //MARK: - Selected Item
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        
        //        if miaABCBrain.lesson == .instrument { // Replace 4
        //            playVideo(video: "instrumentsV", newView: mainImagebutton)
        //            mainWordButtonTitle = miaABCBrain.currentLesson[item]?.mainImageAndSound ?? "bat"
        //            mainWordButton.setTitle(miaABCBrain.currentLesson[item]?.mainImageAndSound, for: .normal
        //        } else {
        
        //else ends after playSound
        mainWordButtonTitle = miaLearnsData.currentLesson[item]?.item.imageName ?? "greeting"
        let wordNo_ = miaLearnsData.currentLesson[item]?.item.imageName.replacingOccurrences(of: "_", with: " ")
        mainWordButton.setTitle(wordNo_, for: .normal)
        
        mainImagebutton.setImage(UIImage(named: miaLearnsData.currentLesson[item]?.item.imageName ?? "cat"), for: .normal)
        mainImagebutton.contentMode = .scaleAspectFit// Not working on number value
        self.mainImagebutton.transform = .identity //read bellow (reset animation):
        currentAnimation = 0 //this resets animation on mainImage if another letter is pressed.
        playSound(soundName: String(miaLearnsData.currentLesson[item.description]?.promt.soundName ?? "bat"))
    }
    
    //MARK: - Sound Player
    
    func playSound(soundName: String) {
        
        let urlString = Bundle.main.path(forResource: soundName, ofType: "mp3")
        let pathToSound = Bundle.main.path(forResource: soundName, ofType: ".mp3") ?? "a.mp3"
        let url = URL(fileURLWithPath: pathToSound)
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else {
                return
            }
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.volume = 0.50
            audioPlayer?.play()
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
        
        //        if miaABCBrain.currentSet == ["instruments"] { // Replace 5
        //            //not working. Maybe remove mainImageButton set from ViewDidLoad and put it in lesson assigned
        //            //mainImagebutton.setImage(UIImage(named: "placholder"), for: .normal)
        //            mainImagebutton.imageView?.image = nil
        //
        //        } else {
        
        UIView.animate(withDuration: 0.20, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 25, options: [], animations: {
            
            switch self.currentAnimation {
            case 0:
                self.mainImagebutton.transform = CGAffineTransform(scaleX: 2, y: 2)
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
        //}
    }
    
    @IBAction func mainWordButton(_ sender: UIButton) {
        playSound(soundName: mainWordButtonTitle)
        print(mainWordButtonTitle)
    }
    
    //MARK: - Video Player
    
    func playVideo(video: String, newView: UIView) {
        playerLayer.player?.pause() //if player exists pause playback and start new play
        
        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(
            forResource: video , ofType: "mp4") ?? "bvQuiz.mp4"))
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = newView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        newView.layer.addSublayer(playerLayer)
        player.play()
    }
    
    //MARK: - Alert lesson change methods
    
    func addLeftAlertImage(yAxis: Int, imageName: String) -> UIImageView {
        let leftImage = UIImageView(frame: CGRect(x: 10, y: yAxis, width: 40, height: 40))
        leftImage.image = UIImage(named: imageName)
        return leftImage
    }
    
    func addRightAlertImage(yAxis: Int, imageName: String) -> UIImageView {
        let rightImage = UIImageView(frame: CGRect(x: 220, y: yAxis, width: 40, height: 40))
        rightImage.image = UIImage(named: imageName)
        return rightImage
    }
    
    func changeLessonVideo(abcSet: [String], videoSet: [String: String]) {
        self.mainImagebutton.imageView?.image = nil
        self.configureDataSource()
    }
    
    //MARK: - Alert Choices
    
    @objc func choseLesson() {
        let alert = UIAlertController(title: "More Lessons", message: "Chose A Lesson Bellow!", preferredStyle: .alert)
        
        ///First ABC lesson:
        alert.addAction(UIAlertAction(title: "ABC Animals", style: .default, handler: { [self] (action) in
            print("Colors")
            //if let weakSelf = self { grab all the stuff below, self = weakSelf}
            //put changes in function and get colors right. Button orange
            
            //replce 6
            self.miaLearnsData.lesson = .animal
            self.miaLearnsData.getLesson()
            self.configureDataSource()
        }))
        alert.view.addSubview(addRightAlertImage(yAxis: 82, imageName: "bat.png"))
        alert.view.addSubview(addLeftAlertImage(yAxis: 82, imageName: "alligator.png"))
        
        ///Second ABC lesson:
        alert.addAction(UIAlertAction(title: "ABC Objects", style: .default, handler: { (action) in
            print("ABC Objects")
            self.miaLearnsData.lesson = .object
            self.miaLearnsData.getLesson()
            self.configureDataSource()
        }))
        alert.view.addSubview(addRightAlertImage(yAxis: 127, imageName: "airplane.svg"))
        alert.view.addSubview(addLeftAlertImage(yAxis: 127, imageName: "drum.svg"))
        
        ///Third ABC lesson:
        alert.addAction(UIAlertAction(title: "ABC Instruments", style: .default, handler: { (action) in
            print("ABC Instruments")
            
            //self.mainImagebutton.setImage(UIImage(named: ""), for: .normal)
            
            //self.miaABCBrain.lesson = .instrument
            //self.miaABCBrain.getLesson()
            self.configureDataSource()
            
            //self.changeLessonVideo(abcSet: instrumentsTest, videoSet: instrumentsMainVideo)
        }))
        alert.view.addSubview(addRightAlertImage(yAxis: 172, imageName: "instruments.png"))
        alert.view.addSubview(addLeftAlertImage(yAxis: 172, imageName: "instruments.png"))
        
        ///Fourth ABC lesson:
        alert.addAction(UIAlertAction(title: "ABC Fruits and Veggies", style: .default, handler: { (action) in
            print("ABC Fruits and Veggies")
            self.miaLearnsData.lesson = .fruit
            self.miaLearnsData.getLesson()
            self.configureDataSource()
        }))
        alert.view.addSubview(addRightAlertImage(yAxis: 217, imageName: "avocado.png"))
        alert.view.addSubview(addLeftAlertImage(yAxis: 217, imageName: "avocado.png"))
        
        //Spacer
        alert.addAction(UIAlertAction(title: "", style: .default, handler: { (action) in
            print("")
        }))
        //alert.view.addSubview(addRightAlertImage(yAxis: 262, imageName: ""))
        //alert.view.addSubview(addLeftAlertImage(yAxis: 262, imageName: ""))
        
        //Alt lesson title
        alert.addAction(UIAlertAction(title: "Learn more stuff!", style: .default, handler: { (action) in
            print("Learn more stuff!")
        }))
        //alert.view.addSubview(addRightAlertImage(yAxis: 307, imageName: "instruments.png"))
        //alert.view.addSubview(addLeftAlertImage(yAxis: 307, imageName: "instruments.png"))
        
        ///First Alt lesson:
        alert.addAction(UIAlertAction(title: "Colors", style: .default, handler: { (action) in
            print("Colors")
            self.miaLearnsData.lesson = .color
            self.miaLearnsData.getLesson()
            self.configureDataSource()
        }))
        alert.view.addSubview(addRightAlertImage(yAxis: 350, imageName: "blue.png"))
        alert.view.addSubview(addLeftAlertImage(yAxis: 350, imageName: "red.png"))
        
        ///Second Alt lesson:
        alert.addAction(UIAlertAction(title: "Shapes", style: .default, handler: { (action) in
            print("Shapes")
            self.miaLearnsData.lesson = .shape
            self.miaLearnsData.getLesson()
            self.configureDataSource()
        }))
        alert.view.addSubview(addRightAlertImage(yAxis: 395, imageName: "heart.png"))
        alert.view.addSubview(addLeftAlertImage(yAxis: 395, imageName: "cross.png"))
        
        ///Third Alt lesson:
        alert.addAction(UIAlertAction(title: "Toys", style: .default, handler: { (action) in
            print("Toys")
            self.miaLearnsData.lesson = .toy
            self.miaLearnsData.getLesson()
            self.configureDataSource()
        }))
        alert.view.addSubview(addRightAlertImage(yAxis: 438, imageName: "toys.png"))
        alert.view.addSubview(addLeftAlertImage(yAxis: 438, imageName: "toys.png"))
        
        ///Fourth Alt lesson:
        alert.addAction(UIAlertAction(title: "Numbers", style: .default, handler: { (action) in
            print("Numbers")
            self.miaLearnsData.lesson = .number
            self.miaLearnsData.getLesson()
            self.configureDataSource()
        }))
        alert.view.addSubview(addRightAlertImage(yAxis: 481, imageName: "1.png"))
        alert.view.addSubview(addLeftAlertImage(yAxis: 481, imageName: "3.png"))
        
        ///Cancel
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) in
            print("Cancel")
        }))
        
        self.present(alert, animated: true)
    }
}
