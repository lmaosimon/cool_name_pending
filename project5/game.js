
/* THE GAME OF SET RELOADED
 * Authors: Patrick Hubbell, Gino Detore, and Sean Bower
 */

var numCards = 12;
var deck;
var table;
var tableIndices;

// Possible values for each attribute of a Card (does not include number)
var colorCode = ["R", "G", "B"];
var shapeCode = ["C", "S", "T"];
var shadeCode = ["E", "F", "S"];

// Constructor function to create a Card object
function Card(color, shape, shading, number, png) {
    this.color = color;
    this.shape = shape;
    this.shading = shading;
    this.number = number;
    this.png = png;
}


/*
    The following set of functions determine the start, end, and updates necessary for the Game to be actively played.
*/

// Calls all necessary functions to begin a new iteration of the game
function startGame() {
    numCards = 12;
    deck = [];
    table = [];
    createDeck(deck);
    initializeTable();
    updateTableDisplay();
    setScoresZero();
    createCardListeners();
}

// Sets all scores to 0 in the HTML
function setScoresZero() {
    var scores = document.getElementsByClassName("score");
    i = 0;
    while (i < scores.length) {
        scores[i].innerHTML = "0";
        i++;
    }
}

// Creates a prompt window where the Player can enter their associated numbers to keep track of the number of sets they find
function updateScore() {
    var player = prompt("Please enter your player number:", 1);
    if (player == "1" || player == "2" || player == "3" || player == "4") {
        // Updates the score in the HTML accordingly if a valid player name is given
        var scoreTxt = document.getElementById("score" + player).innerHTML;
        var score = Number(scoreTxt) + 1;
        document.getElementById("score" + player).innerHTML = score.toString();
    } else {
        // If an invalid number is given (not 1 through 4) the point is lost and this alert is displayed
        alert("The player number you entered was invalid. Point was not recorded.");
    }
}

// Detects when the game is over; looks for no possible set left on the Table and an empty deck
function isGameOver() {
    var gameOver = false;
    var aSet = findSet();
    if (deck.length == 0 && aSet.length == 0) {
        gameOver = true;
    }
    return gameOver;
}


/*
    The following set of functions manipulate the Deck for the Game model.
*/

// Builds an array of all 81 Card objects for each possible combination of color, shape, shade, and number
function createDeck(deck) {
    for (var i = 0; i <= 2; i++) {
        for (var j = 0; j <= 2; j++) {
            for (var k = 0; k <= 2; k++) {
                for (var l = 1; l <= 3; l++) {
                    // Creates the png code per Card that will be used to find its associated picture file
                    var png = colorCode[i] + shapeCode[j] + shadeCode[k] + l + ".png";
                    deck.push(new Card(i, j, k, l, png));
                }
            }
        }
    }
    // Removes the inherent ordering in the Deck
    shuffleDeck(deck);
    deck.splice(0, 69);
}

// Randomly shuffles the current Cards in the Deck array to avoid any ordering
function shuffleDeck(deck) {
    var currentI = deck.length, tempVal, randI;
  
    // While there remain elements to shuffle...
    while (0 !== currentI) {
  
      // Pick a remaining element...
      randI = Math.floor(Math.random() * currentI);
      currentI -= 1;
  
      // And swap it with the current element.
      tempVal = deck[currentI];
      deck[currentI] = deck[randI];
      deck[randI] = tempVal;
    }
    return deck;
}


/*
    The following set of functions manipulate the Table for the Game model.
*/

// Adds a number of Cards to the Table array representing the Cards in play to start the Game; draws from the Deck
function initializeTable() {
    // Add the initially desired number of cards to the table
    var i = 0;
    while (i < numCards) {
        table[i] = deck.pop(); // Move card from deck to table
        i++;
    }
    checkTableForSet();
}

// Updates the images for the current Cards on the table by referring to the Table array
function updateTableDisplay() {
    var i = 0;
    console.log(table);
    while (i < table.length) {
        var img = document.createElement("img");

        // Uses the png code in each Card object to find the associated image
        img.src = "card_images/" + table[i].png;
        img.classList.add("card");
        var src = document.getElementById("table-grid");

        // Adds the image to the table grid in the HTML
        src.appendChild(img);
        i++;
    }
}

// Clears all Card images from the table grid in the HTML
function removeTable() {
    var imgDiv = document.getElementById("table-grid");
    while (imgDiv.firstChild) {
        imgDiv.removeChild(imgDiv.firstChild);
    }
}

// Adds 3 Cards from the Deck to the Table
function add3Cards() {
    for (var i = 0; i < 3; i++) {
        table.push(deck.splice(0, 1)[0]);
    }
}

// Adds a Card's index in the Table array to the array that tracks indices of selected Cards; needed for select event
function getTableIndex(cards, clicked) {
    var tableIndex;
    cards.forEach(function(card, i) {
        if (clicked == card) {
            tableIndex = i;
        }
    });
    return tableIndex;
}

// Removes a Card's index in the Table array from the array that tracks indices of selected Cards; needed for deselect event
function removeTableIndex(tableIndices, tableIndex) {
    tableIndices.forEach(function(elem, i) {
        if (elem == tableIndex) {
            tableIndices.splice(i, 1);
        }
    });
}

// Add a new card for each card on table that was part of a set, or only removes set cards if table size > 12
function removeSetAdd3ToTable (set) {
    console.log("Hello World!");
    var i = 0;
    if (numCards > 12) {
        // Only removes 3 cards from the table, does not replace; decreases number of cards on table by 3
        while (i < 3) {
            table.forEach(function(elem, j) {
                if (set[i] == table[j]) {
                    table.splice(j, 1)
                }
            });
            i++;
        }
        numCards -= 3;
    } else if (deck.length > 0) {
        // Replaces the 3 cards removed for the set
        while (i < 3) {
            table.forEach(function(elem, j) {
                if (set[i] == table[j]) {
                    table[j] = deck.pop();
                }
            });
            i++;
        }
    }
    else {
        var temp = [];
        for (var k = 0; k < table.length; k++) {
            if (set[0] != table[k] && set[1] != table[k] && set[2] != table[k]) {
                temp.push(table[k]);
            }
        }
        table.length -= 3;
        numCards -= 3;
        for (var l = 0; l < table.length; l++) {
            table[l] = temp[l];
        }
        console.log(table);
    }
    // Ensures that there is some possible Set on the Table once Cards have been replaced or added
    checkTableForSet();
}

// Checks that some set does exist on the table, adds 3 cards if not
function checkTableForSet() {
    var setExist = findSet();
    if (setExist.length == 0 && deck.length > 0) {
        removeTable();
        add3Cards();
        numCards += 3;
        createCardListeners();
    }
}


/*
    The following set of functions create event listeners for specific scenarios in the Game interface.
*/

// Adds event listeners for the buttons corresponding to Reset and Hint events
function createResetAndHintEventListeners() {

    var hintCount = 1;

    // Reset button event listener
    document.getElementById("reset").addEventListener("click", function(){
        removeTable();
        startGame();
        document.getElementById("message").innerHTML = "You have reset the game.";
    });
    
    // Hint button event listener
    document.getElementById("hint").addEventListener("click", function(){

        // If hints are continually requested, resets the hint count to 1 and starts again
        if (hintCount === 4) {
            hintCount = 1;
        }

        // Resets hint counter if a possible Set is selected or the Game is reset
        if (document.getElementById("message").innerHTML == "You have found a set!") {
            hintCount = 1;
        } else if (document.getElementById("message").innerHTML == "That is not a set. Try again!") {
            hintCount = 1;
        } else if (document.getElementById("message").innerHTML == "You have reset the game.") {
            hintCount = 1;
        }

        tableIndices = [];
        var cards = document.querySelectorAll(".card");

        // Any Cards selected on the Table when a hint is requested are deselected
        deselectCards(cards);
        document.getElementById("message").innerHTML = "Here is a hint.";
        hintSet = findSet();
        hint(hintSet, cards, hintCount);
        hintCount++;
    });
}

// Creates listeners for each Card on Table, updates appropriately and reacts to all possible events with Cards
function createCardListeners() {
    var cards = document.querySelectorAll(".card");
    tableIndices = [];
    
    for (var i = 0; i < cards.length; i++) {
        cards[i].addEventListener("click", function() {

            document.getElementById("message").innerHTML = "";

            if (this.classList.contains("selected")) { // If deselecting a card
                this.classList.remove("selected");
                removeTableIndex(tableIndices, getTableIndex(cards, this));
            }
            else { // If selecting a card
                if (this.classList.contains("hint")) {
                    this.classList.remove("hint");
                }
                this.classList.add("selected");
                tableIndices.push(getTableIndex(cards, this));

                // Checks for a Set once 3 Cards are selected
                if (tableIndices.length == 3) {
                    var aSet = false;
                    aSet = isASet(tableIndices);
                    if (aSet) { // If a Set is found
                        updateScore();
                        var set = [table[tableIndices[0]], table[tableIndices[1]], table[tableIndices[2]]];
                        removeSetAdd3ToTable(set);
                        document.getElementById("message").innerHTML = "You have found a set!";
                        removeTable();
                        updateTableDisplay();
                        createCardListeners();
                        console.log(isGameOver());
                        if (isGameOver()) {
                            window.alert("GAME OVER! Click to reset the game.");
                            removeTable();
                            startGame();
                        }
                    }
                    else { // If the 3 selected Cards are not a Set
                        document.getElementById("message").innerHTML = "That is not a set. Try again!";
                    }
                    deselectCards(cards);
                    tableIndices = [];
                }
            } 
        });
    }
}

// Removes the styling for selected Cards if they are deselected
function deselectCards(cards) {
    for (var i = 0; i < cards.length; i++) {
        if (cards[i].classList.contains("selected")) {
            cards[i].classList.remove("selected");
        }
    }
}


/*
    The following set of functions are helper methods for the Game model.
*/

// Takes a set of Card indices on the Table and determines whether or not they are a Set
function isASet(tableIndices) {
    var isASet = false;
    if (((table[tableIndices[0]].color + table[tableIndices[1]].color + table[tableIndices[2]].color) % 3 == 0) && 
    ((table[tableIndices[0]].shape + table[tableIndices[1]].shape + table[tableIndices[2]].shape) % 3 == 0) && 
    ((table[tableIndices[0]].shading + table[tableIndices[1]].shading + table[tableIndices[2]].shading) % 3 == 0) &&
    ((table[tableIndices[0]].number + table[tableIndices[1]].number + table[tableIndices[2]].number) % 3 == 0)) {
        isASet = true;
    } 
    return isASet;
}

// Returns some Set that exists on the Table; returns an empty array if the Table does not contain a Set
function findSet() {
    var set = [];
    i = 0;

    while (i < table.length) {
        set[0] = i;
        var j = i + 1;
        while (j < table.length) {
            set[1] = j;
            var k = j + 1;
            while (k < table.length) {
                set[2] = k;
                if (isASet(set)) {
                    return set;
                }
                k++;
            }
            j++;
        }
        i++;
    }
    return [];
}

// Incrementally highlights a possible Set on the Table when the Hint button is clicked
function hint(hintSet, cards, hintCount) {
    i = 0;
    while (i < hintCount) {
        if (cards[hintSet[i]].classList.contains("selected")) {
            document.getElementById("message").innerHTML("You must deselect all cards before getting a hint.");
        }
        else {
            cards[hintSet[i]].classList.add("hint");
            i++;
        }
    }
}


/*
    The Game begins.
*/

createResetAndHintEventListeners();
startGame();