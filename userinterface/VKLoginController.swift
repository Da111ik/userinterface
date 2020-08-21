//
//  VKLoginController.swift
//  userinterface
//
//  Created by Дарья Шимко on 18.08.2020.
//  Copyright © 2020 Дарья Шимко. All rights reserved.
//

import UIKit
import WebKit

class VKLoginController: UIViewController {
    
    @IBOutlet var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "7571271"),
            URLQueryItem(name: "scope", value: "photos,photos,offline,groups,wall"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.122")
        ]
        
        let request = URLRequest(url: components.url!)
        webView.load(request)
        
    }
}

extension VKLoginController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment else { decisionHandler(.allow); return }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        print(params)
        
        guard let token = params["access_token"],
            let userIdString = params["user_id"],
            let userId = Int(userIdString) else {
                decisionHandler(.allow)
                return
        }
        
        Session.shared.token = token
        Session.shared.userId = userId
        
        // Пример для вывода в консоль
        NetworkService.shared.loadFriends(token: token)
        
        NetworkService.shared.loadPhotos(token: token, ownerId: Session.shared.userId)
        
        NetworkService.shared.loadGroups(token: token)
        
        NetworkService.shared.loadSearchGroups(token: token, query: "Music")
        
        decisionHandler(.cancel)
    }
}

