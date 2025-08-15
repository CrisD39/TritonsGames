shader_type canvas_item;

uniform vec4 key_color : source_color = vec4(1.0, 1.0, 1.0, 1.0); // Blanco
uniform float tolerance : hint_range(0.0, 1.0) = 0.1;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    if (distance(tex_color.rgb, key_color.rgb) < tolerance) {
        tex_color.a = 0.0; // Hace transparente
    }
    COLOR = tex_color;
}


//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
