//
//  miABCQuizController.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/11/22.

import UIKit
import AVFoundation
import AVKit

class MiaAbcQuizView: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var miaABCQuizCollectionView: UICollectionView!
    @IBOutlet var mainView: UIImageView!
    @IBOutlet var mainViewButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let soundPLayer = SystemSoundPlayer.shared
    let audioPlayer = AudioPlayer.shared
    let videoPlayer = VideoPlayer.shared
    var miaAbcQuizData = MiaAbcQuizData()

    var dataSource: UICollectionViewDiffableDataSource<Section, String>!//SOURCE1
    
    //TO CHANGE ITEMS 1
    var currentSnapshot: NSDiffableDataSourceSnapshot<Section, String> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(miaAbcQuizData.currentLetterSet)
        return snapshot
    }
    
    enum Section {
        case main
    }
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        miaABCQuizCollectionView.collectionViewLayout = configureLayout()
        title = Title.MiaAbcQuiz.rawValue
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            self.audioPlayer.playSound(soundName: self.miaAbcQuizData.videoNamesArray[self.miaAbcQuizData.videoCount] + "Q")
            self.videoPlayer.playVideo(videoName: self.miaAbcQuizData.videoNamesArray[self.miaAbcQuizData.videoCount], viewPlayer: self.mainView)
        }
        
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(named: Colors.quizBrownLight.rawValue)
        mainView.layer.borderColor = UIColor(named: Colors.quizBrownLight.rawValue)?.cgColor
        mainView.layer.borderWidth = BorderSize.xLarge.size
        configureDataSource()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        resetGame()
        audioPlayer.audioPlayer?.pause()
    }
    
    //MARK: - MainButton and Image
    
    @IBAction func mainViewButtonTap(_ sender: UIButton) {
        self.audioPlayer.playSound(soundName: self.miaAbcQuizData.videoNamesArray[self.miaAbcQuizData.videoCount] + "Q")
        self.videoPlayer.playVideo(videoName: self.miaAbcQuizData.videoNamesArray[self.miaAbcQuizData.videoCount], viewPlayer: self.mainView)
        soundPLayer.clickSound()
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
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MiaAbcQuizCell.reusidentifier,
                for: indexPath) as? MiaAbcQuizCell else {
                fatalError("Cannot create new cell")
            }
            cell.miABCQuizCellImage.layer.borderWidth = BorderSize.large.size
            cell.miABCQuizCellImage.layer.borderColor = UIColor(
                named: Colors.quizBrownLight.rawValue
            )?.cgColor
            cell.miABCQuizCellLabel.text = item.description
            cell.miABCQuizCellImage.image = UIImage(
                named: item.description + MiaAbcQuizData.LetterImageName.Quiz.rawValue
            )
            return cell
        }
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, String>()//SOURCE3
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(miaAbcQuizData.currentLetterSet)
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    //MARK: - DidSelectItemAt
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        guard let cell = collectionView.cellForItem(at: indexPath) as? MiaAbcQuizCell else {
               return
           }

        if checkAnswer(itemPressed: item) == true {
            cell.miABCQuizCellImage.backgroundColor = .systemGreen
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
                cell.miABCQuizCellImage.backgroundColor = .clear
            }
            userGotItRight()

            dataSource.apply(currentSnapshot)
            let systemSoundID: SystemSoundID = 1002
            AudioServicesPlaySystemSound (systemSoundID)
            
        } else {
            //If wrong set letter background to red and play inorrect sound
            cell.miABCQuizCellImage.backgroundColor = .red
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
                cell.miABCQuizCellImage.backgroundColor = .clear
            }
            let systemSoundID: SystemSoundID = 1006
            AudioServicesPlaySystemSound (systemSoundID)
        }
    }
    
    func checkAnswer(itemPressed: String) -> Bool {
        if itemPressed == miaAbcQuizData.correctAnswer {
            return true
        }
        updateScore(answer: false)
        return false
    }
    
    //if correct, updates score, advnaces vid count and plays vid and sound
    func userGotItRight() {
        if miaAbcQuizData.correctAnswer == "z" {
            gameOver()
        } else { //fixed the out of index issue after zoo
            updateScore(answer: true)
            miaAbcQuizData.updateCurrentLetterSet()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {
                //who ownes this closure, and when will it be deallocated.
                //since its gone after view is gone, no retain cycle. becasue self doesnt own the closure.
                //main view does
                //But can user leave before update happens, thats an issue
                //Would be good to make this weak, becasue we dont care if the view is around when we are gone.
                //Closuer should not keep this work alive if we arent here. Weak makes sure it goes away according to its lifecycle.
                //When this thing happens in the future, do I need self to be around. If no = weak.
                //Unowned can be used, then if you crash we know you needed weak.
                let videoName = self.miaAbcQuizData.videoNamesArray[self.miaAbcQuizData.videoCount]
                self.audioPlayer.playSound(soundName: videoName + "Q")
                self.videoPlayer.playVideo(videoName: videoName, viewPlayer: self.mainView)
            }
        }
    }
    
    func updateScore(answer: Bool) {
        if answer {
            miaAbcQuizData.score += 5
            scoreLabel.text = String(miaAbcQuizData.score)//duplicated code, can move out at if
        } else {
            miaAbcQuizData.incorrectChoices += 1
            miaAbcQuizData.score -= 1
            scoreLabel.text = String(miaAbcQuizData.score)
        }
    }
    
    //MARK: - GameOver
    
    func gameOver() {
        let alert = UIAlertController(title: "Game Over", message: "Correct: \(miaAbcQuizData.score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Record Score", style: .default, handler: { (action) in
            print("Record Score")
            //nested alert2
            //save high score and initials to core data
            let alert2 = UIAlertController(title: "Save Score", message: "Correct: \(self.miaAbcQuizData.score)", preferredStyle: .alert)
            alert2.addTextField { (textField) in
                textField.placeholder = "Enter name"
            }
            alert2.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
                let textField = alert2.textFields?[0]
                print("Text field: \(textField?.text ?? "Blank" )" )
                self.resetGame()
            }))
            self.present(alert2, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Restart Game", style: .default, handler: { (action) in
            print("Restart Game")
            self.resetGame()
        }))
        
        self.present(alert, animated: true)
    }
    
    func resetGame() {
        miaAbcQuizData.restartGame()
        self.scoreLabel.text = "0"
        self.dataSource.apply(self.currentSnapshot)
        self.audioPlayer.playSound(
            soundName: self.miaAbcQuizData.videoNamesArray[
                self.miaAbcQuizData.videoCount] + "Q")
        self.videoPlayer.playVideo(
            videoName: self.miaAbcQuizData.videoNamesArray[
                self.miaAbcQuizData.videoCount], viewPlayer: self.mainView)
    }
}
