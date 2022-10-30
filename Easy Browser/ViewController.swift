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
    var loadingProgressBar: UIProgressView!
    var websites=[
        "www.hackingwithswift.com",
        "www.apple.com",
        "github.com"
    ]

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureNavBar()
        loadWebsite(ofUrl: websites[0])
    }
    
    
    private func loadWebsite(ofUrl url:String) {
        let url = URL(string: "https://"+url)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    private func configureNavBar() {
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain,  target: self, action: #selector(onOpenPressed))
        
        loadingProgressBar = UIProgressView(progressViewStyle: .default)
        loadingProgressBar.sizeToFit()
        
        let progressButton = UIBarButtonItem(customView: loadingProgressBar)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(onRefreshPressed))
        
        toolbarItems = [progressButton, spacer, refresh]
    
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
        websites.forEach{element in name.addAction(UIAlertAction(title: element, style: .default, handler: {(_) in
            self.loadWebsite(ofUrl: element)
        }))}
        
        name.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            loadingProgressBar.progress = Float(webView.estimatedProgress)
        }
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url

            if let host = url?.host {
                for website in websites {
                    print(host)
                    if host.contains(website) {
                        decisionHandler(.allow)
                        return
                    }
                }
            }
        
            decisionHandler(.cancel)
    }
}

