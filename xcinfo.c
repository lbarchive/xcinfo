/**
 * Written by Yu-Jie Lin on 9/11/2011
 * Public Domain
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <X11/Xlib.h>
#include <X11/extensions/Xfixes.h>


#define VERSION "0.3.0"


void
print_usage(FILE *out, char *cmd)
{
  fprintf(out, "Usage: %s [-v | -h] [-i usecs]\n", cmd);
}


void
print_help()
{
  printf("Options:\n\
\n\
-i      querying interval in microseconds\n\
-v      version information\n\
-h      help message\n\
\n\
Output is:\n\
\n\
  \"x y sw sh cw ch cx cy\"\n\
\n\
x , y  : cursor position\n\
sw, sh : screen resolution\n\
cw, ch : cursor image size\n\
cx, cy : cursor hotspot position\n\
\n\
Written intentedly being used in shell script, e.g.\n\
\n\
  read x y sw sh cw ch cx cy <<< \"$(xcinfo)\"\n\
\n\
You can discard unneeded outputs, e.g.\n\
\n\
  read x y sw sh _ <<< \"$(xcinfo)\"\n\
\n\
");
}


int
main(int argc, char **argv)
{
  int opt;
  useconds_t interval;
  int scr;
  int sw, sh;
  int px, py;
  Display *dpy;
  Window w, rt;
  XFixesCursorImage *ci;

  interval = 0;
  while ((opt = getopt(argc, argv, "i:vh")) != -1) {
    switch (opt) {
    case 'i':
      interval = atoi(optarg);
      break;
    case 'v':
      printf(VERSION "\n");
      exit(EXIT_SUCCESS);
    case 'h':
      print_usage(stdout, argv[0]);
      printf("\n");
      print_help();
      exit(EXIT_SUCCESS);
    default:
      print_usage(stderr, argv[0]);
      exit(EXIT_FAILURE);
    }
  }

  dpy = XOpenDisplay(NULL);
  scr = DefaultScreen(dpy);
  rt  = RootWindow   (dpy, scr);

  do {
    sw  = DisplayWidth (dpy, scr);
    sh  = DisplayHeight(dpy, scr);

    ci = XFixesGetCursorImage(dpy);
    printf("%d %d %d %d %d %d %d %d\n",
           ci->x, ci->y,
           sw, sh,
           ci->width, ci->height,
           ci->xhot,  ci->yhot);
    fflush(stdout);
    XFree(ci);
  } while (interval && !usleep(interval));

  XCloseDisplay(dpy);
}
