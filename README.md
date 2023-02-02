# sd-rocm
Stable Diffusion on AMD/Linux, using ROCm libraries

See 'make help' for instructions.

Notes:

In my first experiments, I used stable-diffusion-2.1-768 models only (used
customized list of what to download), and disabled nsfw filter which apparently
at least consumes more VRAM - in case of 768x768 image generation, this may
be necessary with 8GB VRAM graphics cards.

You need to accept the license, but you do not need the token (just press Enter).

All in all, there will be easily at least > 10GB of downloads during various phases
of the work. Additional downloads are done when starting the web UI, and when eg enabling
face restoration or upscaling functions.

First image generation Invoke after startup may stay halted at step 0 for two minutes
or so (python process 100% CPU) before proceeding to actually use the GPU for computation.
