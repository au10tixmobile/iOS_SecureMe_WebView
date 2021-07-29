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
	
    private var secureMeFinishedMessage: String { "webview" }
    
	override func viewDidLoad() {
		super.viewDidLoad()

        createWebView()
	}
    
    private func createWebView() {
        let configs = WKWebViewConfiguration()
        configs.allowsInlineMediaPlayback = true
        configs.userContentController.add(self, name: secureMeFinishedMessage)
        
        let webView = WKWebView(frame: view.bounds, configuration: configs)
        webView.customUserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36"
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
    
    func load(url: URL) {
        webView.load(URLRequest(url: url))
    }
	
	func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
		webView.reload()
	}
}

extension ViewController: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        if message.name == self.secureMeFinishedMessage {
            //handle the finish event
            let obj = JSEventObj(dict: message.body as? [String:Any] ?? [:])
        }
        
    }
    
}
