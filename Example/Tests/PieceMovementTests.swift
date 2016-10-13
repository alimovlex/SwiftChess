//
//  PieceMovementTests.swift
//  SwiftChess
//
//  Created by Steve Barnegren on 20/09/2016.
//  Copyright © 2016 Steve Barnegren. All rights reserved.
//

import XCTest
import SwiftChess

class PieceMovementTests: XCTestCase {

    
    // MARK: - Setup / Tear down
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Board Testing
    
    func testBoard(board: ASCIIBoard, movingPiece: Character, movement: PieceMovement) {
        
        // Get the index of the moving piece
        let movingIndex = board.indexOfCharacter(movingPiece)
        
        // Test allowed locations
        let allowedIndexes = board.indexesWithCharacter("*")
        if allowedIndexes.count > 0 {
            
            for allowedIndex in allowedIndexes {
                XCTAssertTrue(
                    movement.canPieceMove(fromLocation: BoardLocation(index: movingIndex),
                                          toLocation: BoardLocation(index: allowedIndex),
                                          board: board.board),
                    "Allowed Index was invalid: \(allowedIndex)")
            }
        }
        
        // Test invalid locations
        let invalidIndexes = board.indexesWithCharacter("!")
        if invalidIndexes.count > 0 {
            
            for invalidIndex in invalidIndexes {
                XCTAssertFalse(
                    movement.canPieceMove(fromLocation: BoardLocation(index: movingIndex),
                                          toLocation: BoardLocation(index: invalidIndex),
                                          board: board.board),
                    "Invalid index was valid: \(invalidIndex)")
            }
        }

    }
    
    func canMakeMove(board: ASCIIBoard, from: Character, to: Character, movement: PieceMovement) -> Bool {
        
        let movingIndex = board.indexOfCharacter(from)
        let targetIndex = board.indexOfCharacter(to)
        
        return movement.canPieceMove(fromLocation: BoardLocation(index: movingIndex),
                                     toLocation: BoardLocation(index: targetIndex),
                                     board: board.board)
    }
    
    // MARK: - Straight Line Movement
    
    func testStraightLineMovementCanMoveUp() {
        
        let board = ASCIIBoard( "* - - - - - - -" +
                                "* - - - - - - -" +
                                "* - - - - - - -" +
                                "* - - - - - - -" +
                                "* - - - - - - -" +
                                "* - - - - - - -" +
                                "* - - - - - - -" +
                                "W - - - - - - -" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementStraightLine())
        
    }
    
    func testStraightLineMovementCanMoveDown() {
        
        let board = ASCIIBoard( "W - - - - - - -" +
                                "* - - - - - - -" +
                                "* - - - - - - -" +
                                "* - - - - - - -" +
                                "* - - - - - - -" +
                                "* - - - - - - -" +
                                "* - - - - - - -" +
                                "* - - - - - - -" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementStraightLine())
        
    }
    
    
    
    func testStraightLineMovementCanMoveRight() {
     
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "W * * * * * * *" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementStraightLine())

    }
    
    func testStraightLineMovementCanMoveLeft() {
        
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "* * * * * * * W" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementStraightLine())

    }
    
 
 
    func testStraightLineMovementCannotMoveToInvalidPositionFromCenter() {
     
        let board = ASCIIBoard( "! ! ! * ! ! ! !" +
                                "! ! ! * ! ! ! !" +
                                "! ! ! * ! ! ! !" +
                                "* * * W * * * *" +
                                "! ! ! * ! ! ! !" +
                                "! ! ! * ! ! ! !" +
                                "! ! ! * ! ! ! !" +
                                "! ! ! * ! ! ! !" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementStraightLine())
        
    }
    
    func testStraightLineMovementCannotMoveToInvalidPositionFromTopLeft() {
        
        let board = ASCIIBoard( "W * * * * * * *" +
                                "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementStraightLine())
        
    }
    
    func testStraightLineMovementCannotMoveToInvalidPositionFromTopRight() {
        
        let board = ASCIIBoard( "* * * * * * * W" +
                                "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementStraightLine())
        
    }
    
    func testStraightLineMovementCannotMoveToInvalidPositionFromBottomLeft() {
        
        let board = ASCIIBoard( "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" +
                                "W * * * * * * *" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementStraightLine())
    }
    
    func testStraightLineMovementCannotMoveToInvalidPositionFromBottomRight() {
        
        let board = ASCIIBoard( "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" +
                                "* * * * * * * W" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementStraightLine())
        
    }
    
    
    
    func testStraightLineMovementCannotMoveThroughOpponent() {
        
        let board = ASCIIBoard( "- - - ! - - - -" +
                                "- - - ! - - - -" +
                                "- - - B - - - -" +
                                "- - - * - - - -" +
                                "! B * W * B ! !" +
                                "- - - * - - - -" +
                                "- - - B - - - -" +
                                "- - - ! - - - -" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementStraightLine())

     }
    
    func testDiagonalMovementCanMoveNE() {
        
        let board = ASCIIBoard( "- - - - - - - *" +
                                "- - - - - - * -" +
                                "- - - - - * - -" +
                                "- - - - * - - -" +
                                "- - - * - - - -" +
                                "- - * - - - - -" +
                                "- * - - - - - -" +
                                "W - - - - - - -" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementDiagonal())

    }
    
    func testDiagonalMovementCanMoveSE() {
        
        let board = ASCIIBoard( "W - - - - - - -" +
                                "- * - - - - - -" +
                                "- - * - - - - -" +
                                "- - - * - - - -" +
                                "- - - - * - - -" +
                                "- - - - - * - -" +
                                "- - - - - - * -" +
                                "- - - - - - - *" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementDiagonal())

    }
    
    func testDiagonalMovementCanMoveSW() {
        
        let board = ASCIIBoard( "- - - - - - - W" +
                                "- - - - - - * -" +
                                "- - - - - * - -" +
                                "- - - - * - - -" +
                                "- - - * - - - -" +
                                "- - * - - - - -" +
                                "- * - - - - - -" +
                                "* - - - - - - -" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementDiagonal())

    }
    
    func testDiagonalMovementCanMoveNW() {
        
        let board = ASCIIBoard( "* - - - - - - -" +
                                "- * - - - - - -" +
                                "- - * - - - - -" +
                                "- - - * - - - -" +
                                "- - - - * - - -" +
                                "- - - - - * - -" +
                                "- - - - - - * -" +
                                "- - - - - - - W" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementDiagonal())

    }
    
    func testDiagonalMovementCannotMoveToInvalidPositionFromCenter() {
        
        let board = ASCIIBoard( "! ! ! ! ! ! ! *" +
                                "* ! ! ! ! ! * !" +
                                "! * ! ! ! * ! !" +
                                "! ! * ! * ! ! !" +
                                "! ! ! W ! ! ! !" +
                                "! ! * ! * ! ! !" +
                                "! * ! ! ! * ! !" +
                                "* ! ! ! ! ! * !" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementDiagonal())

     }
    
    func testDiagonalMovementCannotMoveToInvalidPositionFromTopLeft() {
        
        let board = ASCIIBoard( "W ! ! ! ! ! ! !" +
                                "! * ! ! ! ! ! !" +
                                "! ! * ! ! ! ! !" +
                                "! ! ! * ! ! ! !" +
                                "! ! ! ! * ! ! !" +
                                "! ! ! ! ! * ! !" +
                                "! ! ! ! ! ! * !" +
                                "! ! ! ! ! ! ! *" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementDiagonal())
        
    }
    
    func testDiagonalMovementCannotMoveToInvalidPositionFromTopRight() {
        
        let board = ASCIIBoard( "! ! ! ! ! ! ! W" +
                                "! ! ! ! ! ! * !" +
                                "! ! ! ! ! * ! !" +
                                "! ! ! ! * ! ! !" +
                                "! ! ! * ! ! ! !" +
                                "! ! * ! ! ! ! !" +
                                "! * ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementDiagonal())
        
    }
    
    func testDiagonalMovementCannotMoveToInvalidPositionFromBottomLeft() {
        
        let board = ASCIIBoard( "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! * !" +
                                "! ! ! ! ! * ! !" +
                                "! ! ! ! * ! ! !" +
                                "! ! ! * ! ! ! !" +
                                "! ! * ! ! ! ! !" +
                                "! * ! ! ! ! ! !" +
                                "W ! ! ! ! ! ! !" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementDiagonal())
        
    }
    
    func testDiagonalMovementCannotMoveToInvalidPositionFromBottomRight() {
        
        let board = ASCIIBoard( "* ! ! ! ! ! ! !" +
                                "! * ! ! ! ! ! !" +
                                "! ! * ! ! ! ! !" +
                                "! ! ! * ! ! ! !" +
                                "! ! ! ! * ! ! !" +
                                "! ! ! ! ! * ! !" +
                                "! ! ! ! ! ! * !" +
                                "! ! ! ! ! ! ! W" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementDiagonal())
        
    }

    // MARK: - Knight Movement
    
    func testKnightMovementCanMoveToClockwisePosition1() {
        
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - * - - -" +
                                "- - - - - - - -" +
                                "- - - W - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementKnight())

    }
    
    func testKnightMovementCanMoveToClockwisePosition2() {
        
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - * - -" +
                                "- - - W - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementKnight())

    }
    
    func testKnightMovementCanMoveToClockwisePosition3() {
        
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - W - - - -" +
                                "- - - - - * - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementKnight())
        
    }
    
    func testKnightMovementCanMoveToClockwisePosition4() {
        
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - W - - - -" +
                                "- - - - - - - -" +
                                "- - - - * - - -" +
                                "- - - - - - - -" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementKnight())

    }

    func testKnightMovementCanMoveToClockwisePosition5() {
        
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - W - - - -" +
                                "- - - - - - - -" +
                                "- - * - - - - -" +
                                "- - - - - - - -" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementKnight())

    }
    
    func testKnightMovementCanMoveToClockwisePosition6() {
        
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - W - - - -" +
                                "- * - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementKnight())

    }

    func testKnightMovementCanMoveToClockwisePosition7() {
        
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- * - - - - - -" +
                                "- - - W - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementKnight())

    }

    func testKnightMovementCanMoveToClockwisePosition8() {
        
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - * - - - - -" +
                                "- - - - - - - -" +
                                "- - - W - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementKnight())

    }
    
    func testKnightMovementCannotMoveToInvalidPositionFromCenter() {
        
        let board = ASCIIBoard( "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! * ! * ! ! !" +
                                "! * ! ! ! * ! !" +
                                "! ! ! W ! ! ! !" +
                                "! * ! ! ! * ! !" +
                                "! ! * ! * ! ! !" +
                                "! ! ! ! ! ! ! !" )

        testBoard(board: board, movingPiece: "W", movement: PieceMovementKnight())
        
    }
    
    func testKnightMovementCannotMoveToInvalidPositionFromTopLeft() {
        
        let board = ASCIIBoard( "W ! ! ! ! ! ! !" +
                                "! ! * ! ! ! ! !" +
                                "! * ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementKnight())
        
    }
    
    func testKnightMovementCannotMoveToInvalidPositionFromTopRight() {
        
        let board = ASCIIBoard( "! ! ! ! ! ! ! W" +
                                "! ! ! ! ! * ! !" +
                                "! ! ! ! ! ! * !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementKnight())
        
    }
    
    func testKnightMovementCannotMoveToInvalidPositionFromBottomLeft() {
        
        let board = ASCIIBoard( "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! * ! ! ! ! ! !" +
                                "! ! * ! ! ! ! !" +
                                "W ! ! ! ! ! ! !" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementKnight())
        
    }
    
    func testKnightMovementCannotMoveToInvalidPositionFromBottomRight() {
        
        let board = ASCIIBoard( "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! * !" +
                                "! ! ! ! ! * ! !" +
                                "! ! ! ! ! ! ! W" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementKnight())
        
    }
    
    // MARK: - King Movement
    
    func testKingMovementCannotMoveToInvalidPositionFromCenter() {
        
        let board = ASCIIBoard( "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! * * * ! ! !" +
                                "! ! * W * ! ! !" +
                                "! ! * * * ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementKing())
        
    }
    
    func testKingMovementCannotMoveToInvalidPositionFromTopLeft() {
        
        let board = ASCIIBoard( "W * ! ! ! ! ! !" +
                                "* * ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementKing())
        
    }
    
    func testKingMovementCannotMoveToInvalidPositionFromTopRight() {
        
        let board = ASCIIBoard( "! ! ! ! ! ! * W" +
                                "! ! ! ! ! ! * *" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementKing())
        
    }
    
    func testKingMovementCannotMoveToInvalidPositionFromBottomLeft() {
        
        let board = ASCIIBoard( "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "* * ! ! ! ! ! !" +
                                "W * ! ! ! ! ! !" )
                            
        testBoard(board: board, movingPiece: "W", movement: PieceMovementKing())
        
    }
    
    func testKingMovementCannotMoveToInvalidPositionFromBottomRight() {
        
        let board = ASCIIBoard( "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! * *" +
                                "! ! ! ! ! ! * W" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementKing())
        
    }
    
    // MARK: - Pawn Movement
    
    func testWhitePawnCanMoveAheadOneSpace() {
        
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - * - - - -" +
                                "- - - P - - - -" +
                                "- - - - - - - -" )
        
        testBoard(board: board, movingPiece: "P", movement: PieceMovementPawn())
        
    }
    
    func testBlackPawnCanMoveAheadOneSpace() {
        
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- - - p - - - -" +
                                "- - - * - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" )
        
        testBoard(board: board, movingPiece: "p", movement: PieceMovementPawn())
        
    }

    
    func testWhitePawnCanMoveAheadTwoSpaces() {
        
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - * - - - -" +
                                "- - - - - - - -" +
                                "- - - P - - - -" +
                                "- - - - - - - -" )
        
        testBoard(board: board, movingPiece: "P", movement: PieceMovementPawn())
        
    }
    
    func testBlackPawnCanMoveAheadTwoSpaces() {
        
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- - - p - - - -" +
                                "- - - - - - - -" +
                                "- - - * - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" )
        
        testBoard(board: board, movingPiece: "p", movement: PieceMovementPawn())
        
    }
    
    func testNonStartingRowWhitePawnCannotMoveAheadTwoSpaces() {
        
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - ! - - - -" +
                                "- - - - - - - -" +
                                "- - - P - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" )
        
        testBoard(board: board, movingPiece: "P", movement: PieceMovementPawn())
        
    }
    
    func testNonStartingRowBlackPawnCannotMoveAheadTwoSpaces() {
        
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - p - - - -" +
                                "- - - - - - - -" +
                                "- - - ! - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" )
        
        testBoard(board: board, movingPiece: "p", movement: PieceMovementPawn())
        
    }
    
    func testStartingRowWhitePawnCannotMoveToInvalidPosition() {
        
        let board = ASCIIBoard( "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! * ! ! ! !" +
                                "! ! ! * ! ! ! !" +
                                "! ! ! P ! ! ! !" +
                                "! ! ! ! ! ! ! !" )
        
        testBoard(board: board, movingPiece: "P", movement: PieceMovementPawn())
        
    }
    
    func testStartingRowBlackPawnCannotMoveToInvalidPosition() {
        
        let board = ASCIIBoard( "! ! ! ! ! ! ! !" +
                                "! ! ! p ! ! ! !" +
                                "! ! ! * ! ! ! !" +
                                "! ! ! * ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" )
        
        testBoard(board: board, movingPiece: "p", movement: PieceMovementPawn())
        
    }

    
    func testNonStartingRowWhitePawnCannotMoveToInvalidPosition() {
        
        let board = ASCIIBoard( "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! * ! ! ! !" +
                                "! ! ! P ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" )
        
        testBoard(board: board, movingPiece: "P", movement: PieceMovementPawn())
        
    }
    
    func testNonStartingRowBlackPawnCannotMoveToInvalidPosition() {
        
        let board = ASCIIBoard( "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! p ! ! ! !" +
                                "! ! ! * ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" +
                                "! ! ! ! ! ! ! !" )
        
        testBoard(board: board, movingPiece: "p", movement: PieceMovementPawn())
        
    }
    
    func testWhitePawnCannotTakePieceByMovingForwardOneSpace() {
        
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- p - - - - - -" +
                                "- P - - - - - -" +
                                "- - - - - - - -" )
        
        XCTAssert(canMakeMove(board: board, from: "P", to: "p", movement: PieceMovementPawn()) == false)
        
    }
    
    func testBlackPawnCannotTakePieceByMovingForwardOneSpace() {
        
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- p - - - - - -" +
                                "- P - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" )
        
        XCTAssert(canMakeMove(board: board, from: "p", to: "P", movement: PieceMovementPawn()) == false)
        
    }
    
    func testWhitePawnCannotTakePieceByMovingForwardTwoSpaces() {
        
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- p - - - - - -" +
                                "- - - - - - - -" +
                                "- P - - - - - -" +
                                "- - - - - - - -" )
        
        XCTAssert(canMakeMove(board: board, from: "P", to: "p", movement: PieceMovementPawn()) == false)
        
    }
    
    func testBlackPawnCannotTakePieceByMovingForwardTwoSpaces() {
        
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- p - - - - - -" +
                                "- - - - - - - -" +
                                "- P - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" )
        
        XCTAssert(canMakeMove(board: board, from: "p", to: "P", movement: PieceMovementPawn()) == false)
        
    }
    
    func testWhitePawnCanTakePieceDiagonallyToLeft() {
        
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - p - - - - -" +
                                "- - - P - - - -" +
                                "- - - - - - - -" )
        
        XCTAssert(canMakeMove(board: board, from: "P", to: "p", movement: PieceMovementPawn()))
        
    }
    
    func testWhitePawnCanTakePieceDiagonallyToRight() {
        
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - p - - -" +
                                "- - - P - - - -" +
                                "- - - - - - - -" )
        
        XCTAssert(canMakeMove(board: board, from: "P", to: "p", movement: PieceMovementPawn()))
        
    }

    
    func testBlackPawnCanTakePieceDiagonallyToLeft() {
        
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- - - p - - - -" +
                                "- - P - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" )
        
        XCTAssert(canMakeMove(board: board, from: "p", to: "P", movement: PieceMovementPawn()))
        
    }
    
    func testBlackPawnCanTakePieceDiagonallyToRight() {
        
        let board = ASCIIBoard( "- - - - - - - -" +
                                "- - - p - - - -" +
                                "- - - - P - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" +
                                "- - - - - - - -" )
        
        XCTAssert(canMakeMove(board: board, from: "p", to: "P", movement: PieceMovementPawn()))
        
    }


    
    // MARK: - Queen movement
    
    func testQueenCannotMoveToInvalidPositionFromCentre(){
        
        let board = ASCIIBoard( "! ! ! * ! ! ! *" +
                                "* ! ! * ! ! * !" +
                                "! * ! * ! * ! !" +
                                "! ! * * * ! ! !" +
                                "* * * W * * * *" +
                                "! ! * * * ! ! !" +
                                "! * ! * ! * ! !" +
                                "* ! ! * ! ! * !" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementQueen())
        
    }
    
    func testQueenCannotMoveToInvalidPositionFromTopLeft(){
        
        let board = ASCIIBoard( "W * * * * * * *" +
                                "* * ! ! ! ! ! !" +
                                "* ! * ! ! ! ! !" +
                                "* ! ! * ! ! ! !" +
                                "* ! ! ! * ! ! !" +
                                "* ! ! ! ! * ! !" +
                                "* ! ! ! ! ! * !" +
                                "* ! ! ! ! ! ! *" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementQueen())
        
    }
    
    func testQueenCannotMoveToInvalidPositionFromTopRight(){
        
        let board = ASCIIBoard( "* * * * * * * W" +
                                "! ! ! ! ! ! * *" +
                                "! ! ! ! ! * ! *" +
                                "! ! ! ! * ! ! *" +
                                "! ! ! * ! ! ! *" +
                                "! ! * ! ! ! ! *" +
                                "! * ! ! ! ! ! *" +
                                "* ! ! ! ! ! ! *" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementQueen())
        
    }
    
    func testQueenCannotMoveToInvalidPositionFromBottomLeft(){
        
        let board = ASCIIBoard( "* ! ! ! ! ! ! *" +
                                "* ! ! ! ! ! * !" +
                                "* ! ! ! ! * ! !" +
                                "* ! ! ! * ! ! !" +
                                "* ! ! * ! ! ! !" +
                                "* ! * ! ! ! ! !" +
                                "* * ! ! ! ! ! !" +
                                "W * * * * * * *" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementQueen())
        
    }
    
    func testQueenCannotMoveToInvalidPositionFromBottomRight(){
        
        let board = ASCIIBoard( "* ! ! ! ! ! ! *" +
                                "! * ! ! ! ! ! *" +
                                "! ! * ! ! ! ! *" +
                                "! ! ! * ! ! ! *" +
                                "! ! ! ! * ! ! *" +
                                "! ! ! ! ! * ! *" +
                                "! ! ! ! ! ! * *" +
                                "* * * * * * * W" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementQueen())
        
    }
    
    // MARK: - Rook Movement
    
    func testRookCannotMoveToInvalidPositionFromCentre(){
        
        let board = ASCIIBoard( "! ! ! * ! ! ! !" +
                                "! ! ! * ! ! ! !" +
                                "! ! ! * ! ! ! !" +
                                "! ! ! * ! ! ! !" +
                                "* * * W * * * *" +
                                "! ! ! * ! ! ! !" +
                                "! ! ! * ! ! ! !" +
                                "! ! ! * ! ! ! !" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementRook())
        
    }
    
    func testRookCannotMoveToInvalidPositionFromTopLeft(){
        
        let board = ASCIIBoard( "W * * * * * * *" +
                                "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementRook())
        
    }
    
    func testRookCannotMoveToInvalidPositionFromTopRight(){
        
        let board = ASCIIBoard( "* * * * * * * W" +
                                "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementRook())
        
    }
    
    func testRookCannotMoveToInvalidPositionFromBottomLeft(){
        
        let board = ASCIIBoard( "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" +
                                "W * * * * * * *" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementRook())
        
    }
    
    func testRookCannotMoveToInvalidPositionFromBottomRight(){
        
        let board = ASCIIBoard( "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! ! *" +
                                "* * * * * * * W" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementRook())
        
    }
    
    // MARK: - Bishop movement
    
    func testBishopCannotMoveToInvalidPositionFromCentre(){
        
        let board = ASCIIBoard( "! ! ! ! ! ! ! *" +
                                "* ! ! ! ! ! * !" +
                                "! * ! ! ! * ! !" +
                                "! ! * ! * ! ! !" +
                                "! ! ! W ! ! ! !" +
                                "! ! * ! * ! ! !" +
                                "! * ! ! ! * ! !" +
                                "* ! ! ! ! ! * !" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementBishop())
        
    }
    
    func testBishopCannotMoveToInvalidPositionFromTopLeft(){
        
        let board = ASCIIBoard( "W ! ! ! ! ! ! !" +
                                "! * ! ! ! ! ! !" +
                                "! ! * ! ! ! ! !" +
                                "! ! ! * ! ! ! !" +
                                "! ! ! ! * ! ! !" +
                                "! ! ! ! ! * ! !" +
                                "! ! ! ! ! ! * !" +
                                "! ! ! ! ! ! ! *" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementBishop())
        
    }
    
    func testBishopCannotMoveToInvalidPositionFromTopRight(){
        
        let board = ASCIIBoard( "! ! ! ! ! ! ! W" +
                                "! ! ! ! ! ! * !" +
                                "! ! ! ! ! * ! !" +
                                "! ! ! ! * ! ! !" +
                                "! ! ! * ! ! ! !" +
                                "! ! * ! ! ! ! !" +
                                "! * ! ! ! ! ! !" +
                                "* ! ! ! ! ! ! !" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementBishop())
        
    }
    
    func testBishopCannotMoveToInvalidPositionFromBottomLeft(){
        
        let board = ASCIIBoard( "! ! ! ! ! ! ! *" +
                                "! ! ! ! ! ! * !" +
                                "! ! ! ! ! * ! !" +
                                "! ! ! ! * ! ! !" +
                                "! ! ! * ! ! ! !" +
                                "! ! * ! ! ! ! !" +
                                "! * ! ! ! ! ! !" +
                                "W ! ! ! ! ! ! !" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementBishop())
        
    }
    
    func testBishopCannotMoveToInvalidPositionFromBottomRight(){
        
        let board = ASCIIBoard( "* ! ! ! ! ! ! !" +
                                "! * ! ! ! ! ! !" +
                                "! ! * ! ! ! ! !" +
                                "! ! ! * ! ! ! !" +
                                "! ! ! ! * ! ! !" +
                                "! ! ! ! ! * ! !" +
                                "! ! ! ! ! ! * !" +
                                "! ! ! ! ! ! ! W" )
        
        testBoard(board: board, movingPiece: "W", movement: PieceMovementBishop())
        
    }


}
