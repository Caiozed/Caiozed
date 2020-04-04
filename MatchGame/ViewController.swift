//
//  ViewController.swift
//  MatchGame
//
//  Created by Caio on 28/03/20.
//  Copyright © 2020 Caio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cards = [Card]()
    var firstIndexPath: IndexPath?
    var timer: Timer?
    var milisseconds: Float = 10 * 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Setup()
    }
    
    func Setup(){
        firstIndexPath = nil
        milisseconds = 60 * 1000
        SoundManager.playSound(.shuffle)
        cards = model.getCards()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timeStep), userInfo: nil, repeats: true);
        RunLoop.main.add(timer!, forMode: .common)
        
        collectionView.reloadItems(at: collectionView.indexPathsForVisibleItems)
    }
    
    //MARK: TIMER FUNCTION
    @objc func timeStep(){
        milisseconds -= 1
        timerLabel.text = "Time Remaining: " + String(format: "%.2f", arguments: [milisseconds / 1000])
        if milisseconds <= 0{
            timer?.invalidate()
            checkGameEnded()
        }
    }

    //MARK: - UI COLLECTION VIEW PROTOCOLS

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        cell.setCard(cards[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        let card = cards[indexPath.row]
        if(card.isFlipped || card.isMatched){
            return;
        }else{
            cell.flip()
            SoundManager.playSound(.flip)
        }
        
        
        if firstIndexPath == nil{
            firstIndexPath = indexPath
        }else{
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                self.checkForMatches(indexPath)
            })
        }
    }

    
    func checkForMatches(_ secondIndexPath: IndexPath) {
        let firstCell = collectionView.cellForItem(at: firstIndexPath!) as? CardCollectionViewCell
        let secondCell = collectionView.cellForItem(at: secondIndexPath) as? CardCollectionViewCell

        let card1 = cards[firstIndexPath!.row]
        let card2 = cards[secondIndexPath.row]

        if(card1.imageName == card2.imageName){
            card1.isMatched = true
            card2.isMatched = true
            firstCell?.remove()
            secondCell?.remove()
            SoundManager.playSound(.correct)
            checkGameEnded()
        }else{
            firstCell?.flip()
            secondCell?.flip()
            SoundManager.playSound(.wrong)
        }
        
        if(firstCell == nil){
            card1.isFlipped = false
            collectionView.reloadItems(at: [firstIndexPath!])
        }
        
        firstIndexPath = nil
    }
    
    func checkGameEnded () {
        var gameWon = true
        for card in cards {
            gameWon = card.isMatched
        }
        
        var message = ""
        var title = ""
        if gameWon{
            message = "You've won"
            title = "Congratulations"
        }else{
            message = "You've lost"
            title = "Game Over"
        }
        
        if(gameWon || milisseconds <= 0){
            timer?.invalidate()
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "Retry?", style: .default, handler: {
                    (UIAlertAction) in self.Setup()
                })
            
            alert.addAction(alertAction)
            
            present(alert, animated: true, completion: nil)
            }
        }
}

