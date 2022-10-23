//
//  ViewController.swift
//  Easy Browser
//
//  Created by Aasem Hany on 19/10/2022.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView:WKWebView!

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureNavBar()
        
        loadWebsite(ofUrl: "https://www.hackingwithswift.com/100")
    }
    
    
    private func loadWebsite(ofUrl url:String) {
        let url = URL(string: url)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain,  target: self, action: #selector(onOpenPressed))
    }
    
    @objc private func onOpenPressed() {
        let ac = UIAlertController(title: "Open", message: nil, preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Apple Websit", style: .default, handler: {(_) in
            self.loadWebsite(ofUrl: "https://www.apple.com")
        }))
        
        ac.addAction(UIAlertAction(title: "My Github account", style: .default, handler: {(_) in
            self.loadWebsite(ofUrl: "https://github.com/assem16399")

        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem

        present(ac, animated: true)
        
    }

    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

}

