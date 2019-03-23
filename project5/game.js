var numCards = 12;
var selectedCount = 0;
var deck = [];

document.getElementById("reset").addEventListener("click", function(){
    document.getElementById("message").innerHTML = "You have reset the game.";
});

document.getElementById("hint").addEventListener("click", function(){
    document.getElementById("message").innerHTML = "Here is a hint.";
});

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
                    var card = { color: i,
                                 shape: j,
                                 size: k,
                                 number: l,
                                 // png: colorEnum.properties.+ ".png"
                                };
                    deck.push(card);
                }
            }
        }
    }

}

createCardListeners();
createDeck(deck);
console.log(deck);