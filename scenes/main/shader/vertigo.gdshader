shader_type canvas_item;

uniform float alpha:hint_range(0.0, 0.8, 0.1) = 0.8;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_linear_mipmap;

void vertex(){
	VERTEX.x += 20.0*sin(TIME*5.0);
	VERTEX.y += 20.0*cos(TIME*5.0);
}
void fragment() {
	vec4 screen = texture(screen_texture,UV);
	COLOR.rgb = screen.rgb*vec3(2.5,2.5,2.5);
	COLOR.a = alpha;
	// Place fragment code here.
}
