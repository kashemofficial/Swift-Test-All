//
//  ViewController.swift
//  CollectionView Demo Cell
//
//  Created by Abul Kashem on 11/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var img = ["1","2","3","4","1","2","3","4","1","2","3","4",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Details()
    }
    
    func Details(){
        let nib = UINib(nibName: "CollViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    //MARK: floyLayout collectionView
    
//    let floyLayout: UICollectionViewFlowLayout = {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumInteritemSpacing = 5
//        layout.minimumLineSpacing = 5
//        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
//        return layout
//    }()
    
    
}

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return img.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let call = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollViewCell
        call.lblName.text = String(indexPath.row)
        call.imgView.image = UIImage(named: img[indexPath.row])
        return call
        
    }
    
    //MARK: 2 ta section a asbe
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
}


extension ViewController : UICollectionViewDelegate {
    
    
}


extension ViewController : UICollectionViewDelegateFlowLayout{
    
    //MARK: height moddo khane space
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    //MARK: width moddo khane space
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }

    //MARK: top let bottom and right kom bashe newa jabe

   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }

    //MARK: cell hight and width .... estimate size None kore ai ta korte hobe automatic hole code kaj korbe nah

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: 100.0, height: 100.0)

        let width = collectionView.bounds.width
        return CGSize(width: width/5-20.0, height: width/5-20.0)

    }
    
    
    
}



