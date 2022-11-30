//
//  ViewController.swift
//  API Image TableView
//
//  Created by Abul Kashem on 19/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    var data = [ToDo]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        fetchingAPTData(URL: "https://api.opendota.com/api/heroStats"){ result in
            self.data = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "APITableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        
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

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! APITableViewCell
        let apiAllData = data[indexPath.row]
        let string = "https://api.opendota.com"+(apiAllData.img)
        let url = URL(string: string)
        cell.apiImageName.downloaded(from: url!, contentMode: .scaleToFill)
        cell.apiLabelName.text = apiAllData.localized_name
        //cell.apiLabelName.text = apiAllData.name
        return cell
    }
}

extension ViewController : UITableViewDelegate{
    
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
