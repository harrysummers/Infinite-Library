//
//  File.swift
//  InfiniteLibrary
//
//  Created by Harry Summers on 6/13/18.
//  Copyright © 2018 harrysummers. All rights reserved.
//

import Foundation

protocol GroupPickerDelegate: AnyObject {
    func didSelectGroup(_ group: Group, _ album: Album)
}
