_left  = keyboard_check(vk_left);
_right = keyboard_check(vk_right);
_up    = keyboard_check(vk_up);
_down  = keyboard_check(vk_down);
_mouse = mouse_check_button_pressed(mb_left);

switch (state) {
    case PlayerState.IDLE:   state_idle();   break;
    case PlayerState.WALK:   state_walk();   break;
    case PlayerState.ATTACK: state_attack(); break;
}