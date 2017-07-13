//
//  UserInteraction.swift
//  EasyLearn
//
//  Created by Tebeen on 5/2/17.
//  Copyright © 2017 Tebin. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

struct UserInteraction<T: WordPresentable> {
    private var word: T
    private var cell: DetailsCell
    private var indexPath: IndexPath
    private var navigationController: UINavigationController?
    
    public init(target: UIViewController, _ word: T, _ cell: DetailsCell, _ indexPath: IndexPath) {
        self.navigationController = target.navigationController
        self.word = word
        self.cell = cell
        self.indexPath = indexPath
    }
    public func didInteract() {
        cell.didTapBookmark = didTapBookmark
        cell.didTapMoreCell = didTapMoreCell
        isSubCellIcon()
    }
    private func didTapBookmark() {
        let lexicalEntry = self.word.lexicalEntry
        let word = self.word.word
        
        let id = self.word.getWordID(at: indexPath)
        let examples = self.word.getExamples(at: indexPath)
        let definition = self.word.getDefinition(at: indexPath)
        
        
        let coreData = DataLayerSimple()
        let isWord = coreData.isWordSavedWith(id: id!)
        if isWord {
            cell.btnBookmark.setTitle(String.fontAwesomeIcon("bookmark-o"), for: .normal)
            coreData.removeWordBy(id: id!)
        } else {
            cell.btnBookmark.setTitle(String.fontAwesomeIcon("bookmark"), for: .normal)
            
            
            coreData.saveWord(id, lexicalEntry, word, examples, definition)
        }
        //print(self.word.getPronunciation()) done....
        //- from here get the link and download the file.
        //1. for downloading:
        //you need a link.
        //you need the destination as well. 
        //organize the files; you don't need to do much. the file name is unique.
        
        //let proDownload = PronunciationDownloader(self.word.getPronunciation()!)
        //proDownload.download()
        
    }
    private func isSubCellIcon() {
        if word.isWord {
            if word.getCount(at: indexPath) == 0 {
                cell.isMore = true
            } else {
                cell.isMore = false
            }
        }
    }
    private func didTapMoreCell(){
        if word.isWord {
            let subDetailsController = WordSubDetailsVC(collectionViewLayout: UICollectionViewFlowLayout())
            subDetailsController.wordDetail = self.word.getDetail(at: indexPath)
            navigationController?.pushViewController(subDetailsController, animated: true)
        }
        
    }
    
}


public struct PronunciationDownloader {
    var pronunciations: [Pronunciation]
    init(_ pronunciations: [Pronunciation]) {
        self.pronunciations = pronunciations
    }
    
    
    func download() {
        let session = URLSession.shared
        var url: URL!
        //some words have more than one pronunciations such as 'often'
        //Bug: if the word doesn't have pronunciation, it crashes.
        
        for i in 0...pronunciations.count-1 {
            
            url = URL(string: pronunciations[i].audioFile!)
            var task = URLSessionDownloadTask()
            
            task = session.downloadTask(with: url!) { (url, response, error) in
                
                
                let documentURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                
                
                
                let destinationURL = documentURL.appendingPathComponent((task.response?.suggestedFilename)!)
                print(destinationURL)
                
                
                
                let fileManager = FileManager.default
                try? fileManager.removeItem(at: destinationURL)
                do {
                    try fileManager.copyItem(at: url!, to: destinationURL)
                } catch let error {
                    print("Could not copy file to disk: \(error.localizedDescription)")
                }
                
                
                
            }
            task.resume()
            
        }
        
        
        
    }
    
    
    
    
}


