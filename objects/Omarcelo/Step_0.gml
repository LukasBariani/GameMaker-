if keyboard_check(vk_up)    { y -= velocidade; }
if keyboard_check(vk_down)  { y += velocidade; }
if keyboard_check(vk_left)  { x -= velocidade; }
if keyboard_check(vk_right) { x += velocidade; }

if keyboard_check(vk_anykey) {
    sprite_index = Smarcelo_run;
} else {
    sprite_index = Smarcelo;
}



if (android == 3) {
    room_goto_next();
}

x = clamp(x, sprite_width / 2, room_width - sprite_width / 2);
y = clamp(y, sprite_height / 2, room_height - sprite_height / 2);

// Timer de invencibilidade
if (invincivel) {
    inv_timer--;
    if (inv_timer <= 0) invincivel = false;
}


if (hp <= 0) {
    instance_destroy();
    room_restart();
}