arg_list = argv ();

if nargin < 2
  printf("Usage: create.m name ir1 ir2 ... irN\n")
  exit(1)
end

number_of_irs = nargin - 1;
printf("Name: %s\n", arg_list{1})
printf("Number of IRs: %d\n", number_of_irs)

system(sprintf("cat manifest_template.ttl | sed -e 's/COLLECTION/%s/g' | sed -e 's/NUMBER_OF_IRS/%d/g' > manifest.ttl", arg_list{1}, number_of_irs));

system(sprintf("cat plugin_template.ttl | sed -e 's/COLLECTION/%s/g' | sed -e 's/NUMBER_OF_IRS/%d/g' > plugin.ttl", arg_list{1}, number_of_irs));

system(sprintf("cat plugin_template.cc | sed -e 's/COLLECTION/%s/g' | sed -e 's/NUMBER_OF_IRS/%d/g' > plugin.cc", arg_list{1}, number_of_irs));


