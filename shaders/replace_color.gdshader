shader_type canvas_item;

uniform sampler2D team_palette;
uniform int team_color;

vec2 px_to_vu(ivec2 pos, ivec2 tex_size) {
	return vec2(
		(float(pos[0]) + 0.5) / float(tex_size[0]),  
		(float(pos[1]) + 0.5) / float(tex_size[1])
		);
}

vec4 get_palette_color(vec4 color, sampler2D palette, int selection) {
	ivec2 tex_size = textureSize(team_palette, 0);
	texture(palette, vec2(3, 4));
	return color;
}

void fragment() {
	COLOR = get_palette_color(COLOR, team_palette, team_color);
}
