// Avança o frame manualmente
heart_frame += heart_speed;
if (heart_frame >= sprite_get_number(Sheart)) {
    heart_frame = 0;
}

var player = instance_find(Omarcelo, 0);

if (instance_exists(player)) {
		switch (player.hp) {
        case 3: heart_speed = 0.05; break; // calmo
        case 2: heart_speed = 0.15; break; // médio
        case 1: heart_speed = 0.35; break; // rápido
    }
    for (var i = 0; i < player.hp_max; i++) {
        if (i < player.hp) {
            draw_sprite(Sheart, floor(heart_frame), 16 + (i * 50), 16);
        } else {
            shader_set(sh_grayscale);
            draw_sprite(SheartDie, floor(heart_frame), 16 + (i * 50), 16);
            shader_reset();
        }
    }
}