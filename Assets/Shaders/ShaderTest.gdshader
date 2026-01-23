shader_type canvas_item;

uniform float scale : hint_range(0.1, 10.0) = 2.0;

void vertex() {
	if (VERTEX.y < 0.0) {
		//VERTEX += vec2(sin(TIME * 2.0) * 100.0, 0.0);
	}
}

void fragment() {
	vec2 resolution = 1.0 / TEXTURE_PIXEL_SIZE;
	vec2 uv = (UV * resolution * 2.0 - resolution) / resolution.y;
	vec2 uv0 = uv;
	vec3 finalColor = vec3(0.0);;
	
	for(float i = 0.0; i < 2.0; i++) {
		uv = fract(uv * 1.5) - 0.5;
		vec3 col = vec3(1.0, 0.4, 0.5);
		float r = abs(sin(length(uv) * 10.0 + TIME) / 3.0);
		r = 0.1 / r;
		finalColor += col * r;
	}
	
	vec4 original = texture(TEXTURE, UV);
	COLOR = vec4(finalColor, original.a);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
