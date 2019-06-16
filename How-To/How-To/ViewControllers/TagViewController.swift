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
    var tempArray: [Howto] = []
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Categories"
        self.navigationItem.hidesBackButton = true
        if howtoController.howtos.count > 0 {
            self.allHowtos = howtoController.howtos
        }
        print("This is the amount of howtos: \(howtoController.howtos.count)")
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        collectionView.contentInset = UIEdgeInsets(top:12, left: 20, bottom: 20, right: 20)
        
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
        
        return 12
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
    
    @objc func popView(){
        self.navigationController?.popViewController(animated: true)
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
        let tagString = howtoController.tagsList[indexPath.item]
        let listVC = ListCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        listVC.collectionView.backgroundColor = .white
        
        // filter the howTos
        tempArray = allHowtos
//        filteredHowtos = tempArray.filter({$0.tags?.filter({$0.name?.z)})
        for howTo in allHowtos {
                for tag in howTo.tags! {
                    print(tag.name! + " " + tagString)
                    if tag.name == tagString {
                        filteredHowtos.append(howTo)
                    }
                }
        }
        
        
        // TODO: Make a switch checking against tag name to get the tag ID
//        listVC.tagID = 0
        listVC.parentVC = self
        listVC.tagName = tagString
        listVC.filteredHowtos = self.filteredHowtos
        //        detailVC.videoURLString =
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationItem.title = "hello"
        navigationController?.pushViewController(listVC, animated: true)
        
    }
    

}
