//  RecordedAudio.swift
//  PitchPerfect
//  Created by Julia Miller on 10/19/15.
//  Copyright (c) 2015 Julia Miller. All rights reserved.

import Foundation
class RecordedAudio:NSObject{
    var filePathUrl:NSURL!
    var title:String!
    init(filePathUrl: NSURL, title: String){
        self.filePathUrl = filePathUrl
        self.title = title
    }
}
