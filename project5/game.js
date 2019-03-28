//TODO: Be able to detect when the game is over and avoid undefined values.
//TODO: Add comments.

var numCards = 12;
var deck;
var table;
var tableIndices;
var colorCode = ["R", "G", "B"];
var shapeCode = ["C", "S", "T"];
var shadeCode = ["E", "F", "S"];

// Function that creates a Card object
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

//
function setScoresZero() {
    var scores = document.getElementsByClassName("score");
    i = 0;
    while (i < scores.length) {
        scores[i].innerHTML = "0";
        i++;
    }
}

//
function updateScore() {
    var player = prompt("Please enter your player number:", 1);
    if (player == "1" || player == "2" || player == "3" || player == "4") {
        var scoreTxt = document.getElementById("score" + player).innerHTML;
        var score = Number(scoreTxt) + 1;
        document.getElementById("score" + player).innerHTML = score.toString();
    } else {
        alert("The player number you entered was invalid. Point was not recorded.");
    }
}


//FIXME: right now this will detect when the game is over but does nothing to stop game from trying to pull from empty deck
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

//
function createDeck(deck) {
    for (var i = 0; i <= 2; i++) {
        for (var j = 0; j <= 2; j++) {
            for (var k = 0; k <= 2; k++) {
                for (var l = 1; l <= 3; l++) {
                    var png = colorCode[i] + shapeCode[j] + shadeCode[k] + l + ".png";
                    deck.push(new Card(i, j, k, l, png));
                }
            }
        }
    }
    shuffleDeck(deck);
    //FIXME:
    deck.splice(0, 69);
}

//
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

//
function initializeTable() {
    // Add the initially desired number of cards to the table
    var i = 0;
    while (i < numCards) {
        table[i] = deck.pop(); // Move card from deck to table
        i++;
    }
    checkTableForSet();
}

// Currently written to display the first 12 cards in the cardImages deck
function updateTableDisplay() {
    var i = 0;
    console.log(table);
    while (i < table.length) {
        var img = document.createElement("img");
        img.src = "card_images/" + table[i].png;
        img.classList.add("card");
        var src = document.getElementById("table-grid");
        src.appendChild(img);
        i++;
    }
}

//
function removeTable() {
    var imgDiv = document.getElementById("table-grid");
    while (imgDiv.firstChild) {
        imgDiv.removeChild(imgDiv.firstChild);
    }
}

//
function add3Cards() {
    for (var i = 0; i < 3; i++) {
        table.push(deck.splice(0, 1)[0]);
    }
}

//
function getTableIndex(cards, clicked) {
    var tableIndex;
    cards.forEach(function(card, i) {
        if (clicked == card) {
            tableIndex = i;
        }
    });
    return tableIndex;
}

//
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
    checkTableForSet();
}

// Check that some set does exist on the table, add 3 cards if not
function checkTableForSet() {
    var setExist = findSet();
    if (setExist.length == 0 && deck.length > 0) {
        removeTable();
        add3Cards();
        numCards += 3;
        createCardListeners();
        return false;
    }
    return true;
    // As the game of set is played, 3 extra cards will now be present on the table until the game concludes
}


/*
    The following set of functions create event listeners for specific scenarios in the Game interface.
*/

//
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
        if (hintCount === 4) {
            hintCount = 1;
        }
        tableIndices = [];
        var cards = document.querySelectorAll(".card");
        deselectCards(cards);
        document.getElementById("message").innerHTML = "Here is a hint.";
        hintSet = findSet();
        hint(hintSet, cards, hintCount);
        hintCount++;
    });
}

//
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
                if (tableIndices.length == 3) {
                    var aSet = false;
                    aSet = isASet(tableIndices);
                    if (aSet) {
                        updateScore();
                        var set = [table[tableIndices[0]], table[tableIndices[1]], table[tableIndices[2]]];
                        removeSetAdd3ToTable(set);
                        document.getElementById("message").innerHTML = "You have found a set!";
                        removeTable();
                        updateTableDisplay();
                        createCardListeners();
                        console.log(isGameOver());
                        if (isGameOver()) {
                            if (window.confirm("GAME OVER! Confirm to reset the game.")) {
                                startGame();
                            }
                        }
                    }
                    else {
                        document.getElementById("message").innerHTML = "That is not a set. Try again!";
                    }
                    deselectCards(cards);
                    tableIndices = [];
                }
            }
            
        });
    }
}

//
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

// Returns an empty set if the table does not contain a set.
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

//
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