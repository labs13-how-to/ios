//
//  TagViewController.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/9/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation
import UIKit

private let reuseIdentifier = "TagCell"

class TagViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let howtoController = HowtoController()
    var allHowtos: [Howto] = []
    var filteredHowtos: [Howto] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if howtoController.howtos.count > 0 {
            self.allHowtos = howtoController.howtos
        }
        
        self.collectionView.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        
        collectionView.contentInset = UIEdgeInsets(top:10, left: 0, bottom: 0, right: 0)
        
        self.collectionView!.register(TagCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.frame.width >= 375 {
            return (CGSize(width: (collectionView.frame.width) - 36, height: (collectionView.frame.height/16)))
        }
        return CGSize(width: (collectionView.frame.width) - 36, height: (collectionView.frame.height/16))
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
                return howtoController.tagsList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TagCell
        var fetchedPost: Howto?
        
        cell.tagLabel.text = howtoController.tagsList[indexPath.item]
        cell.backgroundView?.backgroundColor = #colorLiteral(red: 0.9212495685, green: 0.9219488502, blue: 0.9213578105, alpha: 1)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tag = howtoController.tagsList[indexPath.item]
        let listVC = ListCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        listVC.collectionView.backgroundColor = .white
        
        // TODO: Make a switch checking against tag name to get the tag ID
        listVC.tagID = 0
        listVC.tagName = tag
        //        detailVC.videoURLString =
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationItem.title = "hello"
        navigationController?.pushViewController(listVC, animated: true)
        
    }
    

}
