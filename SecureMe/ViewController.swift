//
//  ViewController.swift
//  SecureMe
//
//  Created by Elkana Orbach on 03/01/2021.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    // MARK: - Properties
    weak var webView: WKWebView!
    private var secureMeFinishedMessage: String { "webview" }

    // MARK: - Outlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var textField: UITextField!

    // MARK: - Actions
    @IBAction func startButtonClicked(_ sender: UIButton) {
        if let text = textField.text, let url = URL(string: text) {
            load(url: url)
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter correct URL", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
    // MARK: - Methods
	override func viewDidLoad() {
		super.viewDidLoad()
        textField.text = ""
        createWebView()
	}
    
    func load(url: URL) {
        textField.resignFirstResponder()
        startView.isHidden = true
        webView.load(URLRequest(url: url))
    }
}

// MARK: - Private API
private extension ViewController {
    
    func createWebView() {
        let configs = WKWebViewConfiguration()
        configs.allowsInlineMediaPlayback = true
        configs.userContentController.add(self, name: secureMeFinishedMessage)
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
}

// MARK: - WKNavigationDelegate
extension ViewController: WKNavigationDelegate {
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }
}

// MARK: - WKScriptMessageHandler
extension ViewController: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == self.secureMeFinishedMessage {
            //handle the finish event
            let payload = JSEventObj(body: message.body)
            switch payload?.event {
            case .success, .error:
                let alert = UIAlertController(title: payload?.event == .success ? "Success" : "Error", message: payload?.payload?.value, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Restart", style: .default) { [weak self] _ in
                    self?.webView.evaluateJavaScript("document.body.remove()")
                    self?.webView.load(URLRequest(url: URL(string: "about:blank")!))
                    self?.textField.text = nil
                    self?.startView.isHidden = false
                })
                present(alert, animated: true)
            default: break
            }
        }
    }
}
