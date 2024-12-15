shader_type canvas_item;

const vec3 chroma_key_color = vec3(0.0, 0.85098, 0.043137);
const float pickup_range = 0.4;

void fragment() {
    vec4 color = texture(TEXTURE, UV);

    float distances = length(color.rgb - chroma_key_color);

    if (distances <= pickup_range) {
        discard;
    }

    COLOR = vec4(color.rgb, 1);
}
