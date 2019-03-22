var cards = document.querySelectorAll(".card");
var numCards = 12;

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