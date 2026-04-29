//estados do player
enum PlayerState {
    IDLE,
    WALK,
	ATTACK
}

state = PlayerState.IDLE;

//direçao q o player ta oiando
enum Dir {
    DOWN,
    UP,
    SIDE
}

dir = Dir.DOWN;
hp = 10;
spd = 2;
hsp = 0;
vsp = 0;


// funções
function state_idle() {
    hsp = 0;
    vsp = 0;

    switch (dir) {
        case Dir.DOWN: sprite_index = SplayerFrontIdle; break;
        case Dir.UP:   sprite_index = SplayerBackIdle;  break;
        case Dir.SIDE: sprite_index = SplayerSideIdle;  break;
    }

    if (_mouse) {
        state = PlayerState.ATTACK;
        exit;
    }
    if (_left || _right || _up || _down) {
        state = PlayerState.WALK;
    }
}

function state_walk() {

    var _h = (_right ? 1 : 0) - (_left ? 1 : 0);
    var _v = (_down ? 1 : 0) - (_up ? 1 : 0);

    if (_mouse){
        state = PlayerState.ATTACK;
        exit;
    }

    if (_h == 0 && _v == 0) {
        state = PlayerState.IDLE;
        exit;
    }

    // direção
    if (_h != 0) {
        dir = Dir.SIDE;
        image_xscale = (_h > 0) ? -1 : 1;
    }
    if (_v > 0) dir = Dir.DOWN;
    if (_v < 0) dir = Dir.UP;

    // sprite
    switch (dir) {
        case Dir.DOWN: sprite_index = SplayerFrontWalk; break;
        case Dir.UP:   sprite_index = SplayerBackWalk; break;
        case Dir.SIDE: sprite_index = SplayerSideWalk; break;
    }

    // movimento correto
    hsp = _h * spd;
    vsp = _v * spd;

    if (_h != 0 && _v != 0) {
        hsp *= 0.7071;
        vsp *= 0.7071;
    }

    if (!place_meeting(x + hsp, y, Ocolisor)) x += hsp;
    if (!place_meeting(x, y + vsp, Ocolisor)) y += vsp;
}

function state_attack() {
    switch (dir) {
        case Dir.DOWN: sprite_index = SplayerFrontAttack; break;
        case Dir.UP:   sprite_index = SplayerBackAttack;  break;
        case Dir.SIDE: sprite_index = SplayerSideAttack;  break;
    }

    //  image_speed garante que a animação roda
    image_speed = 1;

    // image_number - 1 pode falhar, usa > com margem
    if (image_index >= image_number - 1) {
        image_index = 0;
        image_speed = 1;
        state = PlayerState.IDLE;
    }
}

    // quando terminar animação
    if (image_index >= image_number - 1) {
        state = PlayerState.IDLE;
    }
