//
//  HitsModel.swift
//  SampleApp
//
//  Created by Prathap Reddy on 9/19/21.
//

import UIKit

struct hitsResponse: Decodable {
    
    var hits:[hitsDic]
    var nbHits:Int?
    var page:Int?
    var nbPages:Int?
    var hitsPerPage:Int?
    var exhaustiveNbHits:Bool
    var query:String?
    var params:String?
    var processingTimeMS:Int?
}


struct hitsDic:Decodable {
    var created_at:String?
    var title:String?
    var url:String?
    var author:String?
    var points:Int?
    var nylasEventID:String?
    var story_text:String?
    var comment_text:String?
    var num_comments:Int?
    var story_id:String?
    var story_title:String?
    var story_url:String?
    var parent_id:String?
    var created_at_i:Int?
    var relevancy_score:Int?
    var _tags:[String]?
    var objectID:String?
    var _highlightResult:_highlightResultDic?
    
}

struct _highlightResultDic:Decodable {

    var title:titleDic?
    var url:urlDic?
    var author:authorDic?
    var story_text:story_textDic?
    
    
}

struct titleDic:Decodable {
    var value: String?
     var matchLevel:String?
    var fullyHighlighted:Bool?
    var matchedWords:[String]?
}

struct urlDic:Decodable {
    var value: String?
     var matchLevel:String?
    var fullyHighlighted:Bool?
    var matchedWords:[String]?
    
}

struct authorDic:Decodable {
    
    var value: String?
     var matchLevel:String?
    var fullyHighlighted:Bool?
    var matchedWords:[String]?
}

struct story_textDic:Decodable {
    var value: String?
     var matchLevel:String?
    var fullyHighlighted:Bool?
    var matchedWords:[String]?
}




class HitsModel: NSObject {

    var FetchHitsList = [hitsDic]()
  
    class var sharedInstance : HitsModel {
        struct Singleton {
            static let instance = HitsModel()
        }
        return Singleton.instance
    }
    
    private override init() {
        super.init()
    }
}



