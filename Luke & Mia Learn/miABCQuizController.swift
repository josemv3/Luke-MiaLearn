//
//  miABCQuizController.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/11/22.

import UIKit
import AVFoundation
import AVKit

private let videoNames: [String] =
["apple", "bat", "cat", "dog", "egg", "frog", "giraffe", "hedgehog"]
private let quizLowercaseLettersSet1 =
["a", "b", "c", "d", "e", "f"]
private let quizLowercaseLettersSet2 =
["g", "h", "a", "b", "c", "d"]
private let quizLetterImages =
["a": "aQuiz", "b": "bQuiz", "c": "cQuiz", "d": "dQuiz", "e": "eQuiz", "f": "fQuiz", "g": "gQuiz", "h": "hQuiz"]
let quizAlphabetLetters = ["a", "b", "c", "d", "e", "f", "g", "h"]
//["a", "b", "c", "d", "e", "f", "h", "i", "j", "k", "l" ,"m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

//private let quizLetterVideos = ["a": "avQuiz", "b": "bvQuiz", "c": "cvQuiz", "d": "dvQuiz", "e": "evQuiz", "f": "fvQuiz"]
private var videoCount = 0
private let largeBorderSize: CGFloat = 10


class miABCQuizController: UIViewController, UICollectionViewDelegate {

    var quizBrain = QuizBrain()
    @IBOutlet weak var miaABCQuizCollectionView: UICollectionView!
    @IBOutlet var mainView: UIImageView!
    @IBOutlet var mainViewButton: UIButton!
    var audioPlayer: AVAudioPlayer!
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    private var correctAnswer: String = "a"
   
    var currentLetterSet = ["a", "b", "c", "d", "e", "f"]
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!//SOURCE1
    //var dataSource: UICollectionViewDiffableDataSource<Int, String>!//SOURCE1
    
    //TO CHANGE ITEMS 1
    var filteredItemsSnapshot: NSDiffableDataSourceSnapshot<Section, String> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        
        snapshot.appendSections([.main])
            snapshot.appendItems(currentLetterSet)
        
        return snapshot
    }
    
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        miaABCQuizCollectionView.collectionViewLayout = configureLayout()
        navigationItem.title = "miABC Quiz"
        
        mainView.layer.borderColor = UIColor(named: "quizBrownLight")?.cgColor
        mainView.layer.borderWidth = largeBorderSize
        configureDataSource()
    }
    
    //MARK: - ViewDidApear Video Player
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(
            forResource: videoNames[videoCount], ofType: "mp4") ?? "apple.mp4"))
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = mainView.bounds
        mainView.layer.addSublayer(playerLayer)
        player.play()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        player = nil
        playerLayer.removeFromSuperlayer()
    }
    
    //MARK: - MainButton and Image
    @IBAction func mainViewButtonTap(_ sender: UIButton) {
        videoCount += 1
        if videoCount >= videoNames.count {
            videoCount = 0
        }
        if correctAnswer == "f" {
            currentLetterSet.removeAll()
            currentLetterSet = getLetterSet(answer: correctAnswer)
            //TO CHANGE ITEMS 2 - will move to correct answer trigger
            dataSource.apply(filteredItemsSnapshot)
            
        }
        viewDidDisappear(true)
        viewDidAppear(true)
        correctAnswer = String(videoNames[videoCount].first ?? "a")
    }
    
    //MARK: - Compositional CV LAYOUT
    func configureLayout() -> UICollectionViewCompositionalLayout {
        let spacing: CGFloat = 5
        let grouItemCount = 2
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.50))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize, subitem: item, count: grouItemCount)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: spacing, leading: 70, bottom: spacing, trailing: 70)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    //MARK: - Data Source (Cell)
    func configureDataSource() {//SOURCE2
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: miaABCQuizCollectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: miABCQuizCell.reusidentifier, for: indexPath) as? miABCQuizCell else {
                fatalError("Cannot create new cell")
            }
            cell.miABCQuizCellImage.layer.borderWidth = 6
            cell.miABCQuizCellImage.layer.borderColor = UIColor(red: 0.918, green: 0.890, blue: 0.784, alpha: 1.0).cgColor
            cell.miABCQuizCellLabel.text = item.description
            cell.miABCQuizCellImage.image = UIImage(named: quizLetterImages[item.description] ?? "aQuiz")
            
            return cell
        }
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, String>()//SOURCE3
        //var initialSnapshot = NSDiffableDataSourceSnapshot<Int, String>()//SOURCE3
        
        //trying to change letters with relaodData in mainButtonTap. Not working
//        if self.correctAnswer == "a" {
//            initialSnapshot.appendSections([.main])
            //lazy var quizLetterRandom: [String] = quizLowercaseLettersSet1.shuffled()
            //use quizLetterRandom to randomize how potential letter answers are displayed
//            initialSnapshot.appendItems(quizLowercaseLettersSet1) //replace with quizLEtterRandom here
//        } else if self.correctAnswer == "f" {
//            initialSnapshot.appendSections([.main])
//            initialSnapshot.appendItems(quizLowercaseLettersSet2)
//        }
        
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(currentLetterSet)
        
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    //MARK: - DidSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        print(item.description)
        print("Correct answer", correctAnswer)
        print("VideoCount", videoCount)
        //let charCorrectAnswer = Character(item)
        
        print("letterSet", currentLetterSet)
        if item == correctAnswer {
            print("Correct!")
            
        } else {
            print("Incorrect, Try again!")
        }
    }
    
    func getLetterSet(answer: String) -> [String]{
        var selectedLetters: [String] = []
        selectedLetters.append(answer)
        var count = 1
        for letter in quizAlphabetLetters.shuffled() {
            if letter == answer {
                continue
            }
            if count >= 6 {
                break
            }
            selectedLetters.append(letter)
            count += 1
        }
        return selectedLetters
    }
}
