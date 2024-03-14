#include <stdio.h>
#include <stdlib.h>

#include <sndfile.h>

int main(int argc, char *argv[]) {
  if (argc < 3) {
    printf("Usage: wav2c filename suffix\n");
    return EXIT_FAILURE;
  }

  SF_INFO info;

  SNDFILE* ret = sf_open(argv[1], SFM_READ, &info);
  if (ret == NULL) {
    printf("Failed to open file: %s. Exiting.\n", argv[1]);
    return EXIT_FAILURE;
  }

  if (info.channels != 1) {
    printf("Only mono supported. Exiting.\n");
    return EXIT_FAILURE;
  }

  float samples[info.frames];

  sf_count_t samples_read = sf_read_float(ret, samples, info.frames);

  if (samples_read != info.frames) {
    printf("Something went wrong reading samples. Exiting.\n");
    return EXIT_FAILURE;
  }

  printf("static float sample_data%s[] = {\n", argv[2]);

  for (unsigned frame = 0; frame < info.frames; ++frame) {
    printf("  %.24f,\n", samples[frame]);
  }

  printf("};\n");

  printf ("struct IR IR%s = { %d, %ld, sample_data%s };\n", argv[2], info.samplerate, info.frames, argv[2]);

  return EXIT_SUCCESS;
}
