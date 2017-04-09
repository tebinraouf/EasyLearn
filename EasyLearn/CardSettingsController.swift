//
//  CardSettingsController.swift
//  EasyLearn
//
//  Created by Tebeen on 4/7/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit

class CardSettingsController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let sections = ["Play Speed", "Hide/Show", "Colors", "Flipping","Background Image"]
    
    lazy var tableView: UITableView = {
       let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
//    var cvTitle: LeftPaddedUILabel = {
//        let label = LeftPaddedUILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Image for Background"
//        label.backgroundColor = .appGray
//        label.textColor = .black
//        return label
//        
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        registerCells()
        setupView()
    }
    
    func registerCells(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "csCell")
    }
    
    func setupView(){
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
//        collectionView.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
//        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true

        
    }
    
    
    //MARK:- TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        switch section {
        case 1:
            count = 2
        case 2:
            count = 2
        default:
            count = 1
        }
    
        return count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.backgroundColor = .blue
        } else if indexPath.section == 1 {
            cell.backgroundColor = .yellow
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        var header = ""
        switch section {
        case 0:
            header = sections[0]
        case 1:
            header = sections[1]
        case 2:
            header = sections[2]
        case 3:
            header = sections[3]
        case 4:
            header = sections[4]
        default:
            header = ""
        }
        
        return header
    
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 4 {
            
        }
    }
    
    //MARK:- CollectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "csCell", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width/3 - 1.5, height: collectionView.frame.size.width/3 - 1.5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
}


class NavigationControllerNoAutorotate: UINavigationController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    override var shouldAutorotate: Bool {
        return false
    }
}







