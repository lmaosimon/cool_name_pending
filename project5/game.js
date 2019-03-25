var numCards = 12;
var selectedCount = 0;
var deck = [];
var table = [];
/*var cardButtons = ["BCE1.png", "BCE2.png", "BCE3.png", "BCF1.png", "BCF2.png", "BCF3.png", "BCS1.png", "BCS2.png", "BCS3.png",
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

// Currently written to display the first 12 cards in the cardButtons deck
// Will have to be changed to display shuffled cards
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

function createCardListeners() {

    var currentIndex = 0;
    var cardButtons = []; // Holds tags of cards selected
    var cardHand = []; // Holds hand of cards selected
    var cards = document.querySelectorAll(".card");
    for (var i = 0; i < cards.length; i++) {
        cards[i].addEventListener("click", function() {
            cardButtons.push(this);
            if (this.classList.contains("hint")) {
                this.classList.remove("hint");
            }
            if (this.classList.contains("selected")) {
                removeCardFromHand(cardButtons[currentIndex], cardHand);
                selectedCount--;
                currentIndex++;
            }
            else {
                addToCardHand(cardButtons[currentIndex], cardHand);
                selectedCount++;
                currentIndex++;
            }
            this.classList.toggle("selected");
            if (selectedCount == 3) {
                if (isASet(cardHand)){
                    window.alert("You have selected a set.");
                }
                window.alert("Sorry, this is not a set.");
                selectedCount = deselectCards(cards);
                currentIndex -= 3;
            }
            console.log(selectedCount);
        });
    }

}

function removeCardFromHand(cardButton, cardHand) {
    console.log("BEFORE");
    console.log("0 : " + cardHand[0]);
    console.log("1 : " + cardHand[1]);
    console.log("2 : " + cardHand[2]);
    for (var i = 0; i < cardHand.length; i++) {
        var cardCode = decodeCard(cardButton.src);
        if (cardCode == cardHand[i].png) {
            cardHand[i] = null;
        }
    }
    console.log("AFTER");
    console.log("0 : " + cardHand[0]);
    console.log("1 : " + cardHand[1]);
    console.log("2 : " + cardHand[2]);
}

function addToCardHand(cardButton, cardHand) {
    var cardCode = decodeCard(cardButton.src);
    if (cardCode == cardHand.png) {
        cardHand.push(table[cardButton]);
    }
}

function decodeCard(cardButton) {
    var str = cardButton;
    var res = str.slice(-8);
    return res;
}

function isASet(cardHand) {
    if ((cardHand[0].color + cardHand[1].color + cardHand[2].color) % 3 == 0 && 
    (cardHand[0].shape + cardHand[1].shape + cardHand[2].shape) % 3 == 0 && 
    (cardHand[0].shade + cardHand[1].shade + cardHand[2].shade) % 3 == 0 &&
    (cardHand[0].number + cardHand[1].number + cardHand[2].number) % 3 == 0) {
        return true;
    } 
    return false;
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