
library(tidyverse)

# Generate a shoe of cards that contains a multiple of decks
gen_deck <- function(decks=6){
  rep(c(1:9, 0, 0, 0, 0), each = 4*decks) # A-9, 10-K valued at 0
}

# Calculate the value of a hand
value_hand <- function(hand){
  return(sum(hand) %% 10)
}

# Determine the winner
determine_winner <- function(player, banker){
  if (value_hand(player) > value_hand(banker)){
    return("Player")
  }else if (value_hand(banker) > value_hand(player)){
    return("Banker")
  }else{
    return("Tie")
  }
}

# Play a round of baccarat, return the winner
play_round <- function(deck){
  # Shuffle the deck
  deck <- sample(deck)
  
  # Deal the player's hand
  player_hand <- deck[1:2]
  
  # Deal the banker's hand
  banker_hand <- deck[3:4]
  
  # Remove the cards from the deck
  deck <- deck[-c(1:4)]
  
  # If either player has 8 or 9, end the round
  if (value_hand(player_hand) %in% c(8, 9)|value_hand(banker_hand) %in% c(8,9)){
    return(list(result = determine_winner(player_hand, banker_hand), player = player_hand, banker = banker_hand))
  }else{ # If not, determine whether a third card is drawn
    # Player decision
    player_3rd <- NA
    if (value_hand(player_hand) <= 5){
      player_3rd <- deck[1] # Draw the next card
      deck <- deck[-1] # Remove from the deck
    }
    
    # Complete the player's hand
    if(!is.na(player_3rd)){
      player_hand <- c(player_hand, player_3rd)
    }
    
    # Banker decision
    banker_3rd <- NA
    
    if (is.na(player_3rd)){ # If the player didn't draw
      if (value_hand(banker_hand) <= 5){ # Same rules as the player
        banker_3rd <- deck[1] # Draw the next card
        deck <- deck[-1] # Remove from the deck
      }
    }else{ # If the player drew
      if(value_hand(banker_hand) <= 2){ # If below 2, always draw
        banker_3rd <- deck[1] # Draw the next card
        deck <- deck[-1] # Remove from the deck
      }else if(value_hand(banker_hand) == 3){
        if (player_3rd != 8){
          banker_3rd <- deck[1] # Draw the next card
          deck <- deck[-1] # Remove from the deck
        }
      }else if(value_hand(banker_hand) == 4){
        if (player_3rd %in% 2:7){
          banker_3rd <- deck[1] # Draw the next card
          deck <- deck[-1] # Remove from the deck
        }
      }else if(value_hand(banker_hand) == 5){
        if (player_3rd %in% 4:7){
          banker_3rd <- deck[1] # Draw the next card
          deck <- deck[-1] # Remove from the deck
        }
      }else if(value_hand(banker_hand) == 6){
        if (player_3rd %in% 6:7){
          banker_3rd <- deck[1] # Draw the next card
          deck <- deck[-1] # Remove from the deck
        }
      }
    }
    # Complete the banker's  hand
    if(!is.na(banker_3rd)){
      banker_hand <- c(banker_hand, banker_3rd)
    }
    # Return the outcome 
    return(list(result = determine_winner(player_hand, banker_hand), player = player_hand, banker = banker_hand))
  }
}

# Standard payoffs
standard_payoff <- function(choice, outcome, wager){
  # Check the result
  if (outcome$result == "Tie"){ #If tie, then pushed
    if (choice == "Tie"){
      return(wager + 8*wager)
    }else{
      return(wager)
    }
  }else{ # If not a tie
    if(outcome$result == choice&choice == "Player"){ # If player, pay 1-to-1
      return(wager + wager)
    }else if(outcome$result == choice&choice == "Banker"){ # If banker, pay 19-to-20
      return(wager + (19/20)*wager)
    }else{ # Otherwise, return nothing
      return(0)
    }
  }
}

# Broken payoffs
broken_payoff <- function(choice, outcome, wager){
  # Check the result
  if (outcome$result == "Tie"){ #If tie, then pushed
    if (choice == "Tie"){
      return(wager + 8*wager)
    }else{
      return(wager)
    }
  }else{ # If not a tie
    if(outcome$result == choice&choice == "Player"){ # If player, pay 1-to-1
      return(wager + wager)
    }else if(outcome$result == choice&choice == "Banker"){ # If banker, pay 1-to-1
      return(wager + wager)
    }else{ # Otherwise, return nothing
      return(0)
    }
  }
}

# EZ Baccarat/Dragon 7 payoffs
dragon_payoff <- function(choice, outcome, wager){
  # Check the result
  if (outcome$result == "Tie"){ #If tie, then pushed
    if (choice == "Tie"){
      return(wager + 8*wager)
    }else{
      return(wager)
    }
  }else{ # If not a tie
    if(outcome$result == choice&choice == "Player"){ # If player, pay 1-to-1
      return(wager + wager)
    }else if(outcome$result == choice&choice == "Banker"){ # If banker, pay 1-to-1 unless Dragon 7
      if (length(outcome$banker) == 3 & value_hand(outcome$banker) == 7){ # Push if Dragon 7
        return(wager)
      }else{
        return(wager + wager)
      }
    }else{ # Otherwise, return nothing
      return(0)
    }
  }
}
  
################################
## Simulation

# Regular Baccarat - Player
set.seed(60639)
iterations <- 3e5 # Number of iterations
regular_player <- map_dbl(1:iterations, function(x) standard_payoff("Player", play_round(gen_deck(6)), 100))

# House edge
(100 - mean(regular_player))/100

# Regular Baccarat - Banker
set.seed(60640)
iterations <- 3e5 # Number of iterations
regular_banker <- map_dbl(1:iterations, function(x) standard_payoff("Banker", play_round(gen_deck(6)), 100))

# House edge
(100 - mean(regular_banker))/100

# Regular Baccarat - Tie
set.seed(60615)
iterations <- 3e5 # Number of iterations
regular_tie <- map_dbl(1:iterations, function(x) standard_payoff("Tie", play_round(gen_deck(6)), 100))

# House edge
(100 - mean(regular_tie))/100

# Broken Baccarat - Banker
set.seed(60641)
iterations <- 3e5 # Number of iterations
broken_banker <- map_dbl(1:iterations, function(x) broken_payoff("Banker", play_round(gen_deck(6)), 100))

# House edge
(100 - mean(broken_banker))/100

# Dragon/EZ Baccarat - Banker
set.seed(60642)
iterations <- 3e5 # Number of iterations
dragon_banker <- map_dbl(1:iterations, function(x) dragon_payoff("Banker", play_round(gen_deck(6)), 100))

# House edge
(100 - mean(dragon_banker))/100
  
