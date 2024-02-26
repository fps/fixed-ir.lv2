# printf ("%s", program_name ());
arg_list = argv ();
printf("struct IR { float sample_rate; unsigned n_samples; float *sample_data; };\n\n")


for i = 1:nargin
  printf("static float sample_data%d[] = {\n", i)
  [sample_data, sample_rate] = audioread(arg_list{i});
  for j = 1:size(sample_data, 1)
    printf("  %.24f,\n", sample_data(j, 1));
  end
  printf("};\n\n");
end
printf("static struct IR IRs[] = {\n")
for i = 1:nargin
  printf("  {\n");
  printf("    %f,\n", sample_rate);
  printf("    %d,\n", size(sample_data, 1));
  printf("    sample_data%d,\n", i)
  printf("  },\n")
end
printf("};\n\n");
printf("static unsigned n_IR = %d;\n\n", nargin);

