//
//  ViewController.swift
//  webView
//
//  Created by Abul Kashem on 28/3/23.
//

import UIKit
import WebKit

class ViewController: UIViewController,UIWebViewDelegate, WKUIDelegate{
    @IBOutlet weak var mainView: UIView!
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
            self.setView()
    }

    func setView(){
        webView.uiDelegate = self
        webView = WKWebView(frame: mainView.bounds, configuration: WKWebViewConfiguration())
        webView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        mainView.addSubview(webView)
        let url = URL(string: "https://www.youtube.com/")
        let request = URLRequest(url: url!)
        webView.load(request)
        
    }
    
    
    
}

