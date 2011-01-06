var currentButton = null,
    buttons = [],
    ticksQueued = [],
    ticks = 0,
    score = 0,
    speed = 40,
    initialInterval = 1400,
    maximumMisses = 20;

function start() {
    console.log("Start");
    initialize();
    gameTicker.running = true;
}

function initialize() {
    ticks = 0;
    scoreDisplay.text = score = 0;
    ticksQueued = [];
    buttons = [greenButton, blueButton, yellowButton, redButton];
    buttons.forEach(function(button) {
        button.state = "";
    });
    gameTicker.interval = initialInterval;
    infoText.text = "Get ready...";
}

function handleClick(button) {
    if (!gameTicker.running) {
        return;
    }

    // Allow indexes to be passed as well
    if (typeof button == 'number') {
        button = buttons[button];
    }

    var item = ticksQueued.shift();
    if (!item || button.index != item.index) {
        gameOver();
        return;
    }

    // Clicked the right one
    scoreDisplay.text = ++score;
    button.state = "";
}

function gameOver() {
    console.log("Last interval: " + gameTicker.interval);
    gameTicker.running = false;
    buttons.forEach(function(button) {
        button.state = "dead";
    });
    infoText.text = "Game over! Press Space to restart.";
}

function enqueue(button) {
    ticksQueued.push(button);
    prettyPrintQueue();
    if (ticksQueued.length >= maximumMisses) {
        gameOver();
    }
}

function prettyPrintQueue() {
    var str = "";
    ticksQueued.forEach(function(item) {
        str += item.index + " ";
    });
    console.log(str);
}

function tick() {
    if (ticks == 0) {
        infoText.text = "";
    }

    ticks++;
    currentButton && (currentButton.state = "");
    currentButton = buttons[parseInt(Math.random() * buttons.length)];
    currentButton.state = "hilighted";
    enqueue(currentButton);

    gameTicker.interval = Math.max(300, initialInterval - (0.1 * speed * (ticks * ticks/2)));
}
