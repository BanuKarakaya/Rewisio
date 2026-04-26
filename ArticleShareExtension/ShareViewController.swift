//
//  ShareViewController.swift
//  ArticleShareExtension
//
//  Created by Banu Karakaya on 12.01.2026.
//

import UIKit
import Social
import UniformTypeIdentifiers
import SharedCore
import LinkPresentation

final class ShareViewController: SLComposeServiceViewController {
    
    let sharedDate = Date()
    let group = DispatchGroup()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            extractURL()
        }

        private func extractURL() {
            guard
                let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
                let providers = extensionItem.attachments
            else {
                closeExtension()
                return
            }

            for provider in providers {
                if provider.hasItemConformingToTypeIdentifier("public.url") {
                    provider.loadItem(forTypeIdentifier: "public.url", options: nil) { [weak self] item, error in
                        guard let self = self else { return }
                        
                        if let url = item as? URL {
                            print("📎 Shared URL:", url.absoluteString)
                            
                            let context = CoreDataStack.shared.context
                            
                            let article = ArticlesDemoEntity(context: context)
                            article.articleUrl = url.absoluteString
                            article.articleDate = sharedDate
                            
                            group.enter()
                            fetchTitle(from: url) { title in
                                print("Makale başlığı:", title ?? "bulunamadı")
                                article.articleName = title
                                self.group.leave()
                            }
                            
                            group.enter()
                            fetchImage(from: url) { image in
                                guard let image = image else { return }
                                if let data = image.jpegData(compressionQuality: 0.8) {
                                    article.articleImage = data
                                    
                                }
                                self.group.leave()
                            }
                            
                            group.notify(queue: .main) {
                                print("Bütün işlemler bitti")
                                do {
                                    try context.save()
                                    print("Article saved successfully!")
                                } catch {
                                    print("Failed to save Article: \(error.localizedDescription)")
                                }
                            }
                        }
                        self.closeExtension()
                    }
                    return
                }
            }
        }
    
    func fetchTitle(from url: URL, completion: @escaping (String?) -> Void) {
        let provider = LPMetadataProvider()
        
        provider.startFetchingMetadata(for: url) { metadata, error in
            if let title = metadata?.title {
                completion(title)
            } else {
                completion(nil)
            }
        }
    }
    
    func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        
        let provider = LPMetadataProvider()
        
        provider.startFetchingMetadata(for: url) { metadata, error in
            
            guard let metadata = metadata else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            let imageProvider = metadata.imageProvider ?? metadata.iconProvider
            
            guard let itemProvider = imageProvider else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    completion(image as? UIImage)
                }
            }
        }
    }
    
    private func closeExtension() {
        DispatchQueue.main.async {
            self.extensionContext?.completeRequest(returningItems: nil)
        }
    }
}
