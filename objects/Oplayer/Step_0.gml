// inputs
_left  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
_up    = keyboard_check(vk_up)    || keyboard_check(ord("W"));
_down  = keyboard_check(vk_down)  || keyboard_check(ord("S"));
_mouse = mouse_check_button_pressed(mb_left);

// i-frames (piscar) — roda sempre, independente do estado
if (invincible) {
    inv_timer--;
    image_alpha = (inv_timer mod 6 < 3) ? 0.3 : 1.0;
    if (inv_timer <= 0) {
        invincible = false;
        image_alpha = 1.0;
    }
}

if(hp == 0 ){
	room_restart()
}
// máquina de estados
switch (state) {
    case PlayerState.IDLE:   state_idle();   break;
    case PlayerState.WALK:   state_walk();   break;
    case PlayerState.ATTACK: state_attack(); break;
    case PlayerState.HURT:   state_hurt();   break; // 🔥
}