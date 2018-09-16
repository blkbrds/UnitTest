//
//  MoviesViewControllerTest.swift
//  QuickDemoTests
//
//  Created by ToanTV on 12/20/17.
//  Copyright © 2017 ToanTV. All rights reserved.
//

import Quick
import Nimble
@testable import QuickDemo

final class MoviesViewControllerTest: QuickSpec {

    override func spec() {

        var viewController: MoviesViewController!

        describe("Movies view controller") {

            beforeEach {
                viewController = MoviesViewController()
                _ = viewController.view
                let viewModel = viewController.viewModel
                let movies = MoviesDataHelper.getMovies()
                viewModel.movies = movies
            }

            context("When table view have data") {

                it("Height for row of cell should return 60") {
                    let indexPath = IndexPath(row: 0, section: 0)
                    expect(viewController.tableView(viewController.tableView, heightForRowAt: indexPath)) == 60
                }

                it("Cell should be an instance of MoviesCell") {
                    let indexPath = IndexPath(row: 0, section: 0)
                    let cell = viewController.tableView(viewController.tableView, cellForRowAt: indexPath)
                    expect(cell).to(beAnInstanceOf(MoviesCell.self))
                }

                it("Cell should return with title is Logan and genre is Action") {
                    let index = IndexPath(row: 1, section: 0)
                    let cell = viewController.tableView(viewController.tableView, cellForRowAt: index) as? MoviesCell
                    expect(cell?.genreLabel.text) == "Action"
                    expect(cell?.titleLabel.text) == "Logan"
                }

                it("Cell should return UITableviewCell() when index out of bound") {
                    let indexPath = IndexPath(row: 1_000, section: 0)
                    let cell = viewController.tableView(viewController.tableView, cellForRowAt: indexPath)
                    expect(cell).to(beAnInstanceOf(UITableViewCell.self))
                }
            }
        }
    }
}
