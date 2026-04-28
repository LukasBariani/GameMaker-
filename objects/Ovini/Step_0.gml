// Verifica se o objeto bateu na borda esquerda ou direita
if (x <= 0) or (x >= room_width - sprite_width) {
    hspeed = -hspeed;   // Inverte a direção horizontal
}

// Verifica se o objeto bateu na borda superior ou inferior
if (y <= 0) or (y >= room_height - sprite_height) {
    vspeed = -vspeed;   // Inverte a direção vertical
}

// (Opcional) Corrige a posição para evitar que o objeto fique "grudado" na borda
x = clamp(x, 0, room_width - sprite_width);
y = clamp(y, 0, room_height - sprite_height);