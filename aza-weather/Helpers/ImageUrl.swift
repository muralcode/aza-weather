//
//  ImageUrl.swift
//  aza-weather
//
//  Created by Lerato Mokoena on 2024/01/19.
//

import Foundation
import Combine
import UIKit

class ImageUrl: ObservableObject {
    private var cancellable: AnyCancellable?
    let objectWillChange = PassthroughSubject<UIImage?, Never>()
    
    func load(url: URL) {
        self.cancellable = URLSession.shared
            .dataTaskPublisher(for: url)
            .map({ $0.data })
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .map({ UIImage(data: $0) })
            .replaceError(with: nil)
            .sink(receiveValue: { image in
                self.objectWillChange.send(image)
            })
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
