//
//  M3U8Model.swift
//  Digiturk Mini Project
//
//  Created by Utku Eray on 2.08.2020.
//  Copyright © 2020 Utku Eray. All rights reserved.
//

struct EXTXSTREAMINF: Equatable {
    
    init() {
        averageBandwidth = 0
        bandwidth = 0
        codecs = ""
        resolution = ""
        frameRate = ""
        closedCaptions = ""
        audio = ""
        subtitles = ""
        path = ""
    }
    
    var averageBandwidth: Int
    var bandwidth: Int
    var codecs: String
    var resolution: String
    var frameRate: String
    var closedCaptions: String
    var audio: String
    var subtitles: String
    var path: String
    
    var description: String {
        return ("Average Bandwidth: " + String(averageBandwidth) +
                " Bandwidth: " + String(bandwidth) +
                " Codecs: " + codecs +
                " Resolution: " + resolution +
                " Frame Rate: " + frameRate +
                " Closed Captions: " + closedCaptions +
                " Audio: " + audio +
                " Subtitles: " + subtitles +
                " URI: " + path)
    }
    
    var descriptionSimp: String {
        return ("Bandwidth: " + String(bandwidth) +
                " Resolution: " + resolution +
                " URI: " + path)
    }
}

struct EXTXMEDIA {
    
    init() {
        type = ""
        group_id = ""
        language = ""
        name = ""
        relative_path = ""
        baseURI = ""
        segments = []
    }
    
    var type: String
    var group_id: String
    var language: String
    var name: String
    var relative_path: String
    var baseURI: String
    
    var segments: [EXTXINDEPENDENTSEGMENTS]
    
    var description: String {
        return ("Type: " + type +
                " GroupID: " + group_id +
                " Language: " + language +
                " Name: " + name +
                " URI: " + relative_path)
    }
}

struct EXTXINDEPENDENTSEGMENTS {
    
    init() {
        EXTINF = 0.0
        EXTXBITRATE = 0
        name = ""
        uri = ""
    }
    
    var EXTINF: Float
    var EXTXBITRATE: Int
    var name: String
    var uri: String
}
