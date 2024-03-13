arg_list = argv ();

if nargin < 2
  printf("Usage: create.m name ir1 ir2 ... irN\n")
  exit(1)
end

number_of_irs = nargin - 1;
printf("Name: %s\n", arg_list{1})
printf("Number of IRs: %d\n", number_of_irs)

plugin_dir = sprintf("lv2/fixed-ir-%s.lv2", arg_list{1})

system(sprintf("mkdir -p %s", plugin_dir))

system(sprintf("cat manifest_template.ttl | sed -e 's/COLLECTION/%s/g' | sed -e 's/NUMBER_OF_IRS/%d/g' > %s/manifest.ttl", arg_list{1}, number_of_irs, plugin_dir))

system(sprintf("cat plugin_template.ttl | sed -e 's/COLLECTION/%s/g' | sed -e 's/NUMBER_OF_IRS/%d/g' > %s/plugin.ttl", arg_list{1}, number_of_irs, plugin_dir))

system(sprintf("cat plugin_template.cc | sed -e 's/COLLECTION/%s/g' | sed -e 's/NUMBER_OF_IRS/%d/g' > plugin.cc", arg_list{1}, number_of_irs))

system(sprintf("cat makefile_template | sed -e 's/COLLECTION/%s/g' | sed -e 's;PLUGIN_DIR;%s;g' > makefile", arg_list{1}, plugin_dir))


