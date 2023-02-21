shader_type canvas_item;

void fragment() {
	if (COLOR.a != 0.0){
		COLOR.a = abs(sin(TIME*1.5))*COLOR.a;
	}
}
