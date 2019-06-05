//
//  HomeSearchCollectionViewController.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/2/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PostCell"

class HomeSearchCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let bgColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
//    var headerView: UIView = {
//        let view = UIView()
//        view.frame = CGRect(x:0, y:0, width:(view.frame.width), height:180)
//        view.backgroundColor = #colorLiteral(red: 0.9993358254, green: 0.6708709002, blue: 0.3783961833, alpha: 1)
//        return view
//    }()
//
    let headerID = "Header"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        let frameX = (((view.frame.width) - ((view.frame.width)*0.95))/2)
//        collectionView.frame = CGRect(x: frameX,y: 0, width: view.frame.width*0.95, height: view.frame.height)
        
        let topView = UIView()

        topView.frame = CGRect(x:0, y:0, width:(view.frame.width + 40), height:200)
        topView.backgroundColor = #colorLiteral(red: 0.9993358254, green: 0.6708709002, blue: 0.3783961833, alpha: 1)
//        topView.layer.cornerRadius = 12
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 150, width: 110, height: 28)
        button.layer.cornerRadius = 6
        button.backgroundColor = .white
        button.setTitle("Learn How", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.9993358254, green: 0.6708709002, blue: 0.3783961833, alpha: 1), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 1, left: 3, bottom: 1, right: 3)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        button.layer.shadowColor = #colorLiteral(red: 0.6212611794, green: 0.3437288105, blue: 0.04521131143, alpha: 1)
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 3
        button.layer.masksToBounds = false
//        view.insertSubview(topView, aboveSubview: collectionView)
        collectionView.insertSubview(topView, at: 0)
        collectionView.insertSubview(button, at: 1)
        pinBackground(bgColorView, to: view)
        collectionView.backgroundColor = bgColorView.backgroundColor
        
        self.collectionView!.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID)
//        let flow = self.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
//        flow.headerReferenceSize = CGSize(width: 30,height: 30)
        
        // Hides navigationbar when user scrolls down
//        navigationController?.hidesBarsOnSwipe = true
        
//        collectionView.contentInset = UIEdgeInsets
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        
//        guard let collectionView = collectionView else { return }
//
//        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
//        let maxNumColumns = 2
//        let cellWidth = (availableWidth / CGFloat(maxNumColumns)).rounded(.down)
//
//        let itemSize = CGSize(width: cellWidth, height: 250)
//        self.sectionInset = UIEdgeInsets(top: self.minimumInteritemSpacing, left: 0.0, bottom: 0.0, right: 0.0)
//        self.sectionInsetReference = .fromSafeArea

        // Register cell classes
        self.collectionView!.register(PostCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    // Hides TabBar when user scrolls down
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0{
            changeTabBar(hidden: true, animated: true)
        }
        else{
            changeTabBar(hidden: false, animated: true)
        }
    }
    
    
    
    func changeTabBar(hidden:Bool, animated: Bool){
        guard let tabBar = self.tabBarController?.tabBar else { return; }
        if tabBar.isHidden == hidden{ return }
        let frame = tabBar.frame
        let offset = hidden ? frame.size.height : -frame.size.height
        let duration:TimeInterval = (animated ? 0.5 : 0.0)
        tabBar.isHidden = false
        
        UIView.animate(withDuration: duration, animations: {
            tabBar.frame = frame.offsetBy(dx: 0, dy: offset)
        }, completion: { (true) in
            tabBar.isHidden = hidden
        })
    }
    
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width, height: 170)
        } else {
            return CGSize(width: 200, height: 100)
        }
    }
    
    // MARK: HEADER
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var v : UICollectionReusableView! = nil
        if kind == UICollectionView.elementKindSectionHeader {
            v = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerID, for: indexPath)
            if v.subviews.count == 0 {
                v.addSubview(UILabel(frame:CGRect(x: 12,y: 43,width: view.frame.width,height: 50)))
            }
            
            let lab = v.subviews[0] as! UILabel
            lab.text = "Trending"
            lab.font = .boldSystemFont(ofSize: 23)
            lab.textColor = #colorLiteral(red: 0.9993600249, green: 0.5205107927, blue: 0.1008351222, alpha: 1)
            lab.textAlignment = .left
        }
        return v
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section > 0 {
            return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        }
        return UIEdgeInsets(top: 0, left: 0 , bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if indexPath.row == 0
//        {
//
//            return CGSize(width: view.frame.width, height: 200)
//        }
        return (CGSize(width: (collectionView.frame.width/2) - 36, height: 250))
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if section == 0 {
            return 0
        }
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
//        if indexPath.row == 0 {
//            postCell.backgroundColor = #colorLiteral(red: 0.8484306931, green: 0.8455678821, blue: 0.8485279679, alpha: 1)
//            return postCell
//        }
        // Configure the cell
//        postCell.layer.masksToBounds = true
//        postCell.layer.cornerRadius = 12
        
//        postCell.contentView.layer.cornerRadius = 2.0
//        postCell.contentView.layer.borderWidth = 1.0
//        postCell.contentView.layer.borderColor = UIColor.clear.cgColor
//        postCell.contentView.layer.masksToBounds = true
//        postCell.layer.shadowColor = UIColor.lightGray.cgColor
//        postCell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
//        postCell.layer.shadowRadius = 2.0
//        postCell.layer.shadowOpacity = 1.0
//        postCell.layer.masksToBounds = false
//        postCell.layer.shadowPath = UIBezierPath(roundedRect: postCell.bounds, cornerRadius: postCell.contentView.layer.cornerRadius).cgPath
        
        
        return postCell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    
    // Helper method which pins a bgColor to the very back of our screen
    private func pinBackground(_ view: UIView, to bigView: UIView){
        view.translatesAutoresizingMaskIntoConstraints = false
        bigView.insertSubview(view, at: 0)
        view.pin(to: bigView)
    }

}

