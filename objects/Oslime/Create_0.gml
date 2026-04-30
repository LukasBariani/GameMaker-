// estados
enum SlimeState {
    IDLE,
    CHASE,
    ATTACK,
    HURT,
    DEAD
}

state = SlimeState.IDLE;

// alvo
target = Oplayer;

// movimento
spd = 1.5;
hsp = 0;
vsp = 0;
hit = false;


// combate
hp = 3;
attack_range = 20;
detect_range = 120;

attack_cooldown = 60;
attack_timer = 0;
attack_timer = attack_cooldown; 

// knockback
knockback = 0;
knock_dir = 0;

//states functions-----------------------------------------

function state_idle() {
    
    sprite_index = SslimeIdle;
    image_speed = 1;

    var _dist = point_distance(x, y, target.x, target.y);

    if (_dist < detect_range) {
        state = SlimeState.CHASE;
    }
}


function state_chase() {
    
    var _dir = point_direction(x, y, target.x, target.y);
    var _dist = point_distance(x, y, target.x, target.y);

    hsp = lengthdir_x(spd, _dir);
    vsp = lengthdir_y(spd, _dir);

    move_and_collide(hsp, vsp, Ocolisor);

    sprite_index = SslimeWalk;
    image_speed = 1;

    // virar sprite
    image_xscale = (target.x > x) ? 1 : -1;

    if (_dist < attack_range) {
        state = SlimeState.ATTACK;
    }

    if (_dist > detect_range) {
        state = SlimeState.IDLE;
    }
}


function state_attack() {
    
    hsp = 0;
    vsp = 0;

    sprite_index = SslimeAttack;
    image_speed = 1;

    attack_timer--;
	

    if (attack_timer <= 0) {
        
        attack_timer = attack_cooldown;

        if (point_distance(x, y, target.x, target.y) < attack_range) {
           with (target) {
				 take_damage(1, point_direction(other.x, other.y, x, y));
			}
        }
    }

    if (point_distance(x, y, target.x, target.y) > attack_range) {
        state = SlimeState.CHASE;
    }
} 
function state_hurt() {
    
    sprite_index = SslimeHurt;

    var _kx = lengthdir_x(knockback, knock_dir);
    var _ky = lengthdir_y(knockback, knock_dir);

    move_and_collide(_kx, _ky, Ocolisor);

    knockback *= 0.8;

    if (knockback < 0.5) {
        state = SlimeState.CHASE;
    }
}


function state_dead() {
    
    sprite_index = SslimeDeath;
    image_speed = 1;

    if (image_index >= image_number - 1) {
        instance_destroy();
    }
}




function take_damage(_amount, _dir) {

    if (state == SlimeState.DEAD) exit;
    if (state == SlimeState.HURT) exit; // 🔥 evita spam

    hp -= _amount;

    if (hp <= 0) {
        state = SlimeState.DEAD;
        exit;
    }

    knockback = 6;
    knock_dir = _dir;

    state = SlimeState.HURT;
}
