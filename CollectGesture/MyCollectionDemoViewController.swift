//
//  MyCollectionDemoViewController.swift
//  TestDemo
//
//  Created by YASYUAN LINANG on 2018/12/19.
//  Copyright © 2018 Xuan. All rights reserved.
//

import UIKit

class MyCollectionDemoViewController: UIViewController {
    var collection:UICollectionView!
    var arrData = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        collection = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .white

        collection.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        view.addSubview(collection)
        collection.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyCollectionViewCell")
        for i in 1...30 {
            arrData.append("\(i)")
        }
        
        
        collection.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture)))
    }



    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
            
        case .began:
            print("began")
            guard let selectedIndexPath = collection.indexPathForItem(at: gesture.location(in: collection)) else {
                print("break began")
                break
            }
            collection.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collection.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            collection.endInteractiveMovement()
        default:
            collection.cancelInteractiveMovement()
        }
    }

}

extension MyCollectionDemoViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("arr count = ",arrData.count)
        return arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        cell.setStr(message: arrData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/6, height: collectionView.frame.size.width/6)
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("move start")
        let temp = arrData[sourceIndexPath.item]
        arrData.remove(at: sourceIndexPath.item)
        arrData.insert(temp, at: destinationIndexPath.item)
        print("開始: \(sourceIndexPath.item)")
        print("停止: \(destinationIndexPath.item)")
    }
}
