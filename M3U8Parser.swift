//
//  M3U8Parser.swift
//  Digiturk Mini Project
//
//  Created by Utku Eray on 1.08.2020.
//  Copyright © 2020 Utku Eray. All rights reserved.
//

import Foundation

class M3U8Parser {
    
    let url: URL?
    var streamArray = [EXTXSTREAMINF]()
    var mediaArray = [EXTXMEDIA]()
    var baseURL: String!
    var streamCurrent = EXTXSTREAMINF()
    var mediaCurrent = EXTXMEDIA()
    
    init(url: String) {
        self.url = URL(string: url)
        self.baseURL = String(url[...url.lastIndex(of: "/")!])
        
        guard let list = try? String(contentsOf: self.url!) else { return }
        self.parseEXT_X_STREAM_INF(content: list)
    }
    
    private func parseEXT_X_STREAM_INF(content: String) {
        for line in content.components(separatedBy: .whitespacesAndNewlines) {
            if line.hasPrefix("#EXT-X-STREAM-INF:") {
                
                let averageBandwidth = matches(for: "(AVERAGE-BANDWIDTH.*?=)\\d*", in: line)
                if !averageBandwidth.isEmpty {
                    streamCurrent.averageBandwidth = Int(averageBandwidth[0].components(separatedBy: "=")[1]) ?? 0
                }
                
                var bandwidth = matches(for: "(BANDWIDTH.*?=)\\d*", in: line)
                if !averageBandwidth.isEmpty {
                    bandwidth = matches(for: ",(BANDWIDTH.*?=)\\d*", in: line)
                }
                if !bandwidth.isEmpty {
                    streamCurrent.bandwidth = Int(bandwidth[0].components(separatedBy: "=")[1]) ?? 0
                }
                
                let codecs = matches(for: "(CODECS=\".*?\")", in: line)
                if !codecs.isEmpty {
                    streamCurrent.codecs = codecs[0].components(separatedBy: "=")[1]
                }
                
                let resolution = matches(for: "(RESOLUTION=.*?)\\d*\\w\\d*", in: line)
                if !resolution.isEmpty {
                    streamCurrent.resolution = resolution[0].components(separatedBy: "=")[1]
                }
                
                let frameRate = matches(for: "(FRAME-RATE=.*?)\\d*\\.\\d*", in: line)
                if !frameRate.isEmpty {
                    streamCurrent.frameRate = frameRate[0].components(separatedBy: "=")[1]
                }
                
                let closedCaptions = matches(for: "(CLOSED-CAPTIONS=\".*?\")", in: line)
                if !closedCaptions.isEmpty {
                    streamCurrent.closedCaptions = closedCaptions[0].components(separatedBy: "=")[1]
                }
                
                let audio = matches(for: "(AUDIO=\".*?\")", in: line)
                if !audio.isEmpty {
                    streamCurrent.audio = audio[0].components(separatedBy: "=")[1]
                }
                
                let subtitles = matches(for: "(SUBTITLES=\".*?\")", in: line)
                if !subtitles.isEmpty {
                    streamCurrent.subtitles = subtitles[0].components(separatedBy: "=")[1]
                }
                
            } else if line.hasSuffix(".m3u8") {
                streamCurrent.path = line
                streamArray.append(streamCurrent)
            }
        }
    }
    
    private func parseEXT_X_MEDIA(content: String) {
        
        for line in content.components(separatedBy: .newlines) {
            if line.hasPrefix("#EXT-X-MEDIA:") {
                
                let type = matches(for: "(TYPE=)\\w*", in: line)
                if !type.isEmpty {
                    mediaCurrent.type = type[0].components(separatedBy: "=")[1]
                }
                
                let group_id = matches(for: "GROUP-ID=\".*?\")", in: line)
                if !group_id.isEmpty {
                    mediaCurrent.group_id = group_id[0].components(separatedBy: "=")[1]
                }
                
                let language = matches(for: "(LANGUAGE=\".*?\")", in: line)
                if !language.isEmpty {
                    mediaCurrent.language = language[0].components(separatedBy: "=")[1]
                }
                
                let name = matches(for: "(NAME=\".*?\")", in: line)
                if !name.isEmpty {
                    mediaCurrent.name = name[0].components(separatedBy: "=")[1]
                }
                
                let relative_path = matches(for: "(URI=\".*?\")", in: line)
                if !relative_path.isEmpty {
                    mediaCurrent.relative_path = relative_path[0].components(separatedBy: "=")[1]
                }
                
                mediaArray.append(mediaCurrent)
            }
        }
    }

    public func getStreamArray() -> [EXTXSTREAMINF] { return streamArray }
    
    public func getSortedStreamArray() -> [EXTXSTREAMINF] {
        streamArray.sort { $0.bandwidth > $1.bandwidth }
        return streamArray
    }
    
    private func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = text as NSString
            let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
