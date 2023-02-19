//
//  MiaTalksController.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 9/12/22.
//

import UIKit
import AVFoundation

private let reuseIdentifier = "miaTalksCell"
var recieverString = "human"

private var miatalksLowercaseLetters = [
    "a", "b", "c", "d", "e", "f"]
private var miaTalksViewText: [String: String] = ["a": "apples", "b": "hamburger", "c": "carrot", "d": "broccoli", "e": "cereal", "f": "bananas"]

class MiaTalksController: UICollectionViewController {
    
    var audioPlayer: AVAudioPlayer?
    var soundTypeSelected = "human"
    var soundNameToPlay = "None"
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!//SOURCE1
    static let sectionFooterElementKind = "section-footer-element-kind" //footerSetup1
    static let sectionHeaderElementKind = "section-header-element-kind"//headerSetup1
    
    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.setCollectionViewLayout(generateLayout(), animated: false)
        collectionView.register(MiaTalksHeaderView.self, forSupplementaryViewOfKind: MiaTalksController.sectionHeaderElementKind, withReuseIdentifier: "Header")//headerSetup2
        collectionView.register(MiaTalksFooterView.self, forSupplementaryViewOfKind: MiaTalksController.sectionFooterElementKind, withReuseIdentifier: "Footer")//footerSetup2
        //navigationItem.title = "Mia Talks"
        
        //navigationController?.navigationBar.barTintColor = .gray
        //navigationController?.navigationBar.backgroundColor = .red
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(choseLesson))
        createDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recieverString = "human"
        //navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = UIColor(named: "miaTalksOrange")
    }
    
    //MARK: - Layout
    
    private func generateLayout() -> UICollectionViewLayout {
        //wlet spacing: CGFloat = 10
        let groupItemCount = 2
        
        // Item definition
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.50),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 5)
        
        // Group definition
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.24)//26
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: groupItemCount
        )
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 1,
            leading: 5,
            bottom: 0,
            trailing: 0
        )
        // Section and layout definition
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 1,
            bottom: 1,
            trailing: 1
        )
        // HeaderSetup3
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(64)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: MiaTalksController.sectionHeaderElementKind,
            alignment: .top)
        
        //FooterSetup3
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(94)
        )
        
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: MiaTalksController.sectionFooterElementKind,
            alignment: .bottom)
        
        //section.boundarySupplementaryItems = [sectionFooter] //before header
        section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        //had to mover layout after footer for footer to work. Imnitially had below.
        
        return layout
    }
    
    //MARK: - DataSource
    
    private func createDataSource() {
        ///CELL
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MiaTalksCell
            
            cell.miaTalkCellLabel.text = item
            cell.miaTalksView.image = UIImage(named: miaTalksViewText[item]!)
            //cell.miaTalksView.setImage(UIImage(named: miaTAlksButtonText[item]!), for: .normal)
            //cell.miaTalksButton.setTitle(miaTAlksButtonText[item], for: .normal)
            
            return cell
        })
        
        //FooterSetup4 & HeaderSetup4
        dataSource.supplementaryViewProvider = {collectionView, kind, indexPath -> UICollectionReusableView? in
            
            if kind == "section-footer-element-kind" {
                
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath) as! MiaTalksFooterView
                footer.backgroundColor = UIColor(named: Colors.mainOrange.rawValue)
                //self.soundTypeSelected = footer.soundType ?? "2"
                footer.delegate = self
                
                return footer
            } else if kind == "section-header-element-kind" {
                
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! MiaTalksHeaderView
                
                
                header.miaTalksHeaderLabel.backgroundColor = UIColor(named: Colors.mainOrange.rawValue)
                header.miaTalksHeaderLabel.text = "I Like..."
                header.miaTalksHeaderLabel.font = UIFont(name: "ChalkboardSE-Regular", size: 20)
                
                return header
            }
            return nil
        }
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, String>()//SOURCE3
        
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(miatalksLowercaseLetters)
        
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    //MARK: - Did Select Item At
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        
        if collectionView.indexPathsForSelectedItems != nil {
            collectionView.cellForItem(at: indexPath)?.alpha = 0.5
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                collectionView.cellForItem(at: indexPath)?.alpha = 1.0
            }
        }
        playSound(soundName: recieverString + (miaTalksViewText[item] ?? "bananas"))
    }
    
    //MARK: - Play Sound files
    
    private func playSound(soundName: String) {
        
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
    
    //MARK: - Alert Action
    
    @objc func choseLesson() {
        
        //Placeholder assets and text
        let alert = UIAlertController(title: "More Lessons", message: "Chose a lesson bellow!", preferredStyle: .alert)
        
        ///left image
        let imgTitle = UIImage(named:"blue.png")
        let imgViewTitle = UIImageView(frame: CGRect(x: 10, y: 82, width: 40, height: 40))
        imgViewTitle.image = imgTitle
        alert.view.addSubview(imgViewTitle)
        
        ///First Alt lesson:
        alert.addAction(UIAlertAction(title: "Colors", style: .default, handler: { (action) in
            
            print("Colors")
        }))
        ///right image
        let imageView = UIImageView(frame: CGRect(x: 220, y: 82, width: 40, height: 40))
        imageView.image = UIImage(named: "red.png")
        alert.view.addSubview(imageView)
        
        ///Second Alt lesson:
        alert.addAction(UIAlertAction(title: "ABC Objects", style: .default, handler: { (action) in
            print("ABC Objects")
        }))
        let imageView2 = UIImageView(frame: CGRect(x: 220, y: 127, width: 40, height: 40))
        imageView2.image = UIImage(named: "miABCLogo.svg")
        alert.view.addSubview(imageView2)
        
        ///Third Alt lesson:
        alert.addAction(UIAlertAction(title: "Shapes", style: .default, handler: { (action) in
            print("Shapes")
        }))
        let imageView3 = UIImageView(frame: CGRect(x: 220, y: 172, width: 40, height: 40))
        imageView3.image = UIImage(named: "heart.png")
        alert.view.addSubview(imageView3)
        
        self.present(alert, animated: true)
    }
}

extension MiaTalksController: MiaTalksFooterViewDelegate {
    func didSelectSoundType(_ soundType: String) {
        recieverString = soundType
        print(recieverString)
    }
}
