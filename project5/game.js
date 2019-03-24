var numCards = 12;
var selectedCount = 0;
var deck = [];
var cardImages = ["BCE1.png", "BCE2.png", "BCE3.png", "BCF1.png", "BCF2.png", "BCF3.png", "BCS1.png", "BCS2.png", "BCS3.png", "BSE1.png", "BSE2.png", "BSE3.png", "BSF1.png", "BSF2.png", "BSF3.png", "BSS1.png", "BSS2.png", "BSS3.png", "BTE1.png", "BTE2.png", "BTE3.png", "BTF1.png", "BTF2.png", "BTF3.png", "BTS1.png", "BTS2.png", "BTS3.png", "GCE1.png", "GCE2.png", "GCE3.png", "GCF1.png", "GCF2.png", "GCF3.png", "GCS1.png", "GCS2.png", "GCS3.png", "GSE1.png", "GSE2.png", "GSE3.png", "GSF1.png", "GSF2.png", "GSF3.png", "GSS1.png", "GSS2.png", "GSS3.png", "GTE1.png", "GTE2.png", "GTE3.png", "GTF1.png", "GTF2.png", "GTF3.png", "GTS1.png", "GTS2.png", "GTS3.png", "RCE1.png", "RCE2.png", "RCE3.png", "RCF1.png", "RCF2.png", "RCF3.png", "RCS1.png", "RCS2.png", "RCS3.png", "RSE1.png", "RSE2.png", "RSE3.png", "RSF1.png", "RSF2.png", "RSF3.png", "RSS1.png", "RSS2.png", "RSS3.png", "RTE1.png", "RTE2.png", "RTE3.png", "RTF1.png", "RTF2.png", "RTF3.png", "RTS1.png", "RTS2.png", "RTS3.png"];

document.getElementById("reset").addEventListener("click", function(){
    document.getElementById("message").innerHTML = "You have reset the game.";
});

document.getElementById("hint").addEventListener("click", function(){
    document.getElementById("message").innerHTML = "Here is a hint.";
});

// Function that creates a Card object
function Card(color, shape, shading, number) {
    this.color = color;
    this.shape = shape;
    this.shading = shading;
    this.number = number;
}

// Currently written to display the first 12 cards in the cardImages deck
// Will have to be changed to display shuffled cards
function getImages() {
    for (var i = 0; i < numCards; i++) {
        var img = document.createElement("img");
        img.src = "card_images/" + cardImages[i];
        img.classList.add("card");
        var src = document.getElementById("table-grid");
        src.appendChild(img);
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

function createCardListeners() {

    var cards = document.querySelectorAll(".card");
    for (var i = 0; i < cards.length; i++) {
        cards[i].addEventListener("click", function() {
            if (this.classList.contains("hint")) {
                this.classList.remove("hint");
            }
            if (this.classList.contains("selected")) {
                selectedCount--;
            }
            else {
                selectedCount++;
            }
            this.classList.toggle("selected");
            if (selectedCount == 3) {
                window.alert("You have selected a set.");
                // Check if 3 cards are actually a set here
                selectedCount = deselectCards(cards);
            }
            console.log(selectedCount);
        });
    }

}

var colorEnum = {
    RED: 0,
    GREEN: 1,
    BLUE: 2,
    properties: {
        0: {name: "RED", value: "0", code: "R"},
        1: {name: "GREEN", value: "1", code: "G"},
        2: {name: "BLUE", value: "2", code: "B"}
    }
};

var shapeEnum = {
    CIRCLE: 0,
    SQUARE: 1,
    TRIANGLE: 2,
    properties: {
        0: {name: "CIRCLE", value: "0", code: "C"},
        1: {name: "SQUARE", value: "1", code: "S"},
        2: {name: "TRIANGLE", value: "2", code: "T"}
    }
};

var shadeEnum = {
    EMPTY: 0,
    FILLED: 1,
    STRIPE: 2,
    properties: {
        0: {name: "EMPTY", value: "0", code: "E"},
        1: {name: "FILLED", value: "1", code: "F"},
        2: {name: "STRIPE", value: "2", code: "S"}
    }
};

var numberEnum = {
    SINGLE: 0,
    DOUBLE: 1,
    TRIO: 2,
    properties: {
        0: {value: "0", code: "1"},
        1: {value: "1", code: "2"},
        2: {value: "2", code: "3"}
    }
};

function createDeck(deck) {

    for (var i = 0; i <= 2; i++) {
        for (var j = 0; j <= 2; j++) {
            for (var k = 0; k <= 2; k++) {
                for (var l = 0; l <= 2; l++) {
                    /* var card = { color: i,
                                 shape: j,
                                 size: k,
                                 number: l,
                                 // png: colorEnum.properties.+ ".png"
                                }; */
                    deck.push(new Card(i, j, k, l));
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
  

getImages();
createCardListeners();
createDeck(deck);
shuffleDeck(deck);
console.log(deck);