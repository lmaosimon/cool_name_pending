var numCards = 12;
var selectedCount = 0;
var deck = [];
var table = [];
/*var cardImages = ["BCE1.png", "BCE2.png", "BCE3.png", "BCF1.png", "BCF2.png", "BCF3.png", "BCS1.png", "BCS2.png", "BCS3.png",
 "BSE1.png", "BSE2.png", "BSE3.png", "BSF1.png", "BSF2.png", "BSF3.png", "BSS1.png", "BSS2.png", "BSS3.png", "BTE1.png", "BTE2.png",
  "BTE3.png", "BTF1.png", "BTF2.png", "BTF3.png", "BTS1.png", "BTS2.png", "BTS3.png", "GCE1.png", "GCE2.png", "GCE3.png", "GCF1.png",
   "GCF2.png", "GCF3.png", "GCS1.png", "GCS2.png", "GCS3.png", "GSE1.png", "GSE2.png", "GSE3.png", "GSF1.png", "GSF2.png", "GSF3.png",
    "GSS1.png", "GSS2.png", "GSS3.png", "GTE1.png", "GTE2.png", "GTE3.png", "GTF1.png", "GTF2.png", "GTF3.png", "GTS1.png", "GTS2.png",
     "GTS3.png", "RCE1.png", "RCE2.png", "RCE3.png", "RCF1.png", "RCF2.png", "RCF3.png", "RCS1.png", "RCS2.png", "RCS3.png", "RSE1.png",
      "RSE2.png", "RSE3.png", "RSF1.png", "RSF2.png", "RSF3.png", "RSS1.png", "RSS2.png", "RSS3.png", "RTE1.png", "RTE2.png", "RTE3.png",
       "RTF1.png", "RTF2.png", "RTF3.png", "RTS1.png", "RTS2.png", "RTS3.png"];*/

document.getElementById("reset").addEventListener("click", function(){
    document.getElementById("message").innerHTML = "You have reset the game.";
});

document.getElementById("hint").addEventListener("click", function(){
    document.getElementById("message").innerHTML = "Here is a hint.";
});

// Function that creates a Card object
function Card(color, shape, shading, number, png) {
    this.color = color;
    this.shape = shape;
    this.shading = shading;
    this.number = number;
    this.png = png;
}

// Currently written to display the first 12 cards in the cardImages deck
function createTable() {
    var i = 0;
    while (i < numCards) {
        var img = document.createElement("img");
        img.src = "card_images/" + deck[0].png;
        img.classList.add("card");
        var src = document.getElementById("table-grid");
        src.appendChild(img);
        table[i] = deck.shift(); // Move card from deck to table
        i++;
    }
}

function deselectCards(cards) {
    for (var i = 0; i < cards.length; i++) {
        if (cards[i].classList.contains("selected")) {
            cards[i].classList.remove("selected");
        }
    }
    return 0;
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

function removeSetFromTable (set) {
    var spliceI;
    var i = 0;
    while (i < 3) {
        table.forEach(function(elem, j) {
            if (set[i] == table[j]) {
                spliceI = j;
            }
        });
        table.splice(spliceI, 1);
        i++;
    }
}

function createCardListeners() {

    
    var cards = document.querySelectorAll(".card");
    var tableIndices = [];
    console.log(cards);
    for (var i = 0; i < cards.length; i++) {
        cards[i].addEventListener("click", function() {

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
                    var aaSetSet = false;
                    aSet = isASet(tableIndices);
                    console.log(table);
                    if (aSet) {
                        var set = [table[tableIndices[0]], table[tableIndices[1]], table[tableIndices[2]]];
                        removeSetFromTable(set);
                        document.getElementById("message").innerHTML = "You have found a set!";
                    }
                    else {
                        document.getElementById("message").innerHTML = "That is not a set. Try again!";
                    }
                    console.log(table);
                    selectedCount = deselectCards(cards);
                    tableIndices = [];
                }
            }
            
        });
    }

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

var colorCode = ["R", "G", "B"];
var shapeCode = ["C", "S", "T"];
var shadeCode = ["E", "F", "S"];

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
  

createDeck(deck);
shuffleDeck(deck);
createTable();
createCardListeners();
console.log(table);
console.log(deck);