//
//  ProgressNavigationViewController.swift
//  How-To
//
//  Created by Angel Buenrostro on 6/8/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import UIKit

class ProgressNavigationViewController: UINavigationController {
    private let progressView = UIProgressView(progressViewStyle: .bar)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProgressView()
        
        // Do any additional setup after loading the view.
    }
    
    private func setupProgressView() {
        view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progressView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            progressView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 2.0),
            
            ])
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
