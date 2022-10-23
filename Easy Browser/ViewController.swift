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
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(onRefreshPressed))
        
        toolbarItems = [spacer, refresh]
        
        navigationController?.isToolbarHidden = false
    }
    
    @objc private func onRefreshPressed(){
        webView.reload()
    }
    

    @objc private func onOpenPressed() {
        let ac = UIAlertController(title: "Open", message: nil, preferredStyle: .actionSheet)
        addActionsToAlertController(name: ac)
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }

    
    func addActionsToAlertController(name:UIAlertController) {
        name.addAction(UIAlertAction(title: "Apple.com", style: .default, handler: {(_) in
            self.loadWebsite(ofUrl: "https://www.apple.com")
        }))
        name.addAction(UIAlertAction(title: "My Github account", style: .default, handler: {(_) in
            self.loadWebsite(ofUrl: "https://github.com/assem16399")
        }))
        name.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    

}

