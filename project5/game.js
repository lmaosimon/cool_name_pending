var cards = document.querySelectorAll(".card");
var numCards = 12;

var deck = [];

document.getElementById("reset").addEventListener("click", function(){
    document.getElementById("message").innerHTML = "You have reset the game.";
});

document.getElementById("hint").addEventListener("click", function(){
    document.getElementById("message").innerHTML = "Here is a hint.";
});

for (var i = 0; i < cards.length; i++) {
    cards[i].addEventListener("click", function() {
        this.classList.add("selected");
    });
}

function createDeck(deck) {

    for (var i = 0; i <= 2; i++) {
        for (var j = 0; j <= 2; j++) {
            for (var k = 0; k <= 2; k++) {
                for (var l = 0; l <= 2; l++) {
                    var card = { color: i,
                                 shape: j,
                                 size: k,
                                 number: l };
                    deck.push(card);
                }
            }
        }
    }

}
                

createDeck(deck);
console.log(deck);