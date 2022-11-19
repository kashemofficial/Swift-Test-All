//
//  ViewController.swift
//  api Image label
//
//  Created by Abul Kashem on 19/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    var data = [ToDo]()
    var padding : CGFloat = 0
    var itemGap : CGFloat = 0
    var lineGap : CGFloat = 0

    var cellWidth : CGFloat = 0
    var cellHeight : CGFloat = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemSize()
        setUpCollectionView()
        
        fetchingAPTData(URL: "https://api.opendota.com/api/heroStats"){ result in
            self.data = result
           
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        itemSize()
        collectionView.reloadData()
    }
    
    func setUpCollectionView(){
        let nib = UINib(nibName: "ApiCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    func itemSize() {
        padding = UIDevice.current.userInterfaceIdiom == .phone ? 12.0 : 25.0
        itemGap = UIDevice.current.userInterfaceIdiom == .phone ? 15.0 : 30.0
        let noOfItem = UIDevice.current.userInterfaceIdiom == .phone ? 3.0 : 4.0
        
        cellWidth = floor((UIScreen.main.bounds.width - 2.0 * padding - itemGap * (noOfItem - 1.0)) / noOfItem)
        cellHeight = floor((5.0 * cellWidth / 3.0) + 53.0)
        
        lineGap = UIDevice.current.userInterfaceIdiom == .phone ? 15.0 : 35.0
    }
    
    func fetchingAPTData(URL url:String, completion: @escaping ([ToDo]) -> Void){
        let url = URL(string: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!){data,response,error in
            do{
                let parsingData = try JSONDecoder().decode([ToDo].self,from:data!)
                completion(parsingData)
            }catch{
                print("Error")
            }
        }
        dataTask.resume()
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",for: indexPath) as! ApiCollectionViewCell
        let apiAllData = data[indexPath.row]
        let string = "https://api.opendota.com"+(apiAllData.img)
        let url = URL(string: string)
        cell.apiImageName.downloaded(from: url!, contentMode: .scaleToFill)
        cell.apiLabelName1.text = apiAllData.localized_name
        cell.apiLabelName2.text = apiAllData.name
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate{
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: cellWidth, height: cellHeight)
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


//MARK: Downloaded API Image

extension UIImageView{
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit){
        contentMode = mode
        URLSession.shared.dataTask(with: url){data,response,error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
            else{
                return
            }
            DispatchQueue.main.async() {
                [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String,contentMode mode: ContentMode = .scaleAspectFit){
        guard let url = URL(string: link)else{return}
        downloaded(from: url,contentMode: mode)
    }
}
