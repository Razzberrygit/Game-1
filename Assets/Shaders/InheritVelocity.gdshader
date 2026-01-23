shader_type particles;

uniform vec2 parentVelocity;

void start() {
	VELOCITY += vec3(parentVelocity, VELOCITY.z);
}

void process() {
	
}