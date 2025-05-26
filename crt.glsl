float random (vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123+iTime);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;

    uv = uv * 2.0 - 1.0;
    float r = length(uv);
    float s = 20.0;
    
    vec2 distorted = uv * (1.0 + s + r * r)/15.5;
    distorted += 1.0;
    distorted /= 2.0;
    
    vec4 image = texture(iChannel0, distorted);
    image.xyz -= clamp(sin(distorted.y*600.0+iTime*50.0), 0.0, 1.0)*0.2;
    image.xyz -= clamp(sin(distorted.y*300.0+iTime*50.0), 0.0, 1.0)*0.05;


    image += random(distorted)*0.25;
    
    image.r *= 0.0;
    image.g *= 1.3;
    image.b *= 1.0;
    image *= 0.8;
    float l = image.r + image.g + image.b;
    if (l>1.5)
    {
        image *= 1.8;
    } else {
        image *= 0.8;
    };
    // Output to screen
    fragColor = vec4(clamp(image, 0.1, 1.0));
}
