//
//  ViewController.swift
//  SecureMe
//
//  Created by Elkana Orbach on 03/01/2021.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var containerView: UIView!
    weak var webView: WKWebView!
	
	var url: URL!
	
	override func viewDidLoad() {
		super.viewDidLoad()
        
        let configs = WKWebViewConfiguration()
        configs.setValue(true, forKey: "_allowUniversalAccessFromFileURLs")
        configs.preferences.javaScriptCanOpenWindowsAutomatically = true
        configs.preferences.javaScriptEnabled = true
        
        let webView = WKWebView(frame: view.bounds, configuration: configs)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(webView)
        
        [
            webView.topAnchor.constraint(equalTo: containerView.topAnchor),
            webView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ].forEach { $0.isActive = true }
        
        self.webView = webView
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
        if let url = self.url {
			webView.load(url.absoluteString) //"https://dev.10tix.me/CUu99zG6zne14FodO0Ut")
		}
	}
	
	func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
		webView.reload()
	}
}

extension WKWebView {
	func load(_ urlString: String) {
		if let url = URL(string: urlString) {
			let request = URLRequest(url: url)
			load(request)
		}
	}
}
