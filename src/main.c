#include <libdragon.h>

int main(void) {
    /* Initialize peripherals */
    display_init(RESOLUTION_320x240, DEPTH_32_BPP, 2, GAMMA_NONE, FILTERS_RESAMPLE);
    dfs_init(DFS_DEFAULT_LOCATION);
    controller_init();

    /* Read in sprite */
    sprite_t *saucisse = sprite_load("rom://saucisse.sprite");

    /* Main loop test */
    while (true) {
        char tStr[256];
        static surface_t* disp = NULL;

        /* Grab a render buffer */
        disp = display_get();

        /*Fill the screen */
        graphics_fill_screen(disp, 0);

        sprintf(tStr, "Saucisse !");
        graphics_draw_text(disp, 20, 20, tStr);

        /* Display sprite (16bpp ones will only display in 16bpp mode, same with 32bpp) */
        graphics_draw_sprite(disp, 64, 64, saucisse);

        display_show(disp);
    }
}
