#include <stdio.h>
#include <stdlib.h>

#include <sndfile.h>

int main(int argc, char *argv[]) {
  if (argc < 3) {
    printf("Usage: wav2c filename varname\n");
    return EXIT_FAILURE;
  }

  SF_INFO info;

  SNDFILE* ret = sf_open(argv[1], SFM_READ, &info);
  if (ret == NULL) {
    printf("Failed to open file: %s. Exiting.\n", argv[1]);
    return EXIT_FAILURE;
  }

  if (info.channels != 1) {
    printf("Only mono supported. Exiting\n");
    return EXIT_FAILURE;
  }

  float samples[info.frames];

  sf_read_float(ret, samples, info.frames);

  printf("static float %s[] = {\n", argv[2]);

  for (unsigned frame = 0; frame < info.frames; ++frame) {
    printf("  %.24f", samples[frame]);
    if (frame != info.frames - 1) {
      printf(",");
    }
    printf("\n");
  }

  printf("};\n");

  return EXIT_SUCCESS;
}
