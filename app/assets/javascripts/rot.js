/* set up ROT library */
ROT.DEFAULT_WIDTH = 80;
ROT.DEFAULT_HEIGHT = 30;
var display = new ROT.Display({width: ROT.DEFAULT_WIDTH, height: ROT.DEFAULT_HEIGHT, fontSize: 36});
document.getElementById("canvasContainer").appendChild(display.getContainer());

var data, player, goal, pickaxe = false, level = 0, gold = 0;

/* function to determine if (x,y) is open or a wall */
var lightPasses = function(x, y) {
  var key = x+","+y;
  if (key in data) { return (data[key] !== 1); }
  return false;
};

/* redraw the map; called after each step */
function redraw() {
  var fov = new ROT.FOV.PreciseShadowcasting(lightPasses);

  /* use ROT.js to compute visibility and draw the map */
  fov.compute(player.x, player.y, 10, function(x, y, r, visibility) {
    var ch = "", key = x+","+y;
    if(data[key] === 0) { ch = " "; }
    if(data[key] === 2) { ch = "o"; }
    if(!r) { ch = pickaxe ? "#" : "@"; }
    if(goal.x == x && goal.y == y) { ch = "X"; }
    var bgColor = ["#333", "#AAA", "#333"][data[key]];
    var fgColor = ["#FFF", "#AAA", "#ECFF67"][data[key]];
    display.draw(x, y+1, ch, fgColor, bgColor);
  });
  display.drawText(0,  0, "Level " + level + ", Gold " + gold);
}

/* create a new level with walls, start point, and goal */
function createMap() {
  /* clear and output help text */
  display.clear();
  level++;
  //display.drawText(0,  ROT.DEFAULT_HEIGHT-1, "Made with rot.js (https://ondras.github.io/rot.js)");

  /* use ROT.js to generate a new wall dictionary */
  data = {};
  var freeSpaces = [];
  new ROT.Map.Digger(ROT.DEFAULT_WIDTH, ROT.DEFAULT_HEIGHT-1).create(function(x, y, type) {
    data[x+","+y] = type;
    if(type === 0) { freeSpaces.push(x+","+y); }
  });
  /* shuffle the free spaces */
  for (let i = freeSpaces.length - 1; i > 0; i--){
    const j = Math.floor(Math.random() * i);
    const temp = freeSpaces[i];
    freeSpaces[i] = freeSpaces[j];
    freeSpaces[j] = temp;
  }

  /* pick a start location from available free spaces */
  var coords = freeSpaces[0].split(",");
  player = {x: +coords[0], y: +coords[1]};
  /* reset pickaxe on every new level */
  pickaxe = false;

  /* pick a goal location from available free spaces */
  coords = freeSpaces[1].split(",");
  goal = {x: +coords[0], y: +coords[1]};

  /* every 30 blocks there's a gold */
  for (let i = 2; i <= freeSpaces.length / 30; i++) {
    data[freeSpaces[i]] = 2;
  }
  redraw();
}

/* create the first level */
createMap();

document.addEventListener("keydown", function(e) {
  var newPos = { x: player.x, y: player.y };

  /* calculate new position based on step direction */
  if ([ROT.KEYS.VK_LEFT, ROT.KEYS.VK_H, ROT.KEYS.VK_A].indexOf(e.keyCode) !== -1) { newPos.x-=1; }
  if ([ROT.KEYS.VK_RIGHT, ROT.KEYS.VK_L, ROT.KEYS.VK_D].indexOf(e.keyCode) !== -1) { newPos.x+=1; }
  if ([ROT.KEYS.VK_UP, ROT.KEYS.VK_K, ROT.KEYS.VK_W].indexOf(e.keyCode) !== -1) { newPos.y-=1; }
  if ([ROT.KEYS.VK_DOWN, ROT.KEYS.VK_J, ROT.KEYS.VK_S].indexOf(e.keyCode) !== -1) { newPos.y+=1; }

  /* toggle pickaxe */
  if ([ROT.KEYS.VK_P].indexOf(e.keyCode) !== -1) { pickaxe = !pickaxe; }

  /* if the target space is clear, move there */
  posS = newPos.x + "," + newPos.y;
  if(data[posS] === 0) {
    player.x = newPos.x; player.y = newPos.y;
  } else if(data[posS] === 2) {
    gold++;
    data[posS] = 0;
    player.x = newPos.x; player.y = newPos.y;
  } else if (data[posS] === 1 && pickaxe) {
    /* if the target space is a wall AND the player is using the pickaxe, dig */
    data[posS] = 0;
    player.x = newPos.x; player.y = newPos.y;
  }

  /* redraw the level */
  redraw();

  /* if we made it to the goal, make a new level */
  if (player.x == goal.x && player.y == goal.y) { createMap(); }

  /* Don't scroll the page if the arrow keys are pressed */
  e.preventDefault();
});
