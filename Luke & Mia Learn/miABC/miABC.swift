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

//Main ABC lesson
private var mainImages: [String: String] = [
    "a": "alligator", "b": "bat", "c": "cat",
    "d": "dinosaur", "e": "elephant", "f": "frog",
    "g": "giraffe", "h": "horse", "i": "iguana",
    "j": "jellyfish", "k": "kangaroo", "l": "lion",
    "m": "monkey", "n": "narwal", "o": "octopus",
    "p": "penguin", "q": "queen angelfish", "r": "raccoon",
    "s": "snake", "t": "turtle", "u": "umbrella bird",
    "v": "volture", "w": "walrus", "x": "xray tetra",
    "y": "yak", "z": "zebra"]

//ABC objects lesson (alt 1)
private var objectsImages: [String: String] = [
    "a2": "airplane", "b2": "ball", "c2": "car",
    "d2": "drum", "e2": "earth", "f2": "flower",
    "g2": "ghost", "h2": "home", "i2": "icecream",
    "j2": "juice", "k2": "ketchup", "l2": "lightning",
    "m2": "moon", "n2": "nuts", "o2": "oven",
    "p2": "piano", "q2": "question", "r2": "rainbow",
    "s2": "smile", "t2": "trees", "u2": "unicorn",
    "v2": "violin", "w2": "wizard", "x2": "xylophone",
    "y2": "yeti", "z2": "zombie"]

//Colors alt lesson (alt 2)
private let colorMainImages: [String: String] =
["black": "black butterfly", "blue": "blue bunny", "brown": "brown bear",
 "cyan": "cyan circle", "green": "green gecko", "grey": "ghost",
 "magenta": "magenta makeup", "maroon": "maroon milk", "orange": "orange octopus",
 "pink": "pink piggy", "purple": "purple pizza", "red": "red robot",
 "teal": "teal tank", "yellow": "yellow yak", "white": "white web",
 "violet": "black butterfly"]

//Shapes alt lesson (alt 3)
private let shapeMainImages: [String: String] =
["circle": "wheel", "square": "box", "triangle": "pyramid",
 "rectangle": "mattress", "star": "tree star", "diamond": "sign",
 "oval": "mirror", "heart": "valentines candy", "hexagon": "bolts",
 "pentagon": "bird house", "cross": "ambulance", "octogon": "stop sign",
 "crescent": "crescent moon"]

//Main ABC
private var lowercaseLetters =
["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l" ,"m",
 "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

//First alt ABC Objects
private var lowercaseLettersAlt =
["a2", "b2", "c2", "d2", "e2", "f2", "g2", "h2", "i2", "j2", "k2", "l2" ,"m2",
 "n2", "o2", "p2", "q2", "r2", "s2", "t2", "u2", "v2", "w2", "x2", "y2", "z2"]

//Second alt lesson colors
private let colors =
["black", "blue", "brown", "cyan", "green",
 "magenta", "maroon", "orange", "pink", "purple",
 "red", "teal", "yellow", "grey", "white", "violet"]

//Third alt lesson (
private let shapes: [String] =
["circle", "square", "triangle", "rectangle", "oval",
 "diamond", "star", "heart", "hexagon", "pentagon",
 "cross", "octogon", "crescent"]

//MARK: - Class

class miABC: UIViewController, UICollectionViewDelegate {
    @IBOutlet var mainImageBack: UIImageView!
    @IBOutlet var mainImagebutton: UIButton!
    @IBOutlet var mainWordButton: UIButton!
    ///When adding CV to VC control drag CV to VC and make delegate, then add UICVDelegate to class
    @IBOutlet var collectionView: UICollectionView!
    
    var currentAnimation = 0
    var audioPlayer: AVAudioPlayer?
    var currentABCSet = lowercaseLetters
    var currentMainImage = mainImages
    var currentItemBackgroundColor: UIColor =  UIColor(named: "mainOrange" ) ?? .black
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
        
        navigationItem.title = "miABC"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(choseLesson))
        
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
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: miABCCell.reusidentifier, for: indexPath) as? miABCCell else {
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
        initialSnapshot.appendItems(currentABCSet)
        
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    //MARK: - Selected Item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        print(item)
        
        //mainLabel.text = mainImages[item]
        mainWordButtonTitle = mainImages[item] ?? "greeting"
        mainWordButton.setTitle(currentMainImage[item.description], for: .normal)
        mainImagebutton.setImage(UIImage(named: currentMainImage[item] ?? "greeting"), for: .normal)
       
        self.mainImagebutton.transform = .identity //read bellow (reset animation):
        currentAnimation = 0 //this resets animation on mainImage if another letter is pressed.
        playSound(soundName: item)
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
        
        ///left image
        let imgTitle = UIImage(named:"blue.png")
        let imgViewTitle = UIImageView(frame: CGRect(x: 10, y: 82, width: 40, height: 40))
        imgViewTitle.image = imgTitle
        alert.view.addSubview(imgViewTitle)
        
        
        ///First Alt lesson:
        alert.addAction(UIAlertAction(title: "Colors", style: .default, handler: { (action) in
            
            print("Colors")
            
            //if let weakSelf = self { grab all the stuff below, self = weakSelf}
            
            //put changes in function and get colors right. Button orange
            self.currentABCSet = colors
            self.currentMainImage = colorMainImages
            self.mainImagebutton.setImage(UIImage(named: self.currentMainImage["red"] ?? "greeting"), for: .normal)
            
            //self.view.backgroundColor = UIColor(named: "mainBlue")
            //self.collectionView.backgroundColor = UIColor(named: "mainOrange")
            //self.cellItemBorderColor = "quizDarkBrown"
            //self.currentItemBackgroundColor = UIColor(named: "mainCream") ?? .black
            //self.mainWordButton.backgroundColor = UIColor.systemGroupedBackground
            //self.mainWordButton.layer.borderWidth = 6
            //self.mainWordButton.layer.borderColor = UIColor(named: "mainOrange")?.cgColor
            //self.mainWordButton.setTitleColor(UIColor(named: "quizDarkBrown"), for: .normal)
            self.mainWordButton.titleLabel?.font = UIFont(name: "ChalkboardSE-Bold", size: 20)
            //self.mainImageBack.backgroundColor = .systemGroupedBackground
            //self.mainImageBack.layer.borderColor = UIColor(named: "mainOrange")?.cgColor
            //self.mainImageBack.layer.borderWidth = 6
            self.configureDataSource()
        }))
        
        //Create func for creating imageViews - replace all this duplicated code.
        ///right image
        let imageView = UIImageView(frame: CGRect(x: 220, y: 82, width: 40, height: 40))
        imageView.image = UIImage(named: "red.png")
        alert.view.addSubview(imageView)
        
        
        ///Second Alt lesson:
        alert.addAction(UIAlertAction(title: "ABC Objects", style: .default, handler: { (action) in
            print("ABC Objects")
            
            self.currentABCSet = lowercaseLettersAlt
            self.currentMainImage = objectsImages
            self.mainImagebutton.setImage(UIImage(named: self.currentMainImage["airplane"] ?? "greeting"), for: .normal)
            self.configureDataSource()
        }))
        let imageView2 = UIImageView(frame: CGRect(x: 220, y: 127, width: 40, height: 40))
        imageView2.image = UIImage(named: "airplane.svg")
        alert.view.addSubview(imageView2)
        
        ///left image
        let imgTitle2 = UIImage(named:"drum.svg")
        let imgViewTitle2 = UIImageView(frame: CGRect(x: 10, y: 127, width: 40, height: 40))
        imgViewTitle2.image = imgTitle2
        alert.view.addSubview(imgViewTitle2)
        
        
        
        ///Third Alt lesson:
        alert.addAction(UIAlertAction(title: "Shapes", style: .default, handler: { (action) in
            print("Shapes")
            
            self.currentABCSet = shapes
            self.currentMainImage = shapeMainImages
            self.mainImagebutton.setImage(UIImage(named: self.currentMainImage["wheel"] ?? "greeting"), for: .normal)
            self.configureDataSource()
            
        }))
        let imageView3 = UIImageView(frame: CGRect(x: 220, y: 172, width: 40, height: 40))
        imageView3.image = UIImage(named: "heart.png")
        alert.view.addSubview(imageView3)
        
        ///LeftImage
        let imgTitle3 = UIImage(named:"cross.png")
        let imgViewTitle3 = UIImageView(frame: CGRect(x: 10, y: 172, width: 40, height: 40))
        imgViewTitle3.image = imgTitle3
        alert.view.addSubview(imgViewTitle3)
        
        ///Fourth Alt lesson:
        alert.addAction(UIAlertAction(title: "Toys", style: .default, handler: { (action) in
            print("Toys")
        }))
        let imageView4 = UIImageView(frame: CGRect(x: 220, y: 217, width: 40, height: 40))
        imageView4.image = UIImage(named: "toys.png")
        alert.view.addSubview(imageView4)
        
        ///Fifth Alt lesson:
        alert.addAction(UIAlertAction(title: "Instruments to Play", style: .default, handler: { (action) in
            print("Instruments to Play")
        }))
        let imageView5 = UIImageView(frame: CGRect(x: 220, y: 262, width: 40, height: 40))
        imageView5.image = UIImage(named: "instruments.png")
        alert.view.addSubview(imageView5)
        
        self.present(alert, animated: true)
    }
}
