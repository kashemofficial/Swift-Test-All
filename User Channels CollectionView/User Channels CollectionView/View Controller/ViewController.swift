//
//  ViewController.swift
//  User Channels CollectionView
//
//  Created by Abul Kashem on 19/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    let rest = RestManager()
    var countryData = [Result]()

    var padding     : CGFloat = 0
    var itemGap     : CGFloat = 0
    var lineGap     : CGFloat = 0
    var cellWidth   : CGFloat = 0
    var cellHeight  : CGFloat = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setUpCollectionView()
        itemSize()
        fetchData()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        itemSize()
        collectionView.reloadData()
    }
    
    func itemSize(){
        padding = UIDevice.current.userInterfaceIdiom == .phone ? 12.0 : 25.0
        itemGap = UIDevice.current.userInterfaceIdiom == .phone ? 15.0 : 30.0
        let noOfItem = UIDevice.current.userInterfaceIdiom == .phone ? 3.0 : 4.0
        cellWidth = floor((UIScreen.main.bounds.width - 2.0 * padding - itemGap * (noOfItem - 1.0)) / noOfItem)
        cellHeight = floor((3.6 * cellWidth / 3.0) + 53.0)
        lineGap = UIDevice.current.userInterfaceIdiom == .phone ? 15.0 : 35.0
    }
    
    func setUpCollectionView(){
        let nib = UINib(nibName: "ChannelCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
        
    func fetchData(){
        guard let url = URL(string: Api.MovieApiUrl) else { return }
        
        rest.makeRequest(toURL: url, withHttpMethod: .get) { result in
            
            if result.error != nil {
                print(result.error.debugDescription)
            }
            
            if let data = result.data {
                print(data)
                
                let decode = JSONDecoder()
                let welcome = try? decode.decode(Welcome.self, from: data)
                
                guard let item = welcome?.results else{return}
                self.countryData.append(contentsOf: item)
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ChannelCollectionViewCell
        cell.configure(movie: countryData[indexPath.row])
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.darkGray.cgColor

        
//        cell.imageName.image = UIImage(named: data.channelImageName)
//        cell.imageTitleName.text = data.channelTitleName
//        cell.viewsName.text = String(data.channelViews)+"K"
        //cell.layer.borderWidth = 1
       // cell.layer.borderColor = UIColor.darkGray.cgColor
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineGap
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return itemGap
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
    }

}

extension ViewController: UICollectionViewDelegate{
    
}


