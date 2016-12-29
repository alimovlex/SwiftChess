//
//  GameViewController.swift
//  SwiftChess
//
//  Created by Steve Barnegren on 04/09/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import SwiftChess

class GameViewController: UIViewController {
    
    @IBOutlet weak var boardView: BoardView!
    var pieceViews = [PieceView]()
    var game: Game!
    var selectedIndex: Int? {
        didSet{
            updatePieceViewSelectedStates()
        }
    }
    
    var promotionSelectionViewController: PromotionSelectionViewController?
    
    var hasMadeInitialAppearance = false
    
    // MARK: - Creation
    
    class func gameViewController(game: Game) -> GameViewController{
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let className = "GameViewController"
        let gameViewController: GameViewController = storyboard.instantiateViewController(withIdentifier: className) as! GameViewController
        gameViewController.game = game;
        return gameViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Board View
        boardView.delegate = self
        
        // Game
        self.game.board.printBoardState()
        game.delegate = self
        
        // Add initial piece views
        for location in BoardLocation.all {
            
            guard let piece = game.board.getPiece(at: location) else {
                continue
            }
            
            addPieceView(at: location.x, y: location.y, piece: piece)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Take go if the first player is an AI player
        if !self.hasMadeInitialAppearance {
            if let player = game.currentPlayer as? AIPlayer {
                player.makeMove()
            }
        }
    }
    
    // MARK: - Manage Piece Views
    
    func addPieceView(at x: Int, y: Int, piece: Piece) {
        
        let location = BoardLocation(x: x, y: y)
        
        let pieceView = PieceView(piece: piece, location: location)
        boardView.addSubview(pieceView)
        pieceViews.append(pieceView)
    }
    
    func removePieceView(withTag tag: Int) {
        
        if let pieceView = pieceViewWithTag(tag) {
            removePieceView(pieceView: pieceView)
        }
    }
    
    func removePieceView(pieceView: PieceView) {
        
        if let index = pieceViews.index(of: pieceView) {
            pieceViews.remove(at: index)
        }
        
        if pieceView.superview != nil {
            pieceView.removeFromSuperview()
        }
    }
    
    func updatePieceViewSelectedStates() {
        
        for pieceView in pieceViews {
            pieceView.selected = (pieceView.location.index == selectedIndex)
        }
    }
    
    func pieceViewWithTag(_ tag: Int) -> PieceView? {
        
        for pieceView in pieceViews {
            
            if pieceView.piece.tag == tag {
                return pieceView
            }
        }
        
        return nil;
    }
    
    // MARK: - Layout
    
    override func viewDidLayoutSubviews() {
        
        // Layout pieces
        for pieceView in pieceViews {
            
            let gridX = pieceView.location.x
            let gridY = 7 - pieceView.location.y
            
            let width = boardView.bounds.size.width / 8
            let height = boardView.bounds.size.height / 8
            
            pieceView.frame = CGRect(x: CGFloat(gridX) * width,
                                     y: CGFloat(gridY) * height,
                                     width: width,
                                     height: height)
        }
        
        // Layout promotion selection view controller
        if let promotionSelectionViewController = promotionSelectionViewController {
            
            let margin = CGFloat(40)
            promotionSelectionViewController.view.frame = CGRect(x: margin,
                                                                 y: margin,
                                                                 width: view.bounds.size.width - (margin*2),
                                                                 height: view.bounds.size.height - (margin*2))
        }
    }
    
    // MARK: - Alerts
    
    func showAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}

// MARK: - Board view delegate

extension GameViewController: BoardViewDelegate {
    
    func touchedSquareAtIndex(_ boardView: BoardView, index: Int) {
        
        print("GVC touched square at index \(index)")
        
        // Get the player (must be human)
        guard let player = game.currentPlayer as? Human else {
            return;
        }
        
        let location = BoardLocation(index: index)
        
        // If has tapped the same piece again, deselect it
        if let selectedIndex = selectedIndex {
            if location == BoardLocation(index: selectedIndex) {
                self.selectedIndex = nil
                return
            }
        }
        
        // Select new piece if possible
        if player.occupiesSquareAt(location: location) {
            selectedIndex = index
        }
        
        // If there is a selected piece, see if it can move to the new location
        if let selectedIndex = selectedIndex {
            
            do {
                try player.movePiece(fromLocation: BoardLocation(index: selectedIndex),
                                     toLocation: location)
                
            } catch Player.MoveError.pieceUnableToMoveToLocation {
                print("Piece is unable to move to this location")
                
            } catch Player.MoveError.cannotMoveInToCheck{
                print("Player cannot move in to check")
                showAlert(title: "😜", message: "Player cannot move in to check")
                
            } catch Player.MoveError.playerMustMoveOutOfCheck{
                print("Player must move out of check")
                showAlert(title: "🙃", message: "Player must move out of check")
                
            } catch {
                print("Something went wrong!")
                return
            }
            
        }
        
    }
    
}

// MARK - GameDelegate

extension GameViewController: GameDelegate {
    
    public func gameWillBeginUpdates(game: Game) {
        // Do nothing
    }
    
    func gameDidAddPiece(game: Game) {
        // do nothing
    }

    func gameDidMovePiece(game: Game, piece: Piece, toLocation: BoardLocation) {
        
        guard let pieceView = pieceViewWithTag(piece.tag) else {
            return
        }
        
        pieceView.location = toLocation
        
        // Animage
        view.setNeedsLayout()
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    func gameDidRemovePiece(game: Game, piece: Piece, location: BoardLocation) {
        
        guard let pieceView = pieceViewWithTag(piece.tag) else {
            return
        }
        
        // Fade out and remove
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            pieceView.alpha = 0
        }, completion: {
            (finished: Bool) in
            self.removePieceView(withTag: piece.tag)
        })
        
    }
    
    func gameDidTransformPiece(game: Game, piece: Piece, location: BoardLocation) {
        
        guard let pieceView = pieceViewWithTag(piece.tag) else {
            return
        }
        
        pieceView.piece = piece
    }
    
    func gameDidEndUpdates(game: Game) {
        // do nothing
    }
    
    func gameWonByPlayer(game: Game, player: Player) {
        
        let colorName = player.color.toString()
        
        let title = "Checkmate!"
        let message = "\(colorName.capitalized) wins!"
        
        showAlert(title: title, message: message)
    }
    
    func gameEndedInStaleMate(game: Game) {
        showAlert(title: "Stalemate", message: "Player cannot move")
    }
    
    func gameDidChangeCurrentPlayer(game: Game) {
        
        // Deselect selected piece
        self.selectedIndex = nil;
        
        // Tell AI to take go
        if let _ = game.currentPlayer as? AIPlayer {
            perform(#selector(tellAIToTakeGo), with: nil, afterDelay: 1)
        }
    }
    
    func tellAIToTakeGo() {
        
        if let player =  game.currentPlayer as? AIPlayer {
            player.makeMove()
        }
    }
    
    func promotedTypeForPawn(location: BoardLocation, player: Human, possiblePromotions: [Piece.PieceType], callback: @escaping (Piece.PieceType) -> Void) {
        
        boardView.isUserInteractionEnabled = false
        
        let viewController = PromotionSelectionViewController.promotionSelectionViewController(pawnLocation: location, possibleTypes: possiblePromotions) {
            
            self.promotionSelectionViewController?.view.removeFromSuperview()
            self.promotionSelectionViewController?.removeFromParentViewController()
            self.boardView.isUserInteractionEnabled = true
            callback($0)
        }
        
        view.addSubview(viewController.view)
        addChildViewController(viewController)
        promotionSelectionViewController = viewController
    }

}



