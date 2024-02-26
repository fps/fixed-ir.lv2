# printf ("%s", program_name ());
arg_list = argv ();
printf("struct IR { float sample_rate; unsigned n_samples; float sample_data[]; };\n\n")


for i = 1:nargin
  printf("struct IR IR%d = {\n", i)
  [sample_data, sample_rate] = audioread(arg_list{i});
  printf("  %f,\n", sample_rate);
  printf("  %d,\n", size(sample_data, 1));
  printf("  {\n");
  for j = 1:size(sample_data, 1)
    printf("    %.18f,\n", sample_data(j, 1));
  endfor
  printf("  }\n");
  printf("};\n\n");
endfor
printf("struct IR *IRs[] = {\n")
for i = 1:nargin
  printf("  &IR%d,\n", i);
endfor
printf("};\n")
