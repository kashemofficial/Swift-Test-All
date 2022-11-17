//
//  ViewController.swift
//  Multiple Collection View
//
//  Created by Abul Kashem on 16/11/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var mainTextView: UITextView!
    @IBOutlet weak var backgroundColorCollectionView: UICollectionView!
    @IBOutlet weak var fontStyleCollectionView: UICollectionView!
    @IBOutlet weak var fontColorCollectionView: UICollectionView!
    @IBOutlet weak var fontSizeSlider: UISlider!
    
    var allData = [DataModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setUpCollectionView()
        
        allData = [DataModel(colorName: .systemRed,  fontNames: "Arial"),
                   DataModel(colorName: .blue,      fontNames: "Thonburi"),
                   DataModel(colorName: .systemPink, fontNames: "Heiti TC"),
                   DataModel(colorName: .systemTeal, fontNames: "Courier New"),
                   DataModel(colorName: .systemGray, fontNames: "Gill Sans"),
                   DataModel(colorName: .systemGreen,fontNames: "Marker Felt"),
                   DataModel(colorName: .systemOrange,fontNames: "Helvetica Neue"),
                   DataModel(colorName: .systemYellow,fontNames: "Kailasa"),
                   DataModel(colorName: .purple, fontNames: "Kohinoor Devanagari"),
                   DataModel(colorName: .cyan, fontNames: "Kohinoor Bangla"),
                   DataModel(colorName: .gray, fontNames: "Chalkboard SE"),
                   DataModel(colorName: .green, fontNames: "Mishafi"),
                   DataModel(colorName: .red, fontNames: "Futura"),
                   DataModel(colorName: .yellow, fontNames: "Arial Hebrew"),
                   DataModel(colorName: .lightGray, fontNames: "Chalkduster")
    
        ]
        
    }

    //MARK: setUpCollectionView
    
    func setUpCollectionView(){
        
        //MARK: BackgroundCollectionViewCell
        
        let backgroundNib = UINib(nibName: "BackgroundCollectionViewCell", bundle: nil)
        backgroundColorCollectionView.register(backgroundNib, forCellWithReuseIdentifier: "backgroundcell")
        backgroundColorCollectionView.delegate = self
        backgroundColorCollectionView.dataSource = self
        
        //MARK: FontStyleCollectionViewCell
        
        let fontStyleNib = UINib(nibName: "FontStyleCollectionViewCell", bundle: nil)
        fontStyleCollectionView.register(fontStyleNib, forCellWithReuseIdentifier: "fontstylecell")
        fontStyleCollectionView.delegate = self
        fontStyleCollectionView.dataSource = self
        
        //MARK: FontColorCollectionViewCell
        
        let fontColorNib = UINib(nibName: "FontColorCollectionViewCell", bundle: nil)
        fontColorCollectionView.register(fontColorNib, forCellWithReuseIdentifier: "fontcolorcell")
        fontColorCollectionView.delegate = self
        fontColorCollectionView.dataSource = self
        
        //MARK: mainTextView Edit
        
        mainTextView.text = "This is an TextView!"
        mainTextView.layer.borderColor = UIColor.blue.cgColor
        mainTextView.layer.borderWidth = 2.5
        
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        mainTextView.centerText()
    }
    
    @IBAction func fontSliderAction(_ sender: UISlider) {
        self.mainTextView.font = UIFont.systemFont(ofSize: CGFloat(fontSizeSlider.value*65.0))
        mainTextView.centerText()
    }
    

}

extension ViewController: UICollectionViewDelegate{
    
}

extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allData.count
        
//        if collectionView == self.backgroundColorCollectionView{
//        return allData.count
//        }else if collectionView == self.fontStyleCollectionView{
//            return allData.count
//        }else if collectionView == self.fontColorCollectionView{
//            return allData.count
//        }
//        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView  == self.backgroundColorCollectionView{
            let backgroundCell = backgroundColorCollectionView.dequeueReusableCell(withReuseIdentifier: "backgroundcell", for: indexPath) as! BackgroundCollectionViewCell
            let user1 = allData[indexPath.row]
            backgroundCell.contentView.backgroundColor = user1.colorName
            return backgroundCell
        }
        else if collectionView == self.fontStyleCollectionView{
            let fontStyleCell = fontStyleCollectionView.dequeueReusableCell(withReuseIdentifier: "fontstylecell", for: indexPath) as! FontStyleCollectionViewCell
            let user2 = allData[indexPath.row]
            fontStyleCell.fontStyleNameLabel.text = user2.fontNames
            fontStyleCell.fontStyleNameLabel.font = UIFont(name: user2.fontNames!, size: 30.0)
            fontStyleCell.contentView.backgroundColor = .gray
            return fontStyleCell
        }
        else if collectionView == self.fontColorCollectionView{
            let fontColorCell = fontColorCollectionView.dequeueReusableCell(withReuseIdentifier: "fontcolorcell", for: indexPath) as! FontColorCollectionViewCell
            let user3 = allData[indexPath.row]
            fontColorCell.contentView.backgroundColor = user3.colorName
            return fontColorCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath) is BackgroundCollectionViewCell{
            mainTextView.backgroundColor = allData[indexPath.row].colorName
        }
        else if collectionView.cellForItem(at: indexPath) is FontStyleCollectionViewCell {
            let allDataName = allData[indexPath.row]
            mainTextView.selectedFontStyleName(fontName: allDataName.fontNames!)
            mainTextView.font = UIFont(name: allDataName.fontNames!, size: 30.0)
            mainTextView.centerText()
        }
        else if collectionView.cellForItem(at: indexPath) is FontColorCollectionViewCell {
        let colorArray = allData[indexPath.row]
            mainTextView.selectedFontColor(fontColor: colorArray.colorName!)
        }
        
        
        
    }
}

extension ViewController: UITextViewDelegate{
    //MARK: TextViewDelegate
    
    func textViewDidChange(_ textView: UITextView) {
        mainTextView.centerText()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        mainTextView.centerText()
        mainTextView.text = ""
    }
    
}


extension UITextView{
    func centerText(){
        self.textAlignment = .center
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale)/2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
    
    func selectedFontStyleName(fontName: String){
        self.font = UIFont(name: fontName, size: 30.0)
    }
    
    func selectedFontColor(fontColor: UIColor){
        self.textColor = fontColor
    }
    
}
