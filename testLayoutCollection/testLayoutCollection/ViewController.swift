//
//  ViewController.swift
//  testLayoutCollection
//
//  Created by oneweek on 10/12/18.
//  Copyright © 2018 Harry Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var clView : UICollectionView!
    var currentCell : CollectionViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let layout = self.clView.collectionViewLayout as? CustomLayoutCollection {
            layout.delegate = self
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.showCellWhenPop()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = self
    }
    
    
    func showCellWhenPop(){
        if let cell = self.currentCell {
            cell.isHidden = false
        }
    }
    
    
    func show(cell:CollectionViewCell) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let view2 = story.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        view2.transitioningDelegate = self
        navigationController?.pushViewController(view2, animated: true)
        cell.isHidden = true
        self.currentCell = cell
    }

}

extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource,CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    func heightOfRows() -> CGFloat {
        return 230
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
//        let position = (indexPath.item + 1) % 3
        cell.imvPhoto.image = UIImage(named: "img_test")
        cell.lbNumber.text = "\(indexPath.item + 1)"
//        if position == 0 {
//            cell.lbNumber.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//        }else if position == 1 {
//            cell.lbNumber.backgroundColor = UIColor.red.withAlphaComponent(0.4)
//        }else{
//            cell.lbNumber.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
//        }
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {

        UIView.animate(withDuration: 0.3) {
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: {
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.transform = CGAffineTransform.identity
            }
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
            TransitionManager.shared.animatorOverOut.originFrame = self.clView.convert(cell.frame, to: self.view)
            TransitionManager.shared.animatorOverIn.destinationFrame = self.clView.convert(cell.frame, to: self.view)
            TransitionManager.shared.photo = cell.imvPhoto.image
            
            self.show(cell:cell)
            
        }
        
    }
    
}

extension ViewController : UIViewControllerTransitioningDelegate,UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            return TransitionManager.shared.animatorOverOut
        }else{
            return TransitionManager.shared.animatorOverIn
        }
    }
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    
    
}
