//
//  MoviesViewModelTest.swift
//  QuickDemoTests
//
//  Created by ToanTV on 12/19/17.
//  Copyright © 2017 ToanTV. All rights reserved.
//

import Quick
import Nimble

@testable import QuickDemo

final class MoviesViewModelTest: QuickSpec {

    override func spec() {

        var viewModel: MoviesViewModel!

        describe("Movies view model") {

            beforeEach {
                viewModel = MoviesViewModel()
                let movies = MoviesDataHelper.getMovies()
                viewModel.movies = movies
            }

            context("When movie is not nil") {

                it("Number of item should be return 8 movies") {
                    expect(viewModel.numberOfItems(inSection: 0)) == 8
                }

                it("Movies cell view model should be an instance of MoviesCellViewModel") {
                    let indexPath = IndexPath(row: 0, section: 0)
                    expect { try viewModel.viewModelForItem(at: indexPath) }
                        .to(beAnInstanceOf(MoviesCellViewModel.self))
                }

                it("Error should be index is out of bounds") {
                    let indexPath = IndexPath(row: 100, section: 0)
                    expect { try viewModel.viewModelForItem(at: indexPath) }
                        .to(throwError())
                }
            }

            afterEach {
                viewModel = nil
            }
        }
    }
}
