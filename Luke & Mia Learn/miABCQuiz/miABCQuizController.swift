//
//  miABCQuizController.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/11/22.

import UIKit
import AVFoundation
import AVKit

private let videoNames: [String] =
["apple", "bat", "cat", "dog", "egg", "frog", "giraffe", "hedgehog", "iceCream", "jump", "kite", "love", "moon", "numbers", "owl", "phone", "question", "rocket", "snake", "tree", "umbrella", "volcano", "wolf", "xray", "yoga", "zoo", "zoo"]
//consolidate into 1 array or find another way of getting data.
private let quizLowercaseLettersSet1 =
["a", "b", "c", "d", "e", "f"]
private let quizLowercaseLettersSet2 =
["f", "g", "h", "i", "j", "k",]
private let quizLowercaseLettersSet3 =
["k", "l", "m", "n", "o", "p",]
private let quizLowercaseLettersSet4 =
["p", "q", "r", "s", "t", "u",]
private let quizLowercaseLettersSet5 =
["u", "v", "w", "x", "y", "z",]
private let quizLetterImages =
["a": "aQuiz", "b": "bQuiz", "c": "cQuiz", "d": "dQuiz", "e": "eQuiz", "f": "fQuiz", "g": "gQuiz", "h": "hQuiz", "i": "iQuiz", "j": "jQuiz", "k": "kQuiz", "l": "lQuiz", "m": "mQuiz", "n": "nQuiz", "o": "oQuiz", "p": "pQuiz", "q": "qQuiz", "r": "rQuiz", "s": "sQuiz", "t": "tQuiz", "u": "uQuiz", "v": "vQuiz", "w": "wQuiz", "x": "xQuiz", "y": "yQuiz", "z": "zQuiz"]
var quizAlphabetLetters = quizLowercaseLettersSet1
//["a", "b", "c", "d", "e", "f", "h", "i", "j", "k", "l" ,"m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
//private let quizLetterVideos = ["a": "avQuiz", "b": "bvQuiz", "c": "cvQuiz", "d": "dvQuiz", "e": "evQuiz", "f": "fvQuiz"]
private var videoCount = 0
private let largeBorderSize: CGFloat = 10

class miABCQuizController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var miaABCQuizCollectionView: UICollectionView!
    @IBOutlet var mainView: UIImageView!
    @IBOutlet var mainViewButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var quizBrain = QuizBrain()
    var audioPlayer: AVAudioPlayer!
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    private var correctAnswer: String = "a"
    var currentLetterSet = ["a", "b", "c", "d", "e", "f"]
    var score = 0
    var incorrectChoices = 0
    var userAnswer = false
    private var videoCount = 0
    private let largeBorderSize: CGFloat = 10
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!//SOURCE1
    
    //TO CHANGE ITEMS 1
    var filteredItemsSnapshot: NSDiffableDataSourceSnapshot<Section, String> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(currentLetterSet) // starting data
        
        return snapshot
    }
    
    enum Section {
        case main
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        miaABCQuizCollectionView.collectionViewLayout = configureLayout()
        title = "miABC Quiz"
        
        navigationController?.navigationBar.backgroundColor = UIColor.green
        mainView.layer.borderColor = UIColor(named: "quizBrownLight")?.cgColor
        mainView.layer.borderWidth = largeBorderSize
        configureDataSource()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        restartGame()
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
        viewDidDisappear(true)
        viewDidAppear(true)
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
        
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(currentLetterSet)
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    //MARK: - DidSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        print(item.description)
        //let charCorrectAnswer = Character(item)
        //print("letterSet", currentLetterSet)
        
        getCorrectAnswer()
        
        switch correctAnswer {
        case "f":
            quizAlphabetLetters = quizLowercaseLettersSet2
        case "k":
            quizAlphabetLetters = quizLowercaseLettersSet3
        case "p":
            quizAlphabetLetters = quizLowercaseLettersSet4
        case "u":
            quizAlphabetLetters = quizLowercaseLettersSet5
        default: 
            quizAlphabetLetters = quizLowercaseLettersSet1
        }
        
        
        userAnswer = checkAnswer(itemPressed: item)
        //checkAnswer checks item vs correctAnswer giving userAnswer T or F
        
        if userAnswer == true {
            print("Change Image")
            userGotItRight()
            
            //TO CHAMGE ITEMS 2 with Diffable data and see changes animated
            currentLetterSet.removeAll()
            currentLetterSet = getLetterSet(answer: correctAnswer)
            //getLetterSet is main function that switches array letters,
            //Then filteredItemsSnapshot is the new data that is different fro OG, animating changes.
            dataSource.apply(filteredItemsSnapshot)
            
            let systemSoundID: SystemSoundID = 1002
            AudioServicesPlaySystemSound (systemSoundID)
        } else {
            let systemSoundID: SystemSoundID = 1006
            AudioServicesPlaySystemSound (systemSoundID)
        }
    }
    
    func getCorrectAnswer() {
        correctAnswer = String(videoNames[videoCount].first ?? "a")
        //correctAnswer first letter of vid name
    }
    
    func checkAnswer(itemPressed: String) -> Bool {
        if itemPressed == correctAnswer {
            //score += 1
            scoreLabel.text = String(score)
            return true
        }
        incorrectChoices += 1
        score -= 1
        scoreLabel.text = String(score)
        print("Incorrect, Try again!")
        return false
    }
    
    func userGotItRight() {
        if correctAnswer == "z" {
            gameOver()
        }
        //I added 2 "zoo" to the array to solve the out of index problem. Need a real fix.
        score += 5
        scoreLabel.text = String(score)
        videoCount += 1
        getCorrectAnswer()
        viewDidDisappear(true)
        viewDidAppear(true)
        //change background collor
        if videoCount == videoNames.count {
            videoCount = 0
        }
    }
    
    //add correct score and incorrect score - or need to be able to move on even if answer is wrong.
    //I dont think I want that. So just record how many worng and how  any right. Record best %
    func gameOver() {
        let alert = UIAlertController(title: "Game Over", message: "Correct: \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Record Score", style: .default, handler: { (action) in
            print("Record Score")
            //nested alert2
            //save high score and initials to core data
            let alert2 = UIAlertController(title: "Save Score", message: "Correct: \(self.score)", preferredStyle: .alert)
            alert2.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
                self.restartGame()
            }))
            self.present(alert2, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Restart Game", style: .default, handler: { (action) in
            print("Restart Game")
            self.restartGame()
        }))
        self.present(alert, animated: true)
    }
    
    func restartGame() {
        videoCount = 0
        self.score = 0
        quizAlphabetLetters = quizLowercaseLettersSet1
        self.currentLetterSet.removeAll()
        self.currentLetterSet = self.getLetterSet(answer: self.correctAnswer)
        self.dataSource.apply(self.filteredItemsSnapshot)
        self.viewDidDisappear(true) //end video
        self.viewDidAppear(true) //restart video
    }
    
    //This goes in quizBrain
    func getLetterSet(answer: String) -> [String] {
        var selectedLetters: [String] = []
        selectedLetters.append(answer)
        var count = 1
        for letter in quizAlphabetLetters {
            //move .shuffled() to return array for all of them to be shuffled
            //or append it at for specific loacation each time (or leave at #1 as is)
            if letter == answer {
                continue
            }
            if count >= 6 {
                break
            }
            selectedLetters.append(letter)
            count += 1
        }
        return selectedLetters.shuffled()
    }
}
