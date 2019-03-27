//TODO: Add three cards to table (physical and visual table) when there is not a set in the table.
//TODO: Be able to detect when the game is over.
//TODO: Edit hint functionality to allow dynamically-added hints, also fix hint/select overlap
//TODO: (Optional) Change hint to display one hint first, then two if clicked again, then 3 if clicked again.
//TODO: (Optional) Add player functionality.

var numCards = 12;
var deck;
var table;
var colorCode = ["R", "G", "B"];
var shapeCode = ["C", "S", "T"];
var shadeCode = ["E", "F", "S"];
/*var cardImages = ["BCE1.png", "BCE2.png", "BCE3.png", "BCF1.png", "BCF2.png", "BCF3.png", "BCS1.png", "BCS2.png", "BCS3.png",
 "BSE1.png", "BSE2.png", "BSE3.png", "BSF1.png", "BSF2.png", "BSF3.png", "BSS1.png", "BSS2.png", "BSS3.png", "BTE1.png", "BTE2.png",
  "BTE3.png", "BTF1.png", "BTF2.png", "BTF3.png", "BTS1.png", "BTS2.png", "BTS3.png", "GCE1.png", "GCE2.png", "GCE3.png", "GCF1.png",
   "GCF2.png", "GCF3.png", "GCS1.png", "GCS2.png", "GCS3.png", "GSE1.png", "GSE2.png", "GSE3.png", "GSF1.png", "GSF2.png", "GSF3.png",
    "GSS1.png", "GSS2.png", "GSS3.png", "GTE1.png", "GTE2.png", "GTE3.png", "GTF1.png", "GTF2.png", "GTF3.png", "GTS1.png", "GTS2.png",
     "GTS3.png", "RCE1.png", "RCE2.png", "RCE3.png", "RCF1.png", "RCF2.png", "RCF3.png", "RCS1.png", "RCS2.png", "RCS3.png", "RSE1.png",
      "RSE2.png", "RSE3.png", "RSF1.png", "RSF2.png", "RSF3.png", "RSS1.png", "RSS2.png", "RSS3.png", "RTE1.png", "RTE2.png", "RTE3.png",
       "RTF1.png", "RTF2.png", "RTF3.png", "RTS1.png", "RTS2.png", "RTS3.png"];*/



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
    createResetAndHintEventListeners();
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
    table.push(deck.splice(0, 3));
}

function createResetAndHintEventListeners() {

    var hintCount = 3;

    document.getElementById("reset").addEventListener("click", function(){
        removeTable();
        startGame();
        document.getElementById("message").innerHTML = "You have reset the game.";
    });
    
    document.getElementById("hint").addEventListener("click", function(){
        var cards = document.querySelectorAll(".card");
        document.getElementById("message").innerHTML = "Here is a hint.";
        hintSet = findSet();
        hint(hintSet, cards, hintCount);
    });
}

function createCardListeners() {

    var cards = document.querySelectorAll(".card");
    var tableIndices = [];
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
        add3Cards();
        numCards += 3;
        removeTable();
        updateTableDisplay();
        createCardListeners();
    }
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
  
startGame();
