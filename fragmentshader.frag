#ifdef GL_ES
precision mediump float;
#endif

//uniform vec2 u_resolution;
//uniform vec2 u_mouse;
//uniform float u_time;

void main() {

    vec2 u_resolution = vec2(u_width, u_height);

    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    // vec2 uv = gl_FragCoord.xy/u_mouse.xy;

    gl_FragColor = vec4(st + step(abs(sin(u_time)),st.x), 0.0, 1.0);

//     gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
}
