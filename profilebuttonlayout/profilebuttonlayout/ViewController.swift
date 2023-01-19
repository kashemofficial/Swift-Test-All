//
//  ViewController.swift
//  profilebuttonlayout
//
//  Created by Abul Kashem on 20/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buttonLayout()
    }
    
    func buttonLayout(){
        let button = UIButton(type: .custom)
        let imageProfile = UIImage(named: "img")
        button.setImage(imageProfile, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 20
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
        
    }
    
}


//
//import Foundation
//
//class ImageBarButton : UIView {
//    var imageView: UIImageView!
//    var button: UIButton!
//
//    convenience init(withUrl imageURL: URL? = nil, withImage image: UIImage? = nil, frame: CGRect = CGRect(x: 0, y: 0, width: 40, height: 40)) {
//        self.init(frame: frame)
//
//        imageView = UIImageView(frame: frame)
//        imageView.backgroundColor = .white
//        imageView.layer.cornerRadius = frame.height/2
//        imageView.clipsToBounds = true
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        addSubview(imageView)
//
//        button = UIButton(frame: frame)
//        button.backgroundColor = .clear
//        button.setTitle("", for: .normal)
//        addSubview(button)
//
//        if let url = imageURL { // you can use pods like Nuke or Kingfisher
//         URLSession(configuration: .default).dataTask(with: URL(string: imageUrl)!) {[weak self] (data, response, error) in
//          if let data = data , let image = UIImage(data: data) {
//              DispatchQueue.main.async {
//                self?.imgView.image = image
//              }
//           }
//         }.resume()
//        } else if let image = image {
//            self.imageView.image = image
//        }
//    }
//
//    func load()-> UIBarButtonItem {
//        return UIBarButtonItem(customView: self)
//    }
//}
