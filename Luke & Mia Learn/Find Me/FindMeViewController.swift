//
//  FindMeViewController.swift
//  Luke & Mia Learn
//
//  Created by Joey Rubin on 12/7/22.
//

import UIKit

private var setA = [
    "airplane", "ball", "car",
    "drum", "earphones", "flower",
    "ghost", "home", "icecream",
    "juice", "ketchup", "lightning",
    "moon", "nuts","oven",]

class FindMeViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var findMeCollectionView: UICollectionView!
    
    private var currentSet = setA
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!//SOURCE1
    var itemToFind: String = ""
    let soundplayer = SoundPlayer.shared
    //let timer = Timer()
    
    enum Section {
        case main
    }
    
    var filteredItemsSnapshot: NSDiffableDataSourceSnapshot<Section, String> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(currentSet) // new data
        return snapshot
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Find me"
        findMeCollectionView.collectionViewLayout = configureLayout()
        configureDataSource()
        itemToFind = currentSet.randomElement() ?? "empty"
        print(itemToFind)
        
//        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
//            // Call the animateRandomCell function
//            //print("timer on")
//            self.animateRandomCell()
//        }
    }

    //MARK: - Compositional CV LAYOUT
    
    func configureLayout() -> UICollectionViewCompositionalLayout {
        let spacing: CGFloat = 5
        let grouItemCount = 3
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.3))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.3))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize, subitem: item, count: grouItemCount)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    //MARK: - Data Source (Cell)
    
    func configureDataSource() {//SOURCE2
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: findMeCollectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FindMeCell.reuseidentifier, for: indexPath) as? FindMeCell else {
                fatalError("Cannot create new cell")
            }
            cell.findmeCellImageView.image = UIImage(named: item.description)
            cell.backgroundColor = .systemGray
            return cell
        }
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, String>()//SOURCE3
        
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(currentSet)
        
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    //MARK: - Did Select Item At
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        
        print("didSelect item", indexPath.description)
        if item == itemToFind {
            let alert = UIAlertController(title: "You found me!", message: "\n\n\n\n\n\n", preferredStyle: .alert)

            let image = UIImageView(image: UIImage(named: "orange octopus"))
            alert.view.addSubview(image)
            image.translatesAutoresizingMaskIntoConstraints = false
            alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .centerX, relatedBy: .equal, toItem: alert.view, attribute: .centerX, multiplier: 1, constant: 0))
            alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .centerY, relatedBy: .equal, toItem: alert.view, attribute: .centerY, multiplier: 1, constant: 0))
            alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 160.0))
            alert.view.addConstraint(NSLayoutConstraint(item: image, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 130.0))
           
            alert.addAction(UIAlertAction(title: "Restart game!", style: .default, handler: { (action) in
                self.restartGame()
            }))
            self.present(alert, animated: true, completion: nil)
            
            soundplayer.playSound(soundName: "orange octopus")
            //I was hiding behind the ...
            
        } else {
            
            self.soundplayer.playSound(soundName: item.description)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {
                self.currentSet.remove(at: indexPath.item)
                self.dataSource.apply(self.filteredItemsSnapshot)
                //play pop sound
            }
        }
    }
    
//    func animateRandomCell() {
//        // Generate a random number between 0 and 19
//        let randomNumber = arc4random_uniform(15)
//
//        // Get the index path for the cell with the matching number
//        let indexPath = IndexPath(item: Int(randomNumber), section: 0)
//        print("IndexPath", indexPath)
//
//        // Get a reference to the cell you want to animate
//        let cell = findMeCollectionView.cellForItem(at: indexPath)
//
//        // Use UIView.animate to create the animation
//        UIView.animate(withDuration: 0.15, animations: {
//            // Move the cell slightly to the left and right
//            cell?.frame.origin.x += 5
//            cell?.frame.origin.x -= 10
//            cell?.frame.origin.x += 5
//        })
//        //print("shake")
//    }

    func restartGame() {
        currentSet = setA
        itemToFind = currentSet.randomElement() ?? "empty"
        self.dataSource.apply(self.filteredItemsSnapshot)
        //print(itemToFind)
    }
}
