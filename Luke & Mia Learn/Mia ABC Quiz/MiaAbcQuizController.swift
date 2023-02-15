//
//  miABCQuizController.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/11/22.

import UIKit
import AVFoundation
import AVKit

private let videoNames: [String] =
["apple", "bat", "cat", "dog", "egg", "frog", "giraffe", "hedgehog", "icecream", "jump", "kite", "love", "moon", "numbers", "owl", "pancake", "question", "rocket", "snake", "tree", "umbrella", "volcano", "wolf", "xray", "yoga", "zoo",]
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
private var videoCount = 0
private let largeBorderSize: CGFloat = 10


class MiaAbcQuizController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var miaABCQuizCollectionView: UICollectionView!
    @IBOutlet var mainView: UIImageView!
    @IBOutlet var mainViewButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let soundplayer = SoundPlayer.shared
    let videoPlayer = VideoPlayer.shared
    var quizBrain = QuizBrain()
    private var correctAnswer: String = "a"
    var currentLetterSet = quizLowercaseLettersSet1
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
        title = "Mia ABC Quiz"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.soundplayer.playSound(soundName: videoNames[self.videoCount] + "Q")
            self.videoPlayer.playVideo(videoName: videoNames[self.videoCount], viewPlayer: self.mainView)
        }
        
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(named: "quizBrownLight")
        mainView.layer.borderColor = UIColor(named: "quizBrownLight")?.cgColor
        mainView.layer.borderWidth = largeBorderSize
        configureDataSource()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        restartGame()
    }
    
    //MARK: - MainButton and Image
    
    @IBAction func mainViewButtonTap(_ sender: UIButton) {
        soundplayer.playSound(soundName: videoNames[videoCount] + "Q")
        videoPlayer.playVideo(videoName: videoNames[videoCount], viewPlayer: mainView)
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
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MiaAbcQuizCell.reusidentifier, for: indexPath) as? MiaAbcQuizCell else {
                fatalError("Cannot create new cell")
            }
            cell.miABCQuizCellImage.layer.borderWidth = 6
            cell.miABCQuizCellImage.layer.borderColor = UIColor(red: 0.918, green: 0.890, blue: 0.784, alpha: 1.0).cgColor
            cell.miABCQuizCellLabel.text = item.description
            cell.miABCQuizCellImage.image = UIImage(named: quizLetterImages[item.description] ?? "aQuiz")
            
            return cell
        }
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, String>()//SOURCE3
        
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(currentLetterSet)
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    //MARK: - DidSelectItemAt
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        print(item.description)
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? MiaAbcQuizCell else {
               return
           }
        

        correctAnswer = String(videoNames[videoCount].first ?? "a")
        
        switch correctAnswer {
        case "f"..."j":
            quizAlphabetLetters = quizLowercaseLettersSet2
        case "k"..."o":
            quizAlphabetLetters = quizLowercaseLettersSet3
        case "p"..."t":
            quizAlphabetLetters = quizLowercaseLettersSet4
        case "u"..."z":
            quizAlphabetLetters = quizLowercaseLettersSet5
        default: 
            quizAlphabetLetters = quizLowercaseLettersSet1
        }
        
        
        if checkAnswer(itemPressed: item) == true {
            cell.miABCQuizCellImage.backgroundColor = .systemGreen
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
                cell.miABCQuizCellImage.backgroundColor = .clear
            }
            
            userGotItRight()
            
            //getLetterSet is main function that switches array letters,
            //Then filteredItemsSnapshot is the new data that is different fro OG, animating changes.
            currentLetterSet.removeAll()
            currentLetterSet = getLetterSet(answer: correctAnswer)
            dataSource.apply(filteredItemsSnapshot)
            
            let systemSoundID: SystemSoundID = 1002
            AudioServicesPlaySystemSound (systemSoundID)
        } else {
            cell.miABCQuizCellImage.backgroundColor = .red
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
                cell.miABCQuizCellImage.backgroundColor = .clear
            }
            
            let systemSoundID: SystemSoundID = 1006
            AudioServicesPlaySystemSound (systemSoundID)
        }
    }
    
    func checkAnswer(itemPressed: String) -> Bool {
        if itemPressed == correctAnswer {
            return true
        }
        updateScore(answer: false)
        return false
    }
    
    func userGotItRight() {
        if correctAnswer == "z" {
            gameOver()
        } else {
            updateScore(answer: true)
            videoCount += 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {
                self.videoPlayer.playVideo(videoName: videoNames[self.videoCount], viewPlayer: self.mainView)
                self.soundplayer.playSound(soundName: videoNames[self.videoCount] + "Q")
            }
            
            if videoCount == videoNames.count {
                videoCount = 0
            }
        }
    }
    
    func updateScore(answer: Bool) {
        if answer {
            score += 5
            scoreLabel.text = String(score)
        } else {
            incorrectChoices += 1
            score -= 1
            scoreLabel.text = String(score)
        }
    }
    
    //This feeds the switch in didSelectItemAt
    //quizAlphabetLetters holds the current set in the switch
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
    
    //MARK: - GameOver
    
    func gameOver() {
        let alert = UIAlertController(title: "Game Over", message: "Correct: \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Record Score", style: .default, handler: { (action) in
            print("Record Score")
            //nested alert2
            //save high score and initials to core data
            let alert2 = UIAlertController(title: "Save Score", message: "Correct: \(self.score)", preferredStyle: .alert)
            alert2.addTextField { (textField) in
                textField.placeholder = "Enter name"
            }
            alert2.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
                let textField = alert2.textFields?[0]
                print("Text field: \(textField?.text ?? "Blank" )" )
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
        self.scoreLabel.text = String(score) //need one source of truth
        quizAlphabetLetters = quizLowercaseLettersSet1
        self.currentLetterSet.removeAll()
        self.currentLetterSet = self.getLetterSet(answer: self.correctAnswer)
        self.dataSource.apply(self.filteredItemsSnapshot)
        videoPlayer.playVideo(videoName: videoNames[videoCount], viewPlayer: mainView)
        self.soundplayer.playSound(soundName: videoNames[videoCount] + "Q")
        
    }
}
