//
//  ViewController.swift
//  CollectionViewLeft&RightDirection
//
//  Created by Abul Kashem on 21/2/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageList = ["pic1","pic2","pic3","pic4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    @IBAction func buttonLeftArrowAction(_ sender: UIButton) {
        let collectionBounds = self.collectionView.bounds
               let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x - collectionBounds.size.width))
               self.moveCollectionToFrame(contentOffset: contentOffset)
    }
    
    @IBAction func buttonRightArrowAction(_ sender: UIButton) {
        let collectionBounds = self.collectionView.bounds
        let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x + collectionBounds.size.width))
        self.moveCollectionToFrame(contentOffset: contentOffset)
        
    }
    
    func moveCollectionToFrame(contentOffset : CGFloat) {

        let frame: CGRect = CGRect(x : contentOffset ,y : self.collectionView.contentOffset.y ,width : self.collectionView.frame.width,height : self.collectionView.frame.height)
        self.collectionView.scrollRectToVisible(frame, animated: true)
    }
    

    func setupCollectionView(){
        let nib = UINib(nibName: "DirectionCvCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "DirectionCvCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }

}
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DirectionCvCell", for: indexPath) as! DirectionCvCell
        cell.imageView.image = UIImage(named: self.imageList[indexPath.row])
        
        return cell
    }
    
    
    
}

