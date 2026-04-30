//estados do player
enum PlayerState {
    IDLE,
    WALK,
	ATTACK,
	HURT  

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

// i-frames
invincible = false;
inv_timer = 0;
inv_duration = 60;

// knockback recebido
knockback = 0;
knock_dir = 0;


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
	
	attack_started = false;
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
	
	attack_started = false;
}

function state_attack() {

    // 🔥 só roda uma vez ao entrar no estado
    if (!attack_started) {
        
        attack_started = true;

        switch (dir) {
            case Dir.DOWN: sprite_index = SplayerFrontAttack; break;
            case Dir.UP:   sprite_index = SplayerBackAttack;  break;
            case Dir.SIDE: sprite_index = SplayerSideAttack;  break;
        }

        image_index = 0;     // 🔥 reseta animação
        image_speed = 1.5;
		
		  // 🔥 CRIAR HITBOX
	    var _range = 16;
		var _hx = x;
		var _hy = y;

		if (dir == Dir.DOWN)  _hy += _range;
		if (dir == Dir.UP)    _hy -= _range;
		if (dir == Dir.SIDE)  _hx -= (_range * image_xscale); // 🔥 corrigido

		var hit = instance_create_layer(_hx, _hy, "Player", OplayerHitbox);
		hit.owner = id;
		hit.dir = dir;
    }

    // quando termina animação
    if (image_index >= image_number - 1) {
        
        attack_started = false; // 🔥 libera pra próxima vez
        state = PlayerState.IDLE;
    }
}

function state_hurt() {
    hsp = 0;
    vsp = 0;
    
    switch (dir) {
            case Dir.DOWN: sprite_index = SplayerFrontHit; break;
            case Dir.UP:   sprite_index = SplayerBackHit;  break;
            case Dir.SIDE: sprite_index = SplayerSideHit;  break;
        }
    // aplica knockback
    if (knockback > 0.5) {
        var _kx = lengthdir_x(knockback, knock_dir);
        var _ky = lengthdir_y(knockback, knock_dir);
        if (!place_meeting(x + _kx, y, Ocolisor)) x += _kx;
        if (!place_meeting(x, y + _ky, Ocolisor)) y += _ky;
        knockback *= 0.8;
    } else {
        knockback = 0;
        state = PlayerState.IDLE; // 🔥 só volta ao idle quando knockback acabar
    }
}

function take_damage(_amount, _dir) {
    if (invincible) exit;
    
    hp -= _amount;
    knockback = 5;
    knock_dir = _dir;
    invincible = true;
    inv_timer = inv_duration;
    state = PlayerState.HURT; // 🔥 essa linha estava faltando
    
    if (hp <= 0) {
        hp = 0;
        game_restart();
    }
}