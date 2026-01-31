shader_type canvas_item;

float Random(vec2 uv) {
    return fract(sin(dot(uv.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

void vertex() {
	if (VERTEX.y < 0.0) {
		VERTEX = (MODEL_MATRIX * vec4(VERTEX, 0.0, sin(Random(UV) * 10.0 + TIME * 3.0) * 0.001)).xy;
	}
}