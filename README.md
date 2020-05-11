# PrerenderBackground_S 

A unity scene trying to use prerender image as background. It tries to recreate graphics similar to old games such as resident evil or 
final fantasy in the 90s. Using depth buffer from rendered images to map the distance of objects, and decide whether an object is blocked
by "foreground" or not.

ref:

https://github.com/SpookyFM/DepthCompositing

https://www.alanzucconi.com/2019/01/01/parallax-shader/

created using ver. 2019.3.11f

problems: Object distance doesn't match with render image. (Maybe caused by nonlinear depth map image project to clip space)
