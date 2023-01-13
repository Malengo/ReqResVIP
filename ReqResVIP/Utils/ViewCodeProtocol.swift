//
//  ViewCodeProtocol.swift
//  ReqResVIP
//
//  Created by user on 02/12/22.
//

import UIKit

protocol ViewCodeProtocol: UIView {
    func buildViewHierachy()
    func setupConstraints()
    func addictionalConfiguration()
}

extension ViewCodeProtocol {
    func setupView() {
        buildViewHierachy()
        setupConstraints()
        addictionalConfiguration()
    }
}
