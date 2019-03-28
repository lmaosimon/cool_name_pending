//TODO: Be able to detect when the game is over.
//TODO: Reset player scores when the game is reset.
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

function startGame() {
    numCards = 12;
    deck = [];
    table = [];
    createDeck(deck);
    initializeTable();
    updateTableDisplay();
    createCardListeners();
}

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
}

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
    while (i < numCards) {
        var img = document.createElement("img");
        console.log(table);
        img.src = "card_images/" + table[i].png;
        img.classList.add("card");
        var src = document.getElementById("table-grid");
        src.appendChild(img);
        i++;
    }
}

function removeTable() {
    var imgDiv = document.getElementById("table-grid");
    while (imgDiv.firstChild) {
        imgDiv.removeChild(imgDiv.firstChild);
    }
}

function add3Cards() {
    for (var i = 0; i < 3; i++) {
        table.push(deck.splice(0, 1)[0]);
    }
}

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
        console.log("Hint count: " + hintCount);
        tableIndices = [];
        var cards = document.querySelectorAll(".card");
        deselectCards(cards);
        document.getElementById("message").innerHTML = "Here is a hint.";
        hintSet = findSet();
        hint(hintSet, cards, hintCount);
        hintCount++;
    });
}

function createCardListeners() {

    var cards = document.querySelectorAll(".card");
    tableIndices = [];
    console.log(cards);
    for (var i = 0; i < cards.length; i++) {
        cards[i].addEventListener("click", function() {

            document.getElementById("message").innerHTML = "";

            if (this.classList.contains("selected")) { // If deselecting a card
                this.classList.remove("selected");
                removeTableIndex(tableIndices, getTableIndex(cards, this));
                console.log(tableIndices);
            }
            else { // If selecting a card
                if (this.classList.contains("hint")) {
                    this.classList.remove("hint");
                }
                this.classList.add("selected");
                tableIndices.push(getTableIndex(cards, this));
                console.log(tableIndices);
                if (tableIndices.length == 3) {
                    var aSet = false;
                    aSet = isASet(tableIndices);
                    console.log(table);
                    if (aSet) {
                        updateScore();
                        var set = [table[tableIndices[0]], table[tableIndices[1]], table[tableIndices[2]]];
                        removeSetAdd3ToTable(set);
                        document.getElementById("message").innerHTML = "You have found a set!";
                        removeTable();
                        updateTableDisplay();
                        createCardListeners();
                    }
                    else {
                        document.getElementById("message").innerHTML = "That is not a set. Try again!";
                    }
                    console.log(table);
                    deselectCards(cards);
                    tableIndices = [];
                }
            }
            
        });
    }
}

function deselectCards(cards) {
    for (var i = 0; i < cards.length; i++) {
        if (cards[i].classList.contains("selected")) {
            cards[i].classList.remove("selected");
        }
    }
}

function getTableIndex(cards, clicked) {
    var tableIndex;
    cards.forEach(function(card, i) {
        if (clicked == card) {
            tableIndex = i;
        }
    });
    return tableIndex;
}

function removeTableIndex(tableIndices, tableIndex) {
    tableIndices.forEach(function(elem, i) {
        if (elem == tableIndex) {
            console.log(i);
            tableIndices.splice(i, 1);
        }
    });
}

// Add a new card for each card on table that was part of a set, or only removes set cards if table size > 12
function removeSetAdd3ToTable (set) {
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
    } else {
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
    checkTableForSet();
}

// Check that some set does exist on the table, add 3 cards if not
function checkTableForSet() {
    var setExist = findSet();
    if (setExist.length == 0) {
        removeTable();
        add3Cards();
        numCards += 3;
        createCardListeners();
        return false;
    }
    return true;
    // As the game of set is played, 3 extra cards will now be present on the table until the game concludes
}

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

createResetAndHintEventListeners();
startGame();
